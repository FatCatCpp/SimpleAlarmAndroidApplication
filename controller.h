#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>

class Controller : public QObject
{
    Q_OBJECT
public:
    explicit Controller(QObject *parent = nullptr);

    Q_INVOKABLE QStringList createHours();
    Q_INVOKABLE QStringList createMinutes();

signals:

};

#endif // CONTROLLER_H
