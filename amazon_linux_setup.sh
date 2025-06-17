# TODO create a simple log function instead of using echo syntanx everytime
#
# Fist install git
echo "[@@] Installing git..."

sudo yum install -y git

echo "[@@] git installed" 

echo "[@@] Installing 'jq'"

sudo yum install -y jq

echo "[@@] 'jq' installed"

# Install neofetch
echo "[@@] Installing neofetch.."

git clone https://github.com/dylanaraps/neofetch/ neofetch-source
cp neofetch-source/neofetch neofetch
rm -rf neofetch-source

chmod +x neofetch

echo "[@@] neofetch installed run it using './neofetch'"  

echo "[@@] Installing 'npm'"

curl -fsSL https://rpm.nodesource.com/setup_22.x | sudo bash -
sudo yum install -y nsolid
npm -v

echo "[@@] 'npm' installed"

echo "[@@] Installing 'pnpm'"

sudo npm install -g pnpm

echo "[@@] 'pnpm' installed"

echo "[@@] Installing 'pm2'"

sudo npm install -g pm2

echo "[@@] 'pm2' installed"

echo "[@@] Installing 'nginx' "

sudo yum install -y nginx

echo "[@@] 'nginx' installed"

echo "[COMPLETED]"
echo "---------------------------------------------------"
