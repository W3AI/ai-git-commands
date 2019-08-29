# hc - shortcut for hub create repo
# first arg is org-name/repo-name
# other optional args -d description, -h url

args=("$@")

hub create "${args[0]}" 