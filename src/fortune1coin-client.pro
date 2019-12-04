#-------------------------------------------------
#
# Project created by QtCreator 2017-10-02T15:01:03
#
#-------------------------------------------------

QT       += core gui network

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = fortune1coin-client
TEMPLATE = app

!win32: QMAKE_CXXFLAGS += -std=c++14 -Wall -Wextra -pedantic
macx: QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.11
macx: ICON = images/bytecoin.icns
win32: RC_ICONS = images/bytecoin.ico
win32: RC_FILE  = bytecoinwallet.rc
#win32: VERSION = 0.19.8.20

#QMAKE_CXXFLAGS += -fno-omit-frame-pointer -fsanitize=address,undefined
#LIBS += -lasan -lubsan

CONFIG += c++14 strict_c++ no-opengl
DEFINES += QT_FORCE_ASSERTS
Release:DESTDIR = $$PWD/../bin
Debug:DESTDIR = $$PWD/../bin_debug
# copy walletd adjacent to bytecoin-gui binary on all 3 platforms
win32 {
contains(QT_ARCH, i386) {
    message("32-bit")
    Release:DESTDIR = $$PWD/../bin32
    Debug:DESTDIR = $$PWD/../bin32_debug/
    WALLETD_BY_SRC_PATH = $$shell_path($$clean_path("$$PWD/../../fortune1coin/bin32/Release/walletd.exe"))
    Debug:WALLETD2_BY_SRC_PATH = $$shell_path($$clean_path("$$PWD/../../fortune1coin/bin32/walletd.pdb"))
    fortune1coind_BY_SRC_PATH = $$shell_path($$clean_path("$$PWD/../../fortune1coin/bin32/Release/fortune1coind.exe"))
    Debug:fortune1coind2_BY_SRC_PATH = $$shell_path($$clean_path("$$PWD/../../fortune1coin/bin32/fortune1coind.pdb"))
    miner_BY_SRC_PATH = $$shell_path($$clean_path("$$PWD/../../fortune1coin/bin32/Release/minerd.exe"))
    Debug:miner2_BY_SRC_PATH = $$shell_path($$clean_path("$$PWD/../../fortune1coin/bin32/minerd.pdb"))
} else {
    message("64-bit")
    WALLETD_BY_SRC_PATH = $$shell_path($$clean_path("$$PWD/../../fortune1coin/bin/Release/walletd.exe"))
    Debug:WALLETD2_BY_SRC_PATH = $$shell_path($$clean_path("$$PWD/../../fortune1coin/bin/walletd.pdb"))
    fortune1coind_BY_SRC_PATH = $$shell_path($$clean_path("$$PWD/../../fortune1coin/bin/Release/fortune1coind.exe"))
    Debug:fortune1coind2_BY_SRC_PATH = $$shell_path($$clean_path("$$PWD/../../fortune1coin/bin/fortune1coind.pdb"))
    miner_BY_SRC_PATH = $$shell_path($$clean_path("$$PWD/../../fortune1coin/bin/Release/minerd.exe"))
    Debug:miner2_BY_SRC_PATH = $$shell_path($$clean_path("$$PWD/../../fortune1coin/bin/minerd.pdb"))
}

Debug:BY_DST_PATH = $$shell_path($$clean_path("$$DESTDIR"))
Release:BY_DST_PATH = $$shell_path($$clean_path("$$DESTDIR"))
copywalletd.commands = $(COPY_FILE) $${WALLETD_BY_SRC_PATH} $${BY_DST_PATH}
Debug:copywalletd2.commands = $(COPY_FILE) $${WALLETD2_BY_SRC_PATH} $${BY_DST_PATH}
copyfortune1coind.commands = $(COPY_FILE) $${fortune1coind_BY_SRC_PATH} $${BY_DST_PATH}
Debug:copyfortune1coind2.commands = $(COPY_FILE) $${fortune1coind2_BY_SRC_PATH} $${BY_DST_PATH}
copyminerd.commands = $(COPY_FILE) $${miner_BY_SRC_PATH} $${BY_DST_PATH}
Debug:copyminerd2.commands = $(COPY_FILE) $${miner2_BY_SRC_PATH} $${BY_DST_PATH}
Release:first.depends = $(first) copywalletd copyfortune1coind  copyminerd
Debug:first.depends = $(first) copywalletd copywalletd2 copyfortune1coind copyfortune1coind2 copyminerd copyminerd2
Release:QMAKE_EXTRA_TARGETS += first copywalletd  copyfortune1coind  copyminerd
Debug:QMAKE_EXTRA_TARGETS += first copywalletd copywalletd2 copyfortune1coind copyfortune1coind2 copyminerd copyminerd2
}else:macx {
copywalletd.commands += $(COPY_FILE) $$PWD/../../fortune1coin/bin/walletd $$DESTDIR/fortune1coin-gui.app/Contents/MacOS
copyfortune1coind.commands += $(COPY_FILE) $$PWD/../../fortune1coin/bin/fortune1coind $$DESTDIR/fortune1coin-gui.app/Contents/MacOS
copyminerd.commands += $(COPY_FILE) $$PWD/../../fortune1coin/bin/miner $$DESTDIR/fortune1coin-gui.app/Contents/MacOS
first.depends = copywalletd copyfortune1coind copyminerd
copywalletd.depends = $(TARGET)
copyfortune1coind.depends = $(TARGET)
copyminerd.depends = $(TARGET)
QMAKE_EXTRA_TARGETS += first copywalletd copyfortune1coind copyminerd
}else {
copywalletd.commands += $(COPY_FILE) $$PWD/../../fortune1coin/bin/walletd $$DESTDIR
copyfortune1coind.commands += $(COPY_FILE) $$PWD/../../fortune1coin/bin/fortune1coind $$DESTDIR
copyminerd.commands += $(COPY_FILE) $$PWD/../../fortune1coin/bin/minerd $$DESTDIR
first.depends = $(first) copywalletd copyfortune1coind copyminerd
QMAKE_EXTRA_TARGETS += first copywalletd copyfortune1coind copyminerd
}
#export(first.depends)
#export(copywalletd.commands)
#export(copyfortune1coind.commands)

SOURCES += main.cpp\
    mainwindow.cpp \
    signalhandler.cpp \
    overviewframe.cpp \
    aboutdialog.cpp \
    JsonRpc/JsonRpcClient.cpp \
    JsonRpc/JsonRpcNotification.cpp \
    JsonRpc/JsonRpcObject.cpp \
    JsonRpc/JsonRpcObjectFactory.cpp \
    JsonRpc/JsonRpcRequest.cpp \
    JsonRpc/JsonRpcResponse.cpp \
    application.cpp \
    logger.cpp \
    okbutton.cpp \
    statusbar.cpp \
    windoweditemmodel.cpp \
    walletmodel.cpp \
    sendframe.cpp \
    transferframe.cpp \
    resizablescrollarea.cpp \
    common.cpp \
    connectionoptionsframe.cpp \
    settings.cpp \
    Miner/Miner.cpp \
    Miner/StratumClient.cpp \
    Miner/Worker.cpp \
    MinerDelegate.cpp \
    MinerModel.cpp \
    MiningFrame.cpp \
    MiningManager.cpp \
    connectselectiondialog.cpp \
    walletd.cpp \
    rpcapi.cpp \
    progressbar.cpp \
    addressbookframe.cpp \
    addressbookmodel.cpp \
    addressbooksortedmodel.cpp \
    newaddressdialog.cpp \
    addressbookmanager.cpp \
    balanceoverviewframe.cpp \
    miningoverviewframe.cpp \
    crashdialog.cpp \
    changepassworddialog.cpp \
    sendconfirmationdialog.cpp \
    addressbookdialog.cpp \
    popup.cpp \
    logframe.cpp \
    askpassworddialog.cpp \
    importkeydialog.cpp \
    questiondialog.cpp \
    PoolTreeView.cpp \
    createproofdialog.cpp \
    checkproofdialog.cpp \
    walletdparamsdialog.cpp \
    exportkeydialog.cpp \
    filedownloader.cpp \
    version.cpp \
    mnemonicdialog.cpp \
    elidedlabel.cpp \
    myaddressesframe.cpp \
    newmyaddressdialog.cpp

HEADERS  += mainwindow.h \
    signalhandler.h \
    overviewframe.h \
    aboutdialog.h \
    JsonRpc/JsonRpcClient.h \
    JsonRpc/JsonRpcNotification.h \
    JsonRpc/JsonRpcObject.h \
    JsonRpc/JsonRpcObjectFactory.h \
    JsonRpc/JsonRpcRequest.h \
    JsonRpc/JsonRpcResponse.h \
    application.h \
    logger.h \
    okbutton.h \
    statusbar.h \
    windoweditemmodel.h \
    walletmodel.h \
    sendframe.h \
    transferframe.h \
    resizablescrollarea.h \
    common.h \
    connectionoptionsframe.h \
    settings.h \
    Miner/Miner.h \
    Miner/StratumClient.h \
    Miner/Worker.h \
    MinerDelegate.h \
    MinerModel.h \
    MiningFrame.h \
    MiningManager.h \
    IMinerWorker.h \
    IMiningManager.h \
    IPoolClient.h \
    IPoolMiner.h \
    connectselectiondialog.h \
    walletd.h \
    rpcapi.h \
    progressbar.h \
    addressbookframe.h \
    addressbookmodel.h \
    addressbooksortedmodel.h \
    newaddressdialog.h \
    addressbookmanager.h \
    balanceoverviewframe.h \
    miningoverviewframe.h \
    crashdialog.h \
    changepassworddialog.h \
    sendconfirmationdialog.h \
    addressbookdialog.h \
    popup.h \
    logframe.h \
    askpassworddialog.h \
    importkeydialog.h \
    questiondialog.h \
    PoolTreeView.h \
    createproofdialog.h \
    checkproofdialog.h \
    walletdparamsdialog.h \
    exportkeydialog.h \
    version.h \
    filedownloader.h \
    mnemonicdialog.h \
    elidedlabel.h \
    myaddressesframe.h \
    newmyaddressdialog.h

FORMS    += mainwindow.ui \
    overviewframe.ui \
    aboutdialog.ui \
    sendframe.ui \
    transferframe.ui \
    connectionoptionsframe.ui \
    optionsdialog.ui \
    MiningFrame.ui \
    connectselectiondialog.ui \
    addressbookframe.ui \
    newaddressdialog.ui \
    balanceoverviewframe.ui \
    miningoverviewframe.ui \
    crashdialog.ui \
    changepassworddialog.ui \
    addressbookdialog.ui \
    logframe.ui \
    askpassworddialog.ui \
    importkeydialog.ui \
    questiondialog.ui \
    createproofdialog.ui \
    checkproofdialog.ui \
    walletdparamsdialog.ui \
    exportkeydialog.ui \
    mnemonicdialog.ui \
    myaddressesframe.ui \
    newmyaddressdialog.ui

RESOURCES += \
    resources.qrc \

contains(QT_ARCH, i386) {
    message("32-bit")
    win32:!win32-g++: PRE_TARGETDEPS += $$PWD/../../fortune1coin/libs32/Release/bytecoin-crypto.lib
    else:unix|win32-g++: PRE_TARGETDEPS += $$PWD/../../fortune1coin/libs32/libbytecoin-crypto.a
    unix|win32: LIBS += -L$$PWD/../../fortune1coin/libs32/Release -lbytecoin-crypto

} else {
    message("64-bit")
    win32:!win32-g++: PRE_TARGETDEPS += $$PWD/../../fortune1coin/libs/Release/bytecoin-crypto.lib
    else:unix|win32-g++: PRE_TARGETDEPS += $$PWD/../../fortune1coin/libs/libbytecoin-crypto.a
    unix|win32: LIBS += -L$$PWD/../../fortune1coin/libs/Release -lbytecoin-crypto
}


INCLUDEPATH += $$PWD/../../fortune1coin/src
DEPENDPATH += $$PWD/../../fortune1coin/src



# to add necessary dependencies,
# 1. delete built bytecoin-gui.app to delete old dependencies (dylibs and frameworks)
# 2. build
# 3. run /Users/user/Qt/5.9.2/clang_64/bin/macdeployqt bytecoin-gui.app
# P.S. in 3, change path accroding to your Qt installation location
