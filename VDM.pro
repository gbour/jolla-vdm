https://github.com/gbour/jolla-vdm.git# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = VDM

VERSION = 0.1
DEFINES += APP_VERSION=\\\"$$VERSION\\\"
DEFINES += BUILD_DATE='"$(shell date '+%s')"'
DEFINES += GIT_VERSION='\\\"$$system(git symbolic-ref --short HEAD)/$$system(git describe --always)\\\"'
DEFINES += APIKEY='\\\"$$system(cat APIKEY)\\\"'

CONFIG += sailfishapp

SOURCES += src/VDM.cpp \
    src/global.cpp \
    story.cpp \
    src/downloadmanager.cpp

OTHER_FILES += qml/VDM.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/VDM.changes.in \
    rpm/VDM.spec \
    rpm/VDM.yaml \
    translations/*.ts \
    VDM.desktop \
    qml/lib/htmlparser2.js \
    qml/lib/iso8859-15.js \
    qml/logic/context.js \
    qml/logic/scraper.js \
    qml/logic/api.js

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/VDM-de.ts

HEADERS += \
    src/global.h \
    story.h \
    src/downloadmanager.h

