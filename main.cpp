#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "controller.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Controller controller;
    engine.rootContext()->setContextProperty("Controller", &controller);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    QObject* home = engine.rootObjects().first();

    QObject::connect(home, SIGNAL(stopWatchStartRestartSignal()),
                     &controller, SLOT(startStopwatchSlot()));
    QObject::connect(home, SIGNAL(stopWatchStopSignal()),
                     &controller, SLOT(stopStopwatch()));
    QObject::connect(home, SIGNAL(stopWatchPauseSignal()),
                     &controller, SLOT(stopwatchPauseSlot()));

    QObject::connect(home, SIGNAL(timerStart(int, int, int)),
                     &controller, SLOT(timerStart(int, int, int)));
    QObject::connect(home, SIGNAL(timerStop()),
                     &controller, SLOT(timerStop()));

    return app.exec();
}
