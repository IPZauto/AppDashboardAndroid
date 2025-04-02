#include "game.h"
#include <QString>

void Game::setPlacement(
    const float x,
    const float y,
    const float z,
    const float heading,
    const float pitch,
    const float roll
    ){
    GameInfo.placement.x=x;
    GameInfo.placement.y=y;
    GameInfo.placement.z=z;
    GameInfo.placement.heading=heading;
    GameInfo.placement.pitch=pitch;
    GameInfo.placement.roll=roll;
}

void Game::setConnected(const bool connected){
    GameInfo.connected=connected;
}

void Game::setPaused(const bool paused){
    GameInfo.paused=paused;
}

void Game::setDate(const QString date){
    GameInfo.date=date;
}

void Game::setSpeed(const int speed){
    if (Truck.speed==speed) return;
    Truck.speed=speed;
    emit speedChanged();
}

void Game::setRpm(const int rpm){
    if (Truck.engineRPM==rpm) return;
    Truck.engineRPM=rpm;
    emit rpmChanged();
}

void Game::setMaxRpm(const int maxRpm){
    if (Truck.engineRPMmax==maxRpm) return;
    Truck.engineRPMmax=maxRpm;
    emit maxRpmChanged();
}

void Game::setGear(const int gear){
    if (Truck.gear==gear) return;
    Truck.gear=gear;
    emit gearChanged();
}

void Game::setBatteryVoltageWarningOn(const bool on){
    if (Truck.batteryVoltageWarningOn==on) return;
    Truck.batteryVoltageWarningOn=on;
    emit batteryVoltageWarningOnChanged();
}

void Game::setFuelWarningOn(const bool warningOn){
    if (Truck.fuelWarningOn==warningOn) return;
    Truck.fuelWarningOn=warningOn;
    emit fuelWarningOnChanged();
}

void Game::setParkBrakeOn(const bool parkBrake){
    if (Truck.parkBrakeOn==parkBrake) return;
    Truck.parkBrakeOn=parkBrake;
    emit parkBrakeOnChanged();
}

void Game::setLDV(const float ldv){
    Truck.lightsDashboardValue=ldv;
}

void Game::setBlinkerRightActive(const bool blink){
    if (Truck.blinkerRightActive==blink) return;
    Truck.blinkerRightActive=blink;
    emit blinkerRightActiveChanged();
}

void Game::setBlinkerLeftActive(const bool blink){
    if (Truck.blinkerLeftActive==blink) return;
    Truck.blinkerLeftActive=blink;
    emit blinkerLeftActiveChanged();
}

void Game::setLightsOn(const bool lights){
    if (Truck.lightsOn==lights) return;
    Truck.lightsOn=lights;
    emit lightsOnChanged();
}

void Game::setHighBeamOn(const bool highBeam){
    if (Truck.highBeamOn==highBeam) return;
    Truck.highBeamOn=highBeam;
    emit highBeamOnChanged();
}

void Game::setCsOn(const bool csOn){
    if(Truck.cruiseControlOn==csOn) return;
    Truck.cruiseControlOn=csOn;
    emit csOnChanged();
}

void Game::setCsSpeed(const int speed){
    if(Truck.cruiseControlSpeed==speed)return;
    Truck.cruiseControlSpeed=speed;
    emit csSpeedChanged();
}

Placement Game::placement() const {return this->GameInfo.placement;}

bool Game::conneted() const {return this->GameInfo.connected;}

bool Game::paused() const {return this->GameInfo.paused;}

QString Game::date() const {return this->GameInfo.date;}

int Game::speed() const {return this->Truck.speed;}

int Game::rpm() const {return this->Truck.engineRPM;}

int Game::maxRpm() const {return this->Truck.engineRPMmax;}

int Game::gear() const {return Truck.gear;}

int Game::csSpeed() const {return Truck.cruiseControlSpeed;}

bool Game::fuelWarningOn() const {return this->Truck.fuelWarningOn;}

bool Game::parkBrakeOn() const {return this->Truck.parkBrakeOn;}

float Game::getLdv() const {return this->Truck.lightsDashboardValue;}

bool Game::blinkerLeftActive() const {return this->Truck.blinkerLeftActive;}

bool Game::blinkerRightActive() const {return this->Truck.blinkerRightActive;}

bool Game::lightsOn() const {return this->Truck.lightsOn;}

bool Game::highBeamOn() const {return this->Truck.highBeamOn;}

bool Game::batteryVoltageWarningOn() const {return Truck.batteryVoltageWarningOn;}

bool Game::csOn() const {return Truck.cruiseControlOn;}
