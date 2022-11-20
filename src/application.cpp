#include "application.h"

#include <QApplication>
#include <QFontDatabase>
#include <QLoggingCategory>
#include <QUndoStack>
//#include <QLibraryInfo>
//#include <QQmlFileSelector>
//#include <QTranslator>


Q_LOGGING_CATEGORY(lcApplication, "app.application")

static QGuiApplication *createApplication(int &argc, char **argv, const QString &applicationName) {
  QLoggingCategory::setFilterRules("app.* = false\ntests.* = false\nui.* = false");

  QApplication::setOrganizationName("arielen");
  QApplication::setOrganizationDomain("arielen");
  QApplication::setApplicationName(applicationName);
  QApplication::setApplicationDisplayName("DiskMark - Check Storages");
  QApplication::setApplicationVersion("0.01b");

  QApplication *app = new QApplication(argc, argv);
  return app;
}

Application::Application(int &argc, char **argv, const QString &applicationName) :
  mApplication(createApplication(argc, argv, applicationName)),
  mSettings(new ApplicationSettings),
  mEngine(new QQmlApplicationEngine) {
  qCDebug(lcApplication) << "constructing Application...";
  registerQmlTypes();
  addFonts();
  installTranslators();

#if defined(Q_OS_WIN) || defined (Q_OS_MACOS)
  QQmlFileSelector fileSelector(mEngine.data());
  fileSelector.setExtraSelectors(QStringList() << QLatin1String("nativemenubar"));
#endif

  mEngine->rootContext()->setContextProperty("settings", mSettings.data());
  mEngine->rootContext()->setContextProperty("qtVersion", QT_VERSION_STR);

  qCDebug(lcApplication) << "Loading main.qml...";
  mEngine->load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
  if (!mEngine->rootObjects().isEmpty())
    qCDebug(lcApplication) << "... loaded main.qml";
  else
    qCDebug(lcApplication) << "... failed to load main.qml";

  qCDebug(lcApplication) << "... constructed Application";
}

Application::~Application() {
  mEngine.reset();
}

int Application::run() {
  return mApplication->exec();
}

ApplicationSettings *Application::settings() const {
  return mSettings.data();
}

QQmlApplicationEngine *Application::qmlEngine() const {
  return mEngine.data();
}

void Application::registerQmlTypes() {
  qRegisterMetaType<ApplicationSettings*>();
  qRegisterMetaType<QUndoStack*>();
}

void Application::addFonts() {
  const QVector<QString> fontsToLoad = {
    QStringLiteral(":/fonts/FiraSans/FiraSans-Regular.ttf"),
    QStringLiteral(":/fonts/FiraSans/FiraSans-Italic.ttf"),
    QStringLiteral(":/fonts/FiraSans/FiraSans-Regular.ttf"),
  };
  for (const QString &fontPath : fontsToLoad)
    if (QFontDatabase::addApplicationFont(fontPath) == -1)
      qWarning() << "Failde to load font: " << fontPath;
}


void Application::installTranslators() {
  const QLocale locale(mSettings->language());

  QDir diskMarkTranslationsDir = QDir::current();
  #if defined(Q_OS_WIN32)
    diskMarkTranslationsDir.cd(QStringLiteral("data/translations"));
  #elif defined(Q_OS_MAC)
    diskMarkTranslationsDir.cdUp();
    diskMarkTranslationsDir.cd(QStringLiteral("Data/Translations"));
  #else
    diskMarkTranslationsDir.cd(QStringLiteral("data/translations"));
  #endif
  qCDebug(lcApplication) << "looking for translation for" << locale.name()
                         << "locale in" << diskMarkTranslationsDir.absolutePath();

  QTranslator *diskMarkTranslator = new QTranslator(mApplication.data());
  if (diskMarkTranslator->load(locale, QStringLiteral("DiskMark_"), QString(), diskMarkTranslationsDir.absolutePath()))
      mApplication->installTranslator(diskMarkTranslator);
  else {
      qWarning() << "Failed to load DiskMark_* translation for locale" << locale.name() << "from" << diskMarkTranslationsDir.absolutePath();
      delete diskMarkTranslator;
      diskMarkTranslator = nullptr;
  }

  const QString qtTranslationsDir = QLibraryInfo::path(QLibraryInfo::TranslationsPath);
  QTranslator *qtTranslator = new QTranslator(mApplication.data());
  if (qtTranslator->load(locale, QStringLiteral("qt_"), QString(), qtTranslationsDir))
    mApplication->installTranslator(qtTranslator);
  else {
    qWarning() << "Failed to load qt_* translation for locale" << locale.name() << "from" << qtTranslationsDir;
    delete qtTranslator;
    qtTranslator = nullptr;
  }
}
