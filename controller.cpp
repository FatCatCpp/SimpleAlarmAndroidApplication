#include "controller.h"

#include <QDebug>

Controller::Controller(QObject *parent) : QObject(parent)
    , _isActive(false) {

    _alarmTimer = new QTimer(this);
    QTime time(21, 36);
    _alarmTimer->setInterval(createMillisecondsInterval(time));

    connect(_alarmTimer, &QTimer::timeout, this, [=]() {
        emit goAlarm();
    });

    _lastTime = _centisecond = _second = _minute = _hour = 0;

    _stopwatchTimer = new QTimer(this);
    _stopwatchTimer->setInterval(10);
    connect(_stopwatchTimer, &QTimer::timeout, this, [=]() {
//        emit goAlarm();
        update();
    });

    _timerTimer = new QTimer(this);
    _timerTimer->setInterval(1000);
    connect(_timerTimer, &QTimer::timeout, this, [=]() {
        updateTimerTime();
    });
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

int Controller::opacity() const {
    return _opacity;
}

void Controller::setOpacity(int newOpacity) {
    if (_opacity == newOpacity) {
        return;
    }

    _opacity = newOpacity;
    emit opacityChanged();
}

int Controller::voice() const {
    return _voice;
}

void Controller::setVoice(int newVoice) {
    if (_voice == newVoice) {
        return;
    }

    _voice = newVoice;
    emit voiceChanged();
}

const QString &Controller::image() const {
    return _image;
}

void Controller::setImage(const QString &newImage) {
    if (_image == newImage) {
        return;
    }

    _image = newImage;
    emit imageChanged();
}

const QString &Controller::audio() const {
    return _audio;
}

void Controller::setAudio(const QString &newAudio) {
    if (_audio == newAudio) {
        return;
    }

    _audio = newAudio;
    emit audioChanged();
}

const QTime &Controller::alarmTime() const {
    return _alarmTime;
}

void Controller::setAlarmTime(const QTime &newAlatmTime) {
    if (_alarmTime == newAlatmTime) {
        return;
    }

    _alarmTime = newAlatmTime;
    emit alarmTimeChanged();
}

int Controller::createMillisecondsInterval(QTime time) {
    return (time.msecsSinceStartOfDay() - QTime::currentTime().msecsSinceStartOfDay());
}

QString Controller::getTimeStr() {
    std::string tmp =
            (_hour < 10 ? "0" : "") + std::to_string(_hour) + ":" +
            (_minute % 60 < 10 ? "0" : "") + std::to_string(_minute % 60) + ":" +
            (_second % 60 < 10 ? "0" : "") + std::to_string(_second % 60) + "." +
            (_centisecond % 100 < 10 ? "0" : "") + std::to_string(_centisecond % 100);

    return QString::fromStdString(tmp);
}

void Controller::updateTimes() {
    _centisecond = (_elapsedTimer.elapsed() + _lastTime) / 10;
    _second = _centisecond / 100;
    _minute = _second / 60;
    _hour = _minute / 60;
}

void Controller::updateTimerTime() {
    if (_timerTime != QTime(0, 0, 0)) {
        _timerTime = _timerTime.addSecs(-1);
        emit goTimer(_timerTime.toString("hh:mm:ss"));
    } else {
        emit timerFinished();
    }
}

void Controller::update() {
    updateTimes();
    emit goStopwatch(getTimeStr());
}

void Controller::startStopwatchSlot() {
    _elapsedTimer.start();
    _stopwatchTimer->start();
    _isActive = true;
}

void Controller::stopStopwatch() {
    _centisecond = _second = _minute = _hour = _lastTime = 0;
    emit goStopwatch(getTimeStr());
}

void Controller::timerStart(int hour, int minutes, int sec) {
    QTime time(hour, minutes, sec);
    _timerTime = std::move(time);
    _timerTimer->start();
}

void Controller::timerStop() {
    _timerTimer->stop();
    //    emit
}

void Controller::stopwatchPauseSlot() {
    _isActive = false;
    _stopwatchTimer->stop();
    _lastTime = _elapsedTimer.elapsed();
    emit stopwatchPause();
}
