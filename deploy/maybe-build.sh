DIRECTORY_TO_BUILD=$1

# Assume master for now
LAST_MERGE_COMMIT=master
echo "Last merge commit: $LAST_MERGE_COMMIT"

COMMITS_IN_DIR=`git log --oneline $LAST_MERGE_COMMIT..HEAD -- $DIRECTORY_TO_BUILD | wc -l`

if [ "$COMMITS_IN_DIR" -gt "0" ]; then
  echo "Changes detected; building $DIRECTORY_TO_BUILD"
else
  echo "No changes detected in $DIRECTORY_TO_BUILD; skipping build"
fi
