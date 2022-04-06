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
