#!/bin/bash
#
# test_cb.sh - test cookbooks at path $1 using "knife cookbook test",
#   "foodcritic -t all", and "rubocop" testing suites.  If rspec tests exist
#   "run those too"
cookbook_home="/home/tquinn/chef-repo/cookbooks"
cookbook_name=$1

knife_exe=`which knife`
foodcritic_exec=`which foodcritic`
rubocop_exec=`which rubocop`

# Test to see if you forgot to enter a cookbook, if you did ask.
# Also, if you are too lazy to respond I only ask once!
if [ -z $cookbook_name ]
then
  read -e cookbook_name
  if [ -d $cookbook_home/$cookbook_name ]
  export cookbook_name
  then
    echo "$cookbook_name will be checked"
  else
    echo "later tater"
    exit 2
  fi
else
  echo "testing $cookbook_name"
fi

if [ -z $knife_exe ]
then
  echo "you forgot to install knife"
  exit 2
else
  echo "performing knife test"
  $knife_exe cookbook test $cookbook_name
fi

if [ -z $foodcritic_exec ]
then
  echo "you forgot to install foodcritic"
  exit 3
else
  echo "performing foodcritic test"
  $foodcritic_exec -t all $cookbook_home/$cookbook_name
fi

if [ -z $rubocop_exec ]
then
  echo "you forgot to install rubocop"
  exit 4
else
  echo "performing rubocop checks"
  $rubocop_exec $cookbook_home/$cookbook_name
fi

echo "finished testing!"
