DIRECTORY_TO_BUILD=$1

LAST_MERGE_COMMIT=$(git log --merges --pretty=format:’%h’ -n1 HEAD~1)

if [ -z $LAST_MERGE_COMMIT ]; then
  LAST_MERGE_COMMIT=HEAD^1
  echo "Could not find last merge commit - assuming HEAD^1"
else
  echo "Last merge commit: $LAST_MERGE_COMMIT"
fi

COMMITS_IN_DIR=`git log --oneline $LAST_MERGE_COMMIT..HEAD -- $DIRECTORY_TO_BUILD | wc -l`

if [ "$COMMITS_IN_DIR" -gt "0" ]; then
  echo "Changes detected; building $DIRECTORY_TO_BUILD"
else
  echo "No changes detected in $DIRECTORY_TO_BUILD; skipping build"
fi
