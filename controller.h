#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QSettings>
#include <QTime>
#include <QTimer>
#include <QElapsedTimer>

class Controller : public QObject
{
    Q_OBJECT

public:
    explicit Controller(QObject *parent = nullptr);

    Q_INVOKABLE QStringList createHours();
    Q_INVOKABLE QStringList createMinutes();

    Q_PROPERTY(int opacity READ opacity WRITE setOpacity NOTIFY opacityChanged)
    Q_PROPERTY(int voice READ voice WRITE setVoice NOTIFY voiceChanged)
    Q_PROPERTY(QString image READ image WRITE setImage NOTIFY imageChanged)
    Q_PROPERTY(QString audio READ audio WRITE setAudio NOTIFY audioChanged)

    Q_PROPERTY(QTime alarmTime READ alarmTime WRITE setAlarmTime NOTIFY alarmTimeChanged)

    int opacity() const;
    void setOpacity(int newOpacity);

    int voice() const;
    void setVoice(int newVoice);

    const QString &image() const;
    void setImage(const QString &newImage);

    const QString &audio() const;
    void setAudio(const QString &newAudio);

    const QTime &alarmTime() const;
    void setAlarmTime(const QTime &newAlatmTime);

private:
    int createMillisecondsInterval(QTime time);

    QString getTimeStr();
    void updateTimes();
    void updateTimerTime();
//    Q_INVOKABLE void startStopwatch();

public slots:
    void update();
    void startStopwatchSlot();
    void stopStopwatch();
    void timerStart(int hour, int minutes, int sec);
    void timerStop();
    void stopwatchPauseSlot();

signals:
    void opacityChanged();
    void voiceChanged();
    void imageChanged();
    void audioChanged();
    void alarmTimeChanged();

    void goAlarm();
    void goStopwatch(const QString& timeString);
    void goTimer(const QString& timeString);

    void alarmFinished();
    void timerFinished();

    void stopwatchPause();
    void timerPause();

private:
    int _opacity;
    int _voice;
    QString _image;
    QString _audio;

    QTime _alarmTime;
    QTime _timerTime;
    QTimer *_alarmTimer;
    QTimer *_stopwatchTimer;
    QTimer *_timerTimer;

    QElapsedTimer _elapsedTimer;
    qint64 _elapsedTimerPrev;
    QTimer* _intervalTimer;

    long _centisecond, _second, _minute, _hour, _lastTime;
    bool _isActive;
};

#endif // CONTROLLER_H
