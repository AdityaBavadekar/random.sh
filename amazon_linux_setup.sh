# Fist install git
echo "[@@] Installing git..."

sudo yum install git

echo "[@@] git installed" 

echo "[@@] Installing 'jq'"

sudo yum install jq

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

