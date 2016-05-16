#!/bin/bash

#HARBOR_URL=http://forward.dataman-inc.com/
HARBOR_URL=devforward.dataman-inc.net
#HARBOR_URL=127.0.0.1:8080
USERNAME=admin
TOKEN=ae2971ba2edc4c4a93e332990a3b92fc
#TOKEN=001122
PASSWORD=Dataman1234

PROJECT_NAME=library

# 更新分类
update_repo_category()
{
  echo ""
  echo " ====  UPDATING $1's category to $2 ===="
  echo ""
  curl -H "Authorization: $TOKEN" -u $USERNAME:$PASSWORD -X PUT -k -H "Content-Type: application/json" $HARBOR_URL/api/v3/repositories/$PROJECT_NAME/$1 -d " { \"category\": \"$2\" } "
}

# 更新描述
update_repo_description()
{
  echo ""
  echo " ====  UPDATING $1's description to $2 ===="
  echo ""
  curl -H "Authorization: $TOKEN" -u $USERNAME:$PASSWORD -X PUT -k -H "Content-Type: application/json"  $HARBOR_URL/api/v3/repositories/$PROJECT_NAME/$1 -d " { \"description\": \"$2\" } "
}

# 更新docker compose
update_repo_docker_compose()
{
  echo ""
  echo " ====  UPDATING $1's docker compose to $2 ===="
  echo ""
  echo curl -H "Authorization: $TOKEN" -u $USERNAME:$PASSWORD   -X PUT -k -H "Content-Type: application/json" $HARBOR_URL/api/v3/repositories/$PROJECT_NAME/$1 -d " { \"dockerCompose\": \"`REPO=$1 ruby -rbase64 -e 'puts Base64.encode64(File.read(Dir.pwd + \"/library/#{ENV[\"REPO\"]}/docker_compose.yml\")).gsub(\"\\n\", "")'`\" }"
  curl -H "Authorization: $TOKEN" -u $USERNAME:$PASSWORD  -X PUT -k -H "Content-Type: application/json" $HARBOR_URL/api/v3/repositories/$PROJECT_NAME/$1 -d " { \"dockerCompose\": \"`REPO=$1 ruby -rbase64 -e  'puts Base64.encode64(File.read(Dir.pwd + \"/library/#{ENV[\"REPO\"]}/docker_compose.yml\")).gsub(\"\\n\",\"\")'`\" }"
}

# 更新catalog
update_repo_catalog()
{
  echo ""
  echo " ====  UPDATING $1's catalog to $2 ===="
  echo ""
  echo curl -H "Authorization: $TOKEN" -u $USERNAME:$PASSWORD   -X PUT -k -H "Content-Type: application/json" $HARBOR_URL/api/v3/repositories/$PROJECT_NAME/$1 -d " { \"catalog\": \"`REPO=$1 ruby -rbase64 -e 'puts Base64.encode64(File.read(Dir.pwd + \"/library/#{ENV[\"REPO\"]}/catalog.yml\")).gsub(\"\\n\", "")'`\" } "
  curl -H "Authorization: $TOKEN" -u $USERNAME:$PASSWORD  -X PUT -k -H "Content-Type: application/json" $HARBOR_URL/api/v3/repositories/$PROJECT_NAME/$1 -d " { \"catalog\": \"`REPO=$1 ruby -rbase64 -e  'puts Base64.encode64(File.read(Dir.pwd + \"/library/#{ENV[\"REPO\"]}/catalog.yml\")).gsub(\"\\n\",\"\")'`\" } "

}

# 更新marathon_config
update_repo_marathon_config()
{
  echo ""
  echo " ====  UPDATING $1's marathon_config to $2 ===="
  echo ""
  echo curl -H "Authorization: $TOKEN" -u $USERNAME:$PASSWORD -X PUT -k -H "Content-Type: application/json" $HARBOR_URL/api/v3/repositories/$PROJECT_NAME/$1 -d " { \"marathonConfig\": \"`REPO=$1 ruby -rbase64 -e 'puts Base64.encode64(File.read(Dir.pwd + \"/library/#{ENV[\"REPO\"]}/marathon_config.yml\")).gsub(\"\\n\", "")'`\" } "
  curl -H "Authorization: $TOKEN" -u $USERNAME:$PASSWORD  -X PUT -k -H "Content-Type: application/json" $HARBOR_URL/api/v3/repositories/$PROJECT_NAME/$1 -d " { \"marathonConfig\": \"`REPO=$1 ruby -rbase64 -e  'puts Base64.encode64(File.read(Dir.pwd + \"/library/#{ENV[\"REPO\"]}/marathon_config.yml\")).gsub(\"\\n\",\"\")'`\" } "
}


# 更新readme
update_repo_readme()
{
  echo ""
  echo " ====  UPDATING $1's readme to $2 ===="
  echo ""
  echo curl -H "Authorization: $TOKEN" -u $USERNAME:$PASSWORD -X PUT -k -H "Content-Type: application/json" $HARBOR_URL/api/v3/repositories/$PROJECT_NAME/$1 -d " { \"readme\": \"`REPO=$1 ruby -rbase64 -e 'puts Base64.encode64(File.read(Dir.pwd + \"/library/#{ENV[\"REPO\"]}/README.md\")).gsub(\"\\n\", "")'`\" } "
  curl -H "Authorization: $TOKEN" -u $USERNAME:$PASSWORD   -X PUT -k -H "Content-Type: application/json" $HARBOR_URL/api/v3/repositories/$PROJECT_NAME/$1 -d " { \"readme\": \"`REPO=$1 ruby -rbase64 -e  'puts Base64.encode64(File.read(Dir.pwd + \"/library/#{ENV[\"REPO\"]}/README.md\")).gsub(\"\\n\",\"\")'`\" } "
}
# 更新状态是否可见
update_repo_is_public()
{
  echo ""
  echo " ====  UPDATING $1's publicity to $2 ===="
  echo ""
  echo curl -H "Authorization: $TOKEN" -u $USERNAME:$PASSWORD -X PUT -k -H "Content-Type: application/json"  $HARBOR_URL/api/v3/repositories/$PROJECT_NAME/$1 -d " { \"isPublic\":  $2} "
  curl -H "Authorization: $TOKEN" -u $USERNAME:$PASSWORD -X PUT -k -H "Content-Type: application/json"  $HARBOR_URL/api/v3/repositories/$PROJECT_NAME/$1 -d " { \"isPublic\":  $2} "
}

for repo in `ls library`; do
  CATEGORY=`cat ./library/$repo/category`
  DESCRIPTION=`cat ./library/$repo/description`
  ISPUBLIC=`cat ./library/$repo/ispublic`

  update_repo_category $repo $CATEGORY
  update_repo_description $repo $DESCRIPTION
  update_repo_catalog $repo
  update_repo_marathon_config $repo
  update_repo_docker_compose $repo
  update_repo_readme $repo
  update_repo_is_public $repo $ISPUBLIC
done

