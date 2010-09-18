# Torsion - http://torsionim.org/
# Copyright (C) 2010, John Brooks <special@dereferenced.net>
#
# Torsion is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Torsion. If not, see http://www.gnu.org/licenses/

QT += core \
    gui \
    network
TARGET = Torsion
TEMPLATE = app

unix {
    target.path = /usr/bin
    shortcut.path = /usr/share/applications
    shortcut.files = src/Torsion.desktop
    INSTALLS += target
    unix:!macx:INSTALLS += shortcut

    exists(Tor) {
        message(Adding bundled Tor to installations)
        bundletor.path = /usr/share/torsion/Tor/
        bundletor.files = Tor/*
        INSTALLS += bundletor
        DEFINES += BUNDLED_TOR_PATH=\\\"/usr/share/torsion/Tor/\\\"
    }
}

CONFIG += debug_and_release
QMAKE_RESOURCE_FLAGS += -no-compress

# Create a pdb for release builds as well, to enable debugging
win32-msvc2008|win32-msvc2010 {
    QMAKE_CXXFLAGS_RELEASE += /Zi
    QMAKE_LFLAGS_RELEASE += /DEBUG /OPT:REF,ICF
}

INCLUDEPATH += src

unix:!macx {
    CONFIG += link_pkgconfig
    PKGCONFIG += libcrypto # Using libcrypto instead of openssl to avoid needlessly linking libssl
}
win32 {
    isEmpty(OPENSSLDIR):error(You must pass OPENSSLDIR=path/to/openssl to qmake on this platform)
    INCLUDEPATH += $${OPENSSLDIR}/include
    LIBS += -L$${OPENSSLDIR}/lib -llibeay32

    # required by openssl
    LIBS += -lUser32 -lGdi32 -ladvapi32
}
macx:LIBS += -lcrypto

DEFINES += QT_NO_CAST_FROM_ASCII QT_NO_CAST_TO_ASCII

SOURCES += src/main.cpp \
    src/ui/MainWindow.cpp \
    src/ui/ChatWidget.cpp \
    src/ContactsModel.cpp \
    src/ui/ContactItemDelegate.cpp \
    src/tor/TorControlManager.cpp \
    src/tor/TorControlSocket.cpp \
    src/tor/TorControlCommand.cpp \
    src/tor/ProtocolInfoCommand.cpp \
    src/tor/AuthenticateCommand.cpp \
    src/tor/SetConfCommand.cpp \
    src/utils/StringUtil.cpp \
    src/core/ContactsManager.cpp \
    src/core/ContactUser.cpp \
    src/protocol/ProtocolCommand.cpp \
    src/protocol/ProtocolManager.cpp \
    src/protocol/PingCommand.cpp \
    src/ui/ContactInfoPage.cpp \
    src/ui/ContactsView.cpp \
    src/protocol/IncomingSocket.cpp \
    src/protocol/ChatMessageCommand.cpp \
    src/protocol/CommandHandler.cpp \
    src/protocol/CommandDataParser.cpp \
    src/tor/GetConfCommand.cpp \
    src/utils/DateUtil.cpp \
    src/tor/TorServiceTest.cpp \
    src/tor/HiddenService.cpp \
    src/ui/torconfig/TorConfigWizard.cpp \
    src/ui/torconfig/IntroPage.cpp \
    src/ui/torconfig/ManualConfigPage.cpp \
    src/protocol/ProtocolSocket.cpp \
    src/ui/torconfig/TorConnTestWidget.cpp \
    src/utils/PaintUtil.cpp \
    src/utils/CryptoKey.cpp \
    src/utils/SecureRNG.cpp \
    src/protocol/ContactRequestClient.cpp \
    src/protocol/ContactRequestServer.cpp \
    src/core/OutgoingContactRequest.cpp \
    src/ui/ContactAddDialog.cpp \
    src/ui/FancyTextEdit.cpp \
    src/core/IncomingRequestManager.cpp \
    src/core/ContactIDValidator.cpp \
    src/core/NicknameValidator.cpp \
    src/ui/NotificationWidget.cpp \
    src/ui/ContactRequestDialog.cpp \
    src/protocol/GetSecretCommand.cpp \
    src/ui/EditableLabel.cpp \
    src/ui/ContactIDWidget.cpp \
    src/tor/autoconfig/VidaliaConfigManager.cpp \
    src/ui/torconfig/VidaliaConfigPage.cpp \
    src/ui/torconfig/VidaliaExitWidget.cpp \
    src/ui/torconfig/VidaliaStartWidget.cpp \
    src/ui/torconfig/VidaliaTestWidget.cpp \
    src/ui/IdentityItemDelegate.cpp \
    src/core/UserIdentity.cpp \
    src/core/IdentityManager.cpp \
    src/ui/ContactsViewDelegate.cpp \
    src/ui/IdentityInfoPage.cpp \
    src/tor/autoconfig/BundledTorManager.cpp \
    src/utils/OSUtil.cpp \
    src/ui/ChatTextWidget.cpp \
    src/utils/AppSettings.cpp

HEADERS += src/ui/MainWindow.h \
    src/ui/ChatWidget.h \
    src/ContactsModel.h \
    src/ui/ContactItemDelegate.h \
    src/tor/TorControlManager.h \
    src/tor/TorControlSocket.h \
    src/tor/TorControlCommand.h \
    src/tor/ProtocolInfoCommand.h \
    src/tor/AuthenticateCommand.h \
    src/tor/SetConfCommand.h \
    src/utils/StringUtil.h \
    src/core/ContactsManager.h \
    src/core/ContactUser.h \
    src/protocol/ProtocolCommand.h \
    src/protocol/ProtocolManager.h \
    src/protocol/PingCommand.h \
    src/ui/ContactInfoPage.h \
    src/ui/ContactsView.h \
    src/protocol/IncomingSocket.h \
    src/main.h \
    src/protocol/ChatMessageCommand.h \
    src/protocol/CommandHandler.h \
    src/protocol/CommandDataParser.h \
    src/tor/GetConfCommand.h \
    src/utils/DateUtil.h \
    src/tor/TorServiceTest.h \
    src/tor/HiddenService.h \
    src/ui/torconfig/TorConfigWizard.h \
    src/ui/torconfig/IntroPage.h \
    src/ui/torconfig/ManualConfigPage.h \
    src/protocol/ProtocolSocket.h \
    src/ui/torconfig/TorConnTestWidget.h \
    src/utils/PaintUtil.h \
    src/utils/CryptoKey.h \
    src/utils/SecureRNG.h \
    src/protocol/ContactRequestClient.h \
    src/protocol/ContactRequestServer.h \
    src/core/OutgoingContactRequest.h \
    src/ui/ContactAddDialog.h \
    src/ui/FancyTextEdit.h \
    src/core/IncomingRequestManager.h \
    src/core/ContactIDValidator.h \
    src/core/NicknameValidator.h \
    src/ui/NotificationWidget.h \
    src/ui/ContactRequestDialog.h \
    src/protocol/GetSecretCommand.h \
    src/ui/EditableLabel.h \
    src/ui/ContactIDWidget.h \
    src/tor/autoconfig/VidaliaConfigManager.h \
    src/ui/torconfig/VidaliaConfigPage.h \
    src/ui/torconfig/VidaliaExitWidget.h \
    src/ui/torconfig/VidaliaStartWidget.h \
    src/ui/torconfig/VidaliaTestWidget.h \
    src/ui/IdentityItemDelegate.h \
    src/core/UserIdentity.h \
    src/core/IdentityManager.h \
    src/ui/ContactsViewDelegate.h \
    src/ui/IdentityInfoPage.h \
    src/tor/autoconfig/BundledTorManager.h \
    src/utils/OSUtil.h \
    src/ui/ChatTextWidget.h \
    src/utils/AppSettings.h

RESOURCES += res/resources.qrc \
    translation/embedded.qrc

TRANSLATIONS = translation/torsion.ts
