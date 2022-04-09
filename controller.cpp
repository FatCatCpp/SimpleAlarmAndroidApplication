#include "controller.h"

Controller::Controller(QObject *parent) : QObject(parent)
{

}

QStringList Controller::createHours() {
    QStringList hours;

    for (int i = 0; i < 24; ++i) {
        if (i < 10) {
            hours << QString("0") + QString::number(i);
        } else {
            hours << QString::number(i);
        }
    }

    return hours;
}

QStringList Controller::createMinutes() {
    QStringList minutes;

    for (int i = 0; i < 60; ++i) {
        if (i < 10) {
            minutes << QString("0") + QString::number(i);
        } else {
            minutes << QString::number(i);
        }
    }

    return minutes;
}

int Controller::opacity() const
{
    return m_opacity;
}

void Controller::setOpacity(int newOpacity)
{
    if (m_opacity == newOpacity)
        return;
    m_opacity = newOpacity;
    emit opacityChanged();
}

int Controller::voice() const
{
    return m_voice;
}

void Controller::setVoice(int newVoice)
{
    if (m_voice == newVoice)
        return;
    m_voice = newVoice;
    emit voiceChanged();
}

const QString &Controller::image() const
{
    return m_image;
}

void Controller::setImage(const QString &newImage)
{
    if (m_image == newImage)
        return;
    m_image = newImage;
    emit imageChanged();
}

const QString &Controller::audio() const
{
    return m_audio;
}

void Controller::setAudio(const QString &newAudio)
{
    if (m_audio == newAudio)
        return;
    m_audio = newAudio;
    emit audioChanged();
}
