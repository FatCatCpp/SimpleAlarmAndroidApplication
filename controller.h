#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QSettings>

class Controller : public QObject
{
    Q_OBJECT
    int m_opacity;

    int m_voice;

    QString m_image;

    QString m_audio;

public:
    explicit Controller(QObject *parent = nullptr);

    Q_INVOKABLE QStringList createHours();
    Q_INVOKABLE QStringList createMinutes();

    Q_PROPERTY(int opacity READ opacity WRITE setOpacity NOTIFY opacityChanged)
    Q_PROPERTY(int voice READ voice WRITE setVoice NOTIFY voiceChanged)
    Q_PROPERTY(QString image READ image WRITE setImage NOTIFY imageChanged)
    Q_PROPERTY(QString audio READ audio WRITE setAudio NOTIFY audioChanged)

    int opacity() const;
    void setOpacity(int newOpacity);

    int voice() const;
    void setVoice(int newVoice);

    const QString &image() const;
    void setImage(const QString &newImage);

    const QString &audio() const;
    void setAudio(const QString &newAudio);

signals:

    void opacityChanged();
    void voiceChanged();
    void imageChanged();
    void audioChanged();
};

#endif // CONTROLLER_H
