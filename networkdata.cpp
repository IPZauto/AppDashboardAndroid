#include "networkdata.h"

NetworkData::NetworkData(QObject *parent, QString url, Game *game)
    : QObject{parent}, m_url{QUrl(url)}, m_gameData{game}
{
    m_manager = new QNetworkAccessManager(this);

    //sets timer to fetch data padriodically
    m_timer = new QTimer(this);
    connect(m_timer, &QTimer::timeout, this, &NetworkData::fetchTelemetryData);

    // Start the timer (every 10 ms = 0.01s)
    m_timer->start(10);
}

NetworkData::~NetworkData(){
    delete m_timer;
    delete m_manager;
}

void NetworkData::fetchTelemetryData(){

    QNetworkRequest request(m_url);

    //sends request to the server for telemetry
    QNetworkReply *reply = m_manager->get(request);

    //getting response
    connect(reply, &QNetworkReply::finished, this, [this,reply](){
        if (reply->error() == QNetworkReply::NoError){
            QByteArray response_data = reply->readAll();
            QJsonDocument jsonResponse = QJsonDocument::fromJson(response_data);

            if(!jsonResponse.isNull()){
                QJsonObject rootObject = jsonResponse.object();
                // Extract game data
                if (rootObject.contains("game") && rootObject["game"].isObject()){
                    QJsonObject gameObject = rootObject["game"].toObject();

                    m_gameData->setConnected(gameObject["connected"].toBool());
                    QString data = gameObject["time"].toString();

                    m_gameData->setDate(gameObject["time"].toString());
                    m_gameData->setTime(gameObject["time"].toString());
                    m_gameData->setPaused(gameObject["paused"].toBool());
                }
                // Extract placement data

                // Extract truck data
                if (rootObject.contains("truck") && rootObject["truck"].isObject()){
                    QJsonObject truck = rootObject["truck"].toObject();

                    m_gameData->setSpeed(abs(truck["speed"].toDouble()));
                    m_gameData->setRpm(truck["engineRpm"].toDouble());
                    m_gameData->setMaxRpm(truck["engineRpmMax"].toDouble());
                    m_gameData->setFuelWarningOn(truck["fuelWarningOn"].toBool());
                    m_gameData->setBlinkerLeftActive(truck["blinkerLeftOn"].toBool());
                    m_gameData->setBlinkerRightActive(truck["blinkerRightOn"].toBool());
                    m_gameData->setLightsOn(truck["lightsBeamLowOn"].toBool());
                    m_gameData->setHighBeamOn(truck["lightsBeamHighOn"].toBool());
                    m_gameData->setParkBrakeOn(truck["parkBrakeOn"].toBool());
                    m_gameData->setGear(truck["gear"].toInt());
                    m_gameData->setBatteryVoltageWarningOn(truck["batteryVoltageWarningOn"].toBool());
                    m_gameData->setCsOn(truck["cruiseControlOn"].toBool());
                    m_gameData->setCsSpeed(truck["cruiseControlSpeed"].toInt());

                    //extract truck placement
                    QJsonObject placement = truck["placement"].toObject();
                    m_gameData->setPlacement(
                        placement["x"].toDouble(),
                        placement["y"].toDouble(),
                        placement["z"].toDouble(),
                        placement["heading"].toDouble(),
                        placement["pitch"].toDouble(),
                        placement["roll"].toDouble()
                        );
                }


            }else{
                qDebug()<<"Failed to parse JSON.";
            }
        }else{
            qDebug() << "Error:" <<reply->errorString();
        }
        reply->deleteLater();
    });
}

void NetworkData::setUrl(const QString url){
    qDebug() << "done";
    dialogUrl = url;
    m_url = QUrl(dialogUrl);
    emit urlChanged();
}

QString NetworkData::url() const{return dialogUrl;}
