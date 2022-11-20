#include "applicationsettings.h"

#include <QLoggingCategory>

Q_LOGGING_CATEGORY(lcApplicationSettings, "app.applicationsettings")

ApplicationSettings::ApplicationSettings(QObject *parent) :
  QSettings(parent) {
  qCDebug(lcApplicationSettings) << "Loading setting from" << fileName();
}

QString ApplicationSettings::defaultLanguage() const {
  return "ru_RU";
}

QString ApplicationSettings::language() const {
  return contains("language") ? value("language").toString() : defaultLanguage();
}

void ApplicationSettings::setLanguage(const QString &language) {
  const QString existingValue = value("language", defaultLanguage()).toString();
  if (language == existingValue) return;
  setValue("language", language);
//  emit languageChanged();
}

bool ApplicationSettings::defaultLoadLastOnStartup() const { return false; }

bool ApplicationSettings::loadLastOnStartup() const {
  return contains("loadLastOnStartup") ? value("loadLastOnStartup").toBool() : defaultLoadLastOnStartup();
}

void ApplicationSettings::setLoadLastOnStartup(bool &loadLastOnStartup) {
  const bool existingValue = value("loadLastOnStartup", defaultLoadLastOnStartup()).toBool();
  if (loadLastOnStartup == existingValue) return;
  setValue("loadLastOnStartup", loadLastOnStartup);
//  emit loadLastOnStartupChanged();
}
