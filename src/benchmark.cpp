#include "benchmark.h"
#include "applicationsettings.h"
#include "global.h"

Benchmark::Benchmark() {
  m_running = false;

  QProcess process;
  process.start("fio", {"--version"});
  process.waitForFinished();

  m_FIOVersion = process.readAllStandardOutput().simplified();
  process.close();
}

Benchmark::~Benchmark() {}

QString Benchmark::getFIOVersion() const { return m_FIOVersion; }
bool Benchmark::isFIODetected() const { return m_FIOVersion.indexOf("fio-") == 0; }
void Benchmark::setDir(const QString &dir) { m_dir = dir; }

QString Benchmark::getBenchmarkFile() const {
  if (m_dir.isNull()) return QString();
  if (m_dir.endsWith("/")) return m_dir + ".diskmark.tmp";
  else return m_dir + "/.diskmark.tmp";
}

void Benchmark::startTest(const int &blockSize, const int &queueDepth, const int &thread, const QString &rw, const QString &statusMessage) {
  const ApplicationSettings settings;

  PerformanceResult totalRead{}, totalWtite{};
  unsigned int index = 0;

//  for (int i = 0; i < settings.getLoopsCount(); ++i) {
//    if (!m_running) break;
//    emit benchmarkStatusUpdate(statusMessage.arg(index + 1).arg(settings.getLoopsCount()));
//    auto interface = helperInterface();
//  }

}
