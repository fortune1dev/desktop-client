// Copyright (c) 2015-2018, The Bytecoin developers.
// Licensed under the GNU Lesser General Public License. See LICENSE for details.

#include <QApplication>
#include <QDataWidgetMapper>
#include <QClipboard>

#include "miningoverviewframe.h"
#include "ui_miningoverviewframe.h"
#include "MiningManager.h"
#include "MinerModel.h"
#include "walletmodel.h"
#include "common.h"
#include "popup.h"

namespace WalletGUI {

const char MINING_OVERVIEW_STYLE_SHEET_TEMPLATE[] =
    "WalletGUI--MiningOverviewFrame {"
    "border: 1px solid #c4c4c4"
    "}";

const char TEXT_LABEL_STYLE_SHEET_TEMPLATE[] =
    "QLabel {"
    "color: rgba(0,0,0,0.5);"
    "}";

constexpr int UI_SCALE = 90;

MiningOverviewFrame::MiningOverviewFrame(QWidget *parent)
    : QFrame(parent)
    , ui(new Ui::MiningOverviewFrame)
    , miningManager_(nullptr)
    , miningMapper_(new QDataWidgetMapper(this))
    , walletModel_(nullptr)
    , copiedToolTip_(new CopiedToolTip(this))
    , started_(false)
{
    ui->setupUi(this);

    scaleWidgetText(ui->m_titleLabel, UI_SCALE);

    QFont font = ui->m_overviewHashrateLabel->font();
    font.setBold(true);
    ui->m_overviewHashrateLabel->setFont(font);
    ui->m_miningStateLabel->setFont(font);
    ui->m_overviewNetworkHashrateLabel->setFont(font);
    ui->m_overviewNetworkDifficultyLabel->setFont(font);

    ui->m_miningStatusTextLabel->setStyleSheet(TEXT_LABEL_STYLE_SHEET_TEMPLATE);
    ui->m_overviewHashrateTextLabel->setStyleSheet(TEXT_LABEL_STYLE_SHEET_TEMPLATE);
    ui->m_overviewNetworkHashrateTextLabel->setStyleSheet(TEXT_LABEL_STYLE_SHEET_TEMPLATE);
    ui->m_overviewNetworkDifficultyTextLabel->setStyleSheet(TEXT_LABEL_STYLE_SHEET_TEMPLATE);

    setStyleSheet(MINING_OVERVIEW_STYLE_SHEET_TEMPLATE);

    ui->m_CopyAffiliateLinkLable->installEventFilter(this);

    connect(ui->m_CopyAffiliateLinkButton, SIGNAL(clicked()), this, SLOT(copyAffiliate()));
}

MiningOverviewFrame::~MiningOverviewFrame()
{
    delete ui;
}

void MiningOverviewFrame::setMiningManager(MiningManager* miningManager)
{
    miningManager_ = miningManager;

    connect(miningManager_, &MiningManager::miningStartedSignal, this, &MiningOverviewFrame::miningStarted);
    connect(miningManager_, &MiningManager::miningStoppedSignal, this, &MiningOverviewFrame::miningStopped);
    connect(miningManager_, &MiningManager::activeMinerChangedSignal, this, &MiningOverviewFrame::activeMinerChanged);
}

void MiningOverviewFrame::setMinerModel(QAbstractItemModel* model)
{
    miningMapper_->setModel(model);
    miningMapper_->addMapping(ui->m_overviewHashrateLabel, MinerModel::COLUMN_HASHRATE, "text");
    if (model->rowCount() > 0)
        miningMapper_->setCurrentIndex(0);
    else
        ui->m_overviewHashrateLabel->setText("0 H/s");
}

void MiningOverviewFrame::setWalletModel(WalletModel* model)
{
    Q_ASSERT(model != nullptr);
    const bool needToDisconnect = walletModel_ != nullptr;
    if (needToDisconnect)
        disconnect(walletModel_, 0, this, 0); // disconnect all signals from walletModel_ to all our slots
    walletModel_ = model;
    QDataWidgetMapper* stateMapper = new QDataWidgetMapper(this);
    stateMapper->setModel(walletModel_);
    stateMapper->addMapping(ui->m_overviewNetworkHashrateLabel, WalletModel::COLUMN_NETWORK_HASHRATE, "text");
    stateMapper->addMapping(ui->m_overviewNetworkDifficultyLabel, WalletModel::COLUMN_TOP_BLOCK_DIFFICULTY, "text");
    stateMapper->toFirst();
    connect(walletModel_, &QAbstractItemModel::modelReset, stateMapper, &QDataWidgetMapper::toFirst);
}

//void MiningOverviewFrame::startMiningClicked()
//{
//    if (started_)
//    {
//        miningStopped();
//        miningManager_->stopMining();
//    }
//    else
//    {
//        miningStarted();
//        miningManager_->startMining();
//    }
//}

void MiningOverviewFrame::miningStarted()
{
    ui->m_miningStateLabel->setText(tr("ON"));
    started_ = true;
}

void MiningOverviewFrame::miningStopped()
{
    ui->m_miningStateLabel->setText(tr("OFF"));
    started_ = false;
}

void MiningOverviewFrame::activeMinerChanged(quintptr _minerIndex)
{
    miningMapper_->setCurrentIndex(_minerIndex);
}

bool MiningOverviewFrame::eventFilter(QObject* object, QEvent* event)
{
    if (object == ui->m_CopyAffiliateLinkLable && event->type() == QEvent::MouseButtonRelease)
        copyAffiliate();

    return QFrame::eventFilter(object, event);
}

void MiningOverviewFrame::copyAffiliate()
{
    if (!walletModel_->isConnected())
        return;
    auto link = "https://fortune1.money/?aw=" + walletModel_->index(0, WalletModel::COLUMN_FIRST_ADDRESS).data(WalletModel::ROLE_FIRST_ADDRESS).toString();
    QApplication::clipboard()->setText(link);
    copiedToClipboard();
}

void MiningOverviewFrame::copiedToClipboard()
{
    copiedToolTip_->showNearMouse();
}

}
