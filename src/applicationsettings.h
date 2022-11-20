#ifndef APPLICATIONSETTINGS_H
#define APPLICATIONSETTINGS_H

#include <QSettings>
#include <QUrl>

class ApplicationSettings : public QSettings
{
public:
  explicit ApplicationSettings(QObject *parent = nullptr);

  QString language() const;
  QString defaultLanguage() const;
  void setLanguage(const QString &language);

  bool loadLastOnStartup() const;
  bool defaultLoadLastOnStartup() const;
  void setLoadLastOnStartup(bool &loadLastOnStartup);

  int getLoopsCount() const;
  void setLoopsCount(int loopsCount);
  static int defaultLoopsCount();

signals:
  void languageChanged();
  void loadLastOnStartupChanged();

};

#endif // APPLICATIONSETTINGS_H
