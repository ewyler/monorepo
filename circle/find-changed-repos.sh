# For another example - https://gist.github.com/naesheim/18d0c0a58ee61f4674353a2f4cf71475

DEPLOYABLE_PATHS=(
  workspace-a
  workspace-b
  workspace-c
)

# Relevant paths to deploy
to_deploy=()
changed_files=`git diff --name-only HEAD~20 HEAD`

for changed_file in ${changed_files[@]}; do
  for path in ${DEPLOYABLE_PATHS[@]}; do
    if [[ $changed_file == $path* ]];
    then
      to_deploy+=( $path )
      break
    fi
  done
done

# De-dupe
unique_deploy_paths=`printf "%s\n" "${to_deploy[@]}" | sort -u`

git_root=`git rev-parse --show-toplevel`

# Deploy
for deploy_path in ${unique_deploy_paths[@]}; do
  cd $git_root/$deploy_path
  echo `pwd`
  echo "yarn deploy"
done