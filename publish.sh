set -e
export DOCKER_BUILDKIT=1
# Config
export CURRENT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
export PROJECT_DIR="$CURRENT_DIRECTORY/.."
# . "$CURRENT_DIRECTORY/env/.env.$1"

#get highest tag number
VERSION=$(git describe --abbrev=0 --tags)

#replace . with space so can split into an array
VERSION_BITS=(${VERSION//./ })

#get number parts and increase last one by 1
VNUM1=${VERSION_BITS[0]}
VNUM2=${VERSION_BITS[1]}
VNUM3=${VERSION_BITS[2]}
VNUM1=$(echo $VNUM1 | sed 's/v//')

# Check for #major or #minor in commit message and increment the relevant version number
set +e
MAJOR=$(git log --format=%B -n 1 HEAD | grep '#major')
MINOR=$(git log --format=%B -n 1 HEAD | grep '#minor')

if [ "$MAJOR" ]; then
    echo "Update major version"
    VNUM1=$((VNUM1 + 1))
    VNUM2=0
    VNUM3=0
elif [ "$MINOR" ]; then
    echo "Update minor version"
    VNUM2=$((VNUM2 + 1))
    VNUM3=0
else
    echo "Update patch version"
    VNUM3=$((VNUM3 + 1))
fi

#create new tag
NEW_TAG="v$VNUM1.$VNUM2.$VNUM3"

echo "Updating $VERSION to $NEW_TAG"

#get current hash and see if it already has a tag
GIT_COMMIT=$(git rev-parse HEAD)
NEEDS_TAG=$(git describe --contains $GIT_COMMIT)

#only tag if no tag already (would be better if the git describe command above could have a silent option)
if [ -z "$NEEDS_TAG" ]; then
    echo "Tagged with $NEW_TAG (Ignoring fatal:cannot describe - this means commit is untagged) "
    git tag $NEW_TAG
    git push --tags
    export IMAGE_TAG=$NEW_TAG
else
    echo "Already has a tag on this commit"
    export IMAGE_TAG=$VERSION
fi
set -e
echo $IMAGE_TAG
API_IMAGE_NAME=napses/mvp-logstash
docker build . -t $API_IMAGE_NAME:$IMAGE_TAG -t $API_IMAGE_NAME:latest --build-arg NODE_ENV=$NODE_ENV
docker push $API_IMAGE_NAME --all-tags