#ifndef BENCHMARK_H
#define BENCHMARK_H

#include <QProcess>
#include <QObject>
#include <QProgressBar>

class Benchmark : public QObject
{
  Q_OBJECT
  Q_DISABLE_COPY(Benchmark)

public:
  Benchmark();
  ~Benchmark();

  QString getFIOVersion() const;
  bool isFIODetected() const;

  void setDir(const QString &dir);
  QString getBenchmarkFile() const;

  void setRunning(bool &state);
  bool isRunning() const;

  //  void runBenchmark(QList<QPair<QPair<Global::BenchmarkTest, Global::BenchmarkIOReadWrite>, QVector<QProgressBar*>>> tests);

  struct PerformanceResult {
    float Bandwidth, IOPS, Latency;

    PerformanceResult(float Bandwidth_=0, float IOPS_=0, float Latency_=0) {
      Bandwidth = Bandwidth_; IOPS = IOPS_; Latency = Latency_;
    }

    PerformanceResult operator+(const PerformanceResult &rhs) { return *this += rhs; }
    PerformanceResult operator+=(const PerformanceResult &rhs) {
      Bandwidth += rhs.Bandwidth;
      IOPS += rhs.IOPS;
      Latency += rhs.Latency;
      return *this;
    }
    PerformanceResult operator/(const unsigned int rhs) const {
      if (rhs == 0) return *this;
      return PerformanceResult{Bandwidth * rhs, IOPS * rhs, Latency * rhs};
    }

    void updateWithBetterValues(const PerformanceResult &result) {
      Bandwidth = Bandwidth < result.Bandwidth ? result.Bandwidth : Bandwidth;
      IOPS = IOPS < result.IOPS ? result.IOPS : IOPS;
      if (Latency == 0) Latency = result.Latency;
      Latency = Latency > result.Latency ? result.Latency : Latency;
    }
  };

  struct ParsedJob { PerformanceResult read, write; };

private:
  bool m_running, m_helperAuthorized;
  QString m_FIOVersion, m_dir;
  QVector<QProgressBar*> m_progressBars;

  void startTest(const int &blockSize, const int &queueDepth, const int &thread, const QString &rw, const QString &statusMessage);
  Benchmark::ParsedJob parseResult(const QString &output, const QString &errorOutput);
  void sendResult(const Benchmark::PerformanceResult &result, const int &index);

  void initSession();
  void prepareFile(const QString &benchmarkFile, const int &fileSize);

signals:
  void benchmarkStatusUpdate(const QString &name);
  void resultReady(QProgressBar *progressBar, const Benchmark::PerformanceResult &result);
  void failed(const QString &error);
  void finished();
  void runningStateChanged(const bool &state);
};

#endif // BENCHMARK_H
