
to install:
  echo "deb [trusted=yes] https://fortb164.github.io/Tclippy stable main" | sudo tee /etc/apt/sources.list.d/tclippy.list
  sudo apt update
  sudo apt install tclippy


to remove:
  sudo apt remove tclippy
to fully remove:
  sudo apt purge tclippy
  sudo apt autoremove

to remove repo:
  sudo rm /etc/apt/sources.list.d/tclippy.list
