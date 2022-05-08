#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QSettings>
#include <QTime>
#include <QTimer>

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

signals:
    void opacityChanged();
    void voiceChanged();
    void imageChanged();
    void audioChanged();
    void alarmTimeChanged();
    void goAlarm();

private:
    int _opacity;
    int _voice;
    QString _image;
    QString _audio;

    QTime _alarmTime;
    QTimer *alarm;
};

#endif // CONTROLLER_H
