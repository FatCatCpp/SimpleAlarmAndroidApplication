#include "controller.h"

#include <QDebug>

Controller::Controller(QObject *parent) : QObject(parent)
    , _isActiveStopwatch(false)
    , _isActiveTimer(false)
    , _isFirstTurnTimer(true) {

    _alarmTimer = new QTimer(this);
    QTime time(21, 36);
    _alarmTimer->setInterval(createMillisecondsInterval(time));

    connect(_alarmTimer, &QTimer::timeout, this, [=]() {
        emit goAlarm();
    });

    QTime stopwatchTimeDefault(0, 0, 0, 0);
    _stopwatchTime = std::move(stopwatchTimeDefault);
    _stopwatchTimer = new QTimer(this);
    _stopwatchTimer->setInterval(10);
    connect(_stopwatchTimer, &QTimer::timeout, this, [=]() {
        updateStopwatchTime();
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

void Controller::updateTimerTime() {
    if (_timerTime != QTime(0, 0, 0)) {
        _timerTime = _timerTime.addSecs(-1);
        emit goTimer(_timerTime.toString("hh:mm:ss"));
    } else {
        emit timerFinished();
    }
}

void Controller::updateStopwatchTime() {
    _stopwatchTime = _stopwatchTime.addMSecs(10);
    emit goStopwatch(_stopwatchTime.toString("hh:mm:ss.zzz"));
}

void Controller::startStopwatchSlot() {
    if (!_isActiveStopwatch) {
        _stopwatchTimer->start();
        _isActiveStopwatch = true;
    } else {
        _stopwatchTimer->stop();
        _isActiveStopwatch = false;
        emit stopwatchPause();
    }
}

void Controller::stopStopwatch() {
    _stopwatchTime = QTime(0, 0, 0, 0);
    emit goStopwatch(_stopwatchTime.toString("hh:mm:ss.zzz"));
}

void Controller::timerStart(int hour, int minutes, int sec) {
    if (!_isActiveTimer) {
        if (_isFirstTurnTimer) {
            QTime time(hour, minutes, sec);
            _timerTime = std::move(time);
        } else {
            QTime time(_activeHour, _activeMinute, _activeSecond);
            _timerTime = std::move(time);
        }

        _timerTimer->start();
        _isActiveTimer = true;
    } else {
        _timerTimer->stop();
        _isActiveTimer = false;

        _activeHour = _timerTime.hour();
        _activeMinute = _timerTime.minute();
        _activeSecond = _timerTime.second();

        emit timerPause(_timerTime.hour(), _timerTime.minute(), _timerTime.second());
    }
}

void Controller::timerStop() {
    _timerTimer->stop();
}
