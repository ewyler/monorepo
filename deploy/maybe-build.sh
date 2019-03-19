set -o xtrace

DIRECTORY_TO_BUILD=$1

git diff $(git log --merges --pretty=format:’%h’ -n1 HEAD~1)…HEAD

echo $DIRECTORY_TO_BUILD

env

git log --oneline $COMMIT_RANGE -- $DIRECTORY_TO_BUILD