DEPLOYABLE_PATHS=(
  workspace-a
  workspace-b
  workspace-c
)

# Relevant paths to deploy
to_deploy=()

for changed_file in `git diff --name-only HEAD~20 HEAD`; do
  for path in $DEPLOYABLE_PATHS; do
    if [[ $changed_file == $path* ]];
    then
      to_deploy+=( $path )
      break
    fi
  done
done

# De-dupe
unique_deploy_paths=`printf "%s\n" "${to_deploy[@]}" | sort -u`

echo $unique_deploy_paths

git_root=`git rev-parse --show-toplevel`

# Deploy
for deploy_path in $unique_deploy_paths; do
  cd $git_root/$deploy_path
  echo "yarn deploy"
done