#ifndef APPLICATION_H
#define APPLICATION_H

#include <QGuiApplication>
#include <QScopedPointer>
#include <QtQml>
#include <QQuickItem>
#include <QApplicationStateChangeEvent>

#include "applicationsettings.h"

class Application
{
public:
  Application(int &argc, char **argv, const QString &applicationName);
  ~Application();

  QQmlApplicationEngine *qmlEngine() const;
  ApplicationSettings *settings() const;
//  ProjectManager *projectManager();

  int run();

private:
  void registerQmlTypes();
  void addFonts();
  void installTranslators();

  QScopedPointer<QGuiApplication> mApplication;
  QScopedPointer<QQmlApplicationEngine> mEngine;
  QScopedPointer<ApplicationSettings> mSettings;
  //  ProjectManager mProjectManager;
};

#endif // APPLICATION_H
