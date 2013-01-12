shortlog-flowdock
=============

Runs "git shortlog -ns" on a git repo and posts results to flowdock.

Built for deployment to Heroku with a scheduled task.

Required environment variables:
* GIT_REPO_URL
* GIT_COMMAND
* FLOWDOCK_ORG
* FLOWDOCK_FLOW
* FLOWDOCK_TOKEN
