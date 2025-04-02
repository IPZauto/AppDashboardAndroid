#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "game.h"
#include "networkdata.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Game backend;

    NetworkData network(&app,TELEMETREY_URL,&backend);

    engine.rootContext()->setContextProperty("backend", &backend);
    engine.rootContext()->setContextProperty("network",&network);

    const QUrl url(QStringLiteral("qrc:/AppDashboardAndroid/qml/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
