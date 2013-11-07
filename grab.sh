#!/bin/bash
# If you don't want forks, add &type=owner to $P

U=${1:-opyate}
M=${2:-$(whoami)}
TF=.github-auth-token
# first, grab a token
#+ unless we have one
if [ -e $TF ] ; then
  echo "Using auth token in in $TF"
else
  curl -u $M -d '{"scopes": ["repo"]}' https://api.github.com/authorizations | jq -r '. | {token}.token' > .github-auth-token
fi

# secondly, grab the repos your're interested in
T=$(< $TF)
G="https://api.github.com/users/$U/repos"
N=1
while (true) ; do
  P=$G\?page\=$N
  REPOS=$(curl -H "Authorization: token $T" $P | jq -r '.[] | {clone_url}.clone_url')
  for repo in ${REPOS[@]} ; do
    echo $repo
    git clone $repo
  done
  if [ "$REPOS" == "" ] ; then
    echo "Returned nothing, exiting: $P"
    exit 0
  fi
  let N=N+1
done
