set -o xtrace

DIRECTORY_TO_BUILD=$1

LAST_MERGE_COMMIT=$(git log --merges --pretty=format:’%h’ -n1 HEAD~1)

if [ -z $LAST_MERGE_COMMIT ];
then
  LAST_MERGE_COMMIT=HEAD^1
fi

git log --oneline $LAST_MERGE_COMMIT..HEAD -- $DIRECTORY_TO_BUILD
