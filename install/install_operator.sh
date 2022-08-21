#!/bin/bash
#set -x -e


echo ███████╗██╗░░░░░░█████╗░░██████╗░░█████╗░██████╗░░█████╗░██╗░░░░░██╗░░██╗
echo ██╔════╝██║░░░░░██╔══██╗██╔════╝░██╔══██╗██╔══██╗██╔══██╗██║░░░░░╚██╗██╔╝
echo █████╗░░██║░░░░░███████║██║░░██╗░███████║██████╦╝███████║██║░░░░░░╚███╔╝░
echo ██╔══╝░░██║░░░░░██╔══██║██║░░╚██╗██╔══██║██╔══██╗██╔══██║██║░░░░░░██╔██╗░
echo ███████╗███████╗██║░░██║╚██████╔╝██║░░██║██████╦╝██║░░██║███████╗██╔╝╚██╗
echo ╚══════╝╚══════╝╚═╝░░╚═╝░╚═════╝░╚═╝░░╚═╝╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝

echo -e "\e[1m\e[32m|||__________________________________________________|||\e[0m"
echo -e "\e[1m\e[32m|||                                                  |||\e[0m"
echo -e "\e[1m\e[32m|||              ELAGABAL X NEON OPERATOR            |||\e[0m"
echo -e "\e[1m\e[32m|||                                                  |||\e[0m"
echo -e "\e[1m\e[32m|||                      DEVNET                      |||\e[0m"
echo -e "\e[1m\e[32m|||                                                  |||\e[0m"
echo -e "\e[1m\e[32m|||      AUTOMATED ANSIBLE ROLE FOR COMMUNITY        |||\e[0m"
echo -e "\e[1m\e[32m|||__________________________________________________|||\e[0m"

sleep 5

install_operator () {

  echo -e "\e[1m\e[32mYour Solana RPC instant is localhost\e[0m?"
  select yrpc in "Yes" "No"; do
      case $yrpc in
          Yes ) RPC_VAR="localhost"; echo $RPC_VAR; break;;  
          No ) echo -e "\e[1m\e[32mEnter solana RPC endpoints:\e[0m" 
          read RPC_VAR; echo -e $RPC_VAR;  break;;
      esac
  done
  
  echo -e "\e[1m\e[32mEnter name of your operator:\e[0m"
  read NEON_USER
  echo Your operator name is $NEON_USER
  echo -e "\e[1m\e[32mTo install the operator, a Postgres database is required - enter the name of the database:\e[0m"
  read DB_NAME
  echo Postgres Data Base name $DB_NAME
  echo -e "\e[1m\e[32mEnter the password for the database:\e[0m"
  read -s DB_PSWD
  
    echo -e "\e[1m\e[32mDelete Ansible after install?\e[0m"
  select dl in "Yes" "No"; do
    case $dl in
        Yes ) deletea=yes break;;  
        No ) deletea=no break;;
    esac
  done

  if [[ $(which apt | wc -l) -gt 0 ]]
  then
  pkg_manager=apt
  elif [[ $(which yum | wc -l) -gt 0 ]]
  then
  pkg_manager=yum
  fi

  echo -e "\e[1m\e[32mUpdating packages...\e[0m"
  $pkg_manager update

  echo -e "\e[1m\e[32mInstalling ansible, curl, unzip...\e[0m"
  $pkg_manager install -y ansible curl unzip --yes

  sleep 5

  ansible-galaxy collection install ansible.posix
  ansible-galaxy collection install community.general
  ansible-galaxy collection install community.postgresql

  echo -e "\e[1m\e[32mDownloading Neon operator manager\e[0m"
  cmd="https://github.com/ElagabalxNode/neon-manager/archive/refs/heads/main.zip"
  ver="main"
  echo "starting $cmd"
  curl -fsSL "$cmd" --output neon_manager.zip
  echo "Unpacking"
  unzip ./neon_manager.zip -d .

  mv neon-manager-$ver* neon_manager
  rm ./neon_manager.zip
  cd ./neon_manager || exit
  
  #shellcheck disable=SC2154
  #echo "pwd: $(pwd)"
  #ls -lah ./


  echo -e "\e[1m\e[32mInstall NeonEVM Operator\e[0m"
  ansible-playbook --connection=local --inventory ./inventory/devnet.yml --limit local playbooks/install.yml -vvvv --extra-vars "{ \
  'neonevm_solana_rpc': '$RPC_VAR', \
  'postgres_db': '$DB_NAME', \
  'neonevm_user': '$NEON_USER', \
  'postgres_password': '$DB_PSWD' \
  }"

  # echo -e "\e[1m\e[32mUninstall ansible\e[0m"

  # if [[ $deletea="yes" ]];
  # then
  # $pkg_manager remove ansible --yes
  # fi
  # break
  
}


while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare ${param}="$2"
        echo $1 $2 // Optional to see the parameter:value result
   fi

  shift
done

echo -e "\e[1m\e[32mThis script will bootstrap a NEON operator. Proceed?\e[0m"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) install_operator break;;  
        No ) echo "\e[1m\e[32mAborting install. No changes will be made."; exit;;
    esac
done
