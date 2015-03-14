# How to create a new project
    virtualenv --python=python2 env
    source env/bin/activate
    pip install platformio
    pip install --egg scons
    platformio init --board=uno
    platformio run

# arduino mode
Go to your emacs config directory and get a git copy of the Arduino-mode:

~/.emacs.d/vendor $ git clone git://github.com/bookest/arduino-mode.git
Configure your emacs init file to use it:

(add-to-list 'load-path "~/.emacs.d/vendor/arduino-mode")
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)