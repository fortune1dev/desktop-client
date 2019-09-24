// Copyright (c) 2015-2018, The Bytecoin developers.
// Licensed under the GNU Lesser General Public License. See LICENSE for details.

#ifndef MININGOVERVIEWFRAME_H
#define MININGOVERVIEWFRAME_H

#include <QFrame>
#include "popup.h"

class QAbstractItemModel;
class QDataWidgetMapper;

namespace Ui {
class MiningOverviewFrame;
}

namespace WalletGUI {

class MiningManager;
class WalletModel;

class MiningOverviewFrame : public QFrame
{
    Q_OBJECT

public:
    explicit MiningOverviewFrame(QWidget *parent = 0);
    ~MiningOverviewFrame();

    void setMiningManager(MiningManager* miningManager);
    void setMinerModel(QAbstractItemModel* model);
    void setWalletModel(WalletModel* model);

    void miningStarted();
    void miningStopped();
    void activeMinerChanged(quintptr minerIndex);

    bool eventFilter(QObject* object, QEvent* event) override;

public:
    void copiedToClipboard();
    Q_SLOT void copyAffiliate();
    void startMiningClicked();

private:
    Ui::MiningOverviewFrame *ui;

    MiningManager* miningManager_;
    QDataWidgetMapper* miningMapper_;
    CopiedToolTip* copiedToolTip_;
    WalletModel* walletModel_;
    QDataWidgetMapper* stateMapper_;
    bool started_;
};

}

#endif // MININGOVERVIEWFRAME_H
