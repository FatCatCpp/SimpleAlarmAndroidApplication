#include "controller.h"

Controller::Controller(QObject *parent) : QObject(parent) {

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
    return _opacity;
}

void Controller::setOpacity(int newOpacity)
{
    if (_opacity == newOpacity)
        return;
    _opacity = newOpacity;
    emit opacityChanged();
}

int Controller::voice() const
{
    return _voice;
}

void Controller::setVoice(int newVoice)
{
    if (_voice == newVoice)
        return;
    _voice = newVoice;
    emit voiceChanged();
}

const QString &Controller::image() const
{
    return _image;
}

void Controller::setImage(const QString &newImage)
{
    if (_image == newImage)
        return;
    _image = newImage;
    emit imageChanged();
}

const QString &Controller::audio() const
{
    return _audio;
}

void Controller::setAudio(const QString &newAudio)
{
    if (_audio == newAudio)
        return;
    _audio = newAudio;
    emit audioChanged();
}

const QTime &Controller::alarmTime() const
{
    return _alarmTime;
}

void Controller::setAlarmTime(const QTime &newAlatmTime)
{
    if (_alarmTime == newAlatmTime)
        return;
    _alarmTime = newAlatmTime;
    emit alarmTimeChanged();
}
