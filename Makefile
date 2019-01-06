DEBUG = 0
FOR_RELEASE=1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = IGNoSwitching
IGNoSwitching_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
