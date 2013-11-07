# Depends on

The very awesome [jq](http://stedolan.github.io/jq).

# Usage

    ./grab.sh <the-interrogatee> <your-git-username|$(whoami)> 

# E.g.

    # this uses $(whoami) as the second argument, which happens to be my Github username
    ./grab.sh defunkt


    # this uses 'opyate' as the username:
    ./grab.sh defunkt opyate

    # this grabs all my stuff (terribly boring!)
    ./grab.sh
