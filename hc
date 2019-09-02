# hc - shortcut for hub create repo
# first arg is org-name/repo-name
# other optional args -d description, -h url
# hub create -d Description -h example.com org_name/foo_repo

args=("$@")
echo hub create "${args[0]}"

hub create "${args[0]}" 