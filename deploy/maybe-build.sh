set -o xtrace

DIRECTORY_TO_BUILD=$1

COMMIT_RANGE=$(echo $CIRCLE_COMPARE_URL | sed 's:^.*/compare/::g')

echo $CIRCLE_COMPARE_URL
echo $COMMIT_RANGE
echo $DIRECTORY_TO_BUILD

env

git log --oneline $COMMIT_RANGE -- $DIRECTORY_TO_BUILD