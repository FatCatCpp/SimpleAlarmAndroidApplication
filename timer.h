#ifndef TIMER_H
#define TIMER_H

#include <QObject>

class Timer : public QObject
{
    Q_OBJECT
public:
    explicit Timer(QObject *parent = nullptr);

signals:

};

#endif // TIMER_H
