set -o xtrace

DIRECTORY_TO_BUILD=$1

MASTER_HASH=`git rev-parse master`
HEAD_HASH=`git rev-parse HEAD`

if [ "$MASTER_HASH" == "$HEAD_HASH" ]; then
  # Assume HEAD^1
  LAST_MERGE_COMMIT=HEAD^1
else
  # Assume master for now
  LAST_MERGE_COMMIT=master
fi

echo "Comparing changes against: $LAST_MERGE_COMMIT"

COMMITS_IN_DIR=`git log --oneline $LAST_MERGE_COMMIT..HEAD -- $DIRECTORY_TO_BUILD | wc -l`

if [ "$COMMITS_IN_DIR" -gt "0" ]; then
  echo "Changes detected; building $DIRECTORY_TO_BUILD"
else
  echo "No changes detected in $DIRECTORY_TO_BUILD; skipping build"
fi
