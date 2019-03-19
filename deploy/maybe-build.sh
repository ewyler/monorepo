set -o xtrace
set -e

DIRECTORY_TO_BUILD=$1

# Will be needed if we allow merge commits rather than requiring squashes on head - but we can probably
# just always require squashes for now
# git diff $(git log --merges --pretty=format:’%h’ -n1 HEAD~1)..HEAD

# Don't use master, circleCI does some weird stuff and moves it ahead of actual master
MASTER_HASH=`git rev-parse origin/master`
HEAD_HASH=`git rev-parse HEAD`

if [ "$MASTER_HASH" == "$HEAD_HASH" ]; then
  # Assume HEAD^1
  LAST_MERGE_COMMIT=HEAD^1
else
  # Assume origin/master for now
  LAST_MERGE_COMMIT=origin/master
fi

echo "Comparing changes against: $LAST_MERGE_COMMIT"

COMMITS_IN_DIR=`git log --oneline $LAST_MERGE_COMMIT..HEAD -- $DIRECTORY_TO_BUILD | wc -l`

if [ "$COMMITS_IN_DIR" -gt "0" ]; then
  echo "Changes detected; building $DIRECTORY_TO_BUILD"
  cd $DIRECTORY_TO_BUILD
  yarn build
  yarn test
else
  echo "No changes detected in $DIRECTORY_TO_BUILD; skipping build"
fi
