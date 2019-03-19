DIRECTORY_TO_BUILD=$1

COMMIT_RANGE=$(echo $CIRCLE_COMPARE_URL | sed 's:^.*/compare/::g')

git log --oneline $COMMIT_RANGE -- $DIRECTORY_TO_BUILD