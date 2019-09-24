#ifndef VERSION_H
#define VERSION_H

#include <QString>

namespace WalletGUI {

constexpr char VERSION[] = "0.9.7";
constexpr char CODENAME[] = "Start";
constexpr char VERSION_SUFFIX[] = "beta";
constexpr char REVISION[] = "20190924";

// returns <0, if newVersion is worse than currentVersion, returns >0, if newVersion is better, and returns 0, if versions are equal
int compareVersion(const QString& newVersion, const QString& currentVersion);
bool isStableVersion();
QString fullVersion();
QString shortVersion();

}

#endif // VERSION_H
