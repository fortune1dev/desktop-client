// Copyright (c) 2015-2018, The Bytecoin developers.
// Licensed under the GNU Lesser General Public License. See LICENSE for details.

#ifndef COMMON_H
#define COMMON_H

#include <cstdint>
#include <QString>

class QUrl;
class QWidget;

constexpr const char CURRENCY_TICKER[] = "FT1";
//constexpr const uint64_t MAXIMUM_UNSYNCED_BLOCKS_WHEN_SEND_AVAILABLE = 5;
constexpr const uint64_t COIN = 1000000;
constexpr const uint32_t CONFIRMATIONS = 5;
constexpr const uint32_t NUMBER_OF_DECIMAL_PLACES = 6;
constexpr const uint32_t DEV_FEE_PERCENT = 10000;
constexpr const uint32_t MIN_DEV_FEE_AMOUNT = 1000;
constexpr const int64_t DEFAULT_MIXIN_VALUE = 3;
constexpr const int64_t MAX_MIXIN_VALUE = 20;
constexpr const int64_t CRITICAL_MIXIN_BOUND = 3;
constexpr const int64_t NORMAL_MIXIN_BOUND = 6;
constexpr const uint16_t RPC_DEFAULT_PORT = 8888;

constexpr const uint64_t DIFFICULTY_TARGET = 180; // seconds
constexpr const uint64_t CRYPTONOTE_LOCKED_TX_ALLOWED_DELTA_BLOCKS = 1;
constexpr const uint64_t CRYPTONOTE_LOCKED_TX_ALLOWED_DELTA_SECONDS = DIFFICULTY_TARGET * CRYPTONOTE_LOCKED_TX_ALLOWED_DELTA_BLOCKS;
constexpr const uint32_t CRYPTONOTE_MAX_BLOCK_NUMBER = 999999999;

namespace WalletGUI
{

constexpr const char MAIN_NET_COLOR[] = "#EE4486";
constexpr const char STAGE_NET_COLOR[] = "#44EE86";
constexpr const char TEST_NET_COLOR[] = "#8644EE";

bool isTransactionSpendTimeUnlocked(uint64_t unlockTime, uint32_t blockIndex, uint64_t blockTimestampMedian);
QString formatUnsignedAmount(quint64 amount, bool trim = true);
QString formatAmount(qint64 amount);
QString formatHashRate(quint64 hashRate);
//quint64 convertAmountFromHumanReadable(double amount);
bool parseAmount(const QString& str, qint64& amount);

bool isIpOrHostName(const QString& string);

QString rpcUrlToString(const QUrl& url);

QString formatTimeDiff(quint64 timeDiff);

void scaleWidgetText(QWidget* w, int scale);

}

#endif // COMMON_H

