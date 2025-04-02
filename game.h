#ifndef GAME_H
#define GAME_H

#include <QObject>
#include <QString>

struct Placement
{
    float x;        // X coordinate in the world
    float y;        // Y coordinate in the world
    float z;        // Z coordinate in the world
    float heading;  // The angle is measured counterclockwise in horizontal plane
                    // when looking from top where 0 corresponds to forward (north),
                    // 0.25 to left (west), 0.5 to backward (south) and 0.75 to right (east).
                    // Stored in unit range where (0,1) corresponds to (0,360).

    float pitch;    // The pitch angle is zero when in horizontal direction,
                    // with positive values pointing up (0.25 directly to zenith),
                    // and negative values pointing down (-0.25 directly to nadir).
                    // Stored in unit range where (-0.25,0.25) corresponds to (-90,90).

    float roll;     // The angle is measured in counterclockwise
                    // when looking in direction of the roll axis.
                    // Stored in unit range where (-0.5,0.5) corresponds to (-180,180).
};

class Game : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int speed READ speed WRITE setSpeed NOTIFY speedChanged FINAL)
    Q_PROPERTY(int engineRPM READ rpm WRITE setRpm NOTIFY rpmChanged FINAL)
    Q_PROPERTY(int engineRPMmax READ maxRpm WRITE setMaxRpm NOTIFY maxRpmChanged FINAL)
    Q_PROPERTY(bool fuelWarningOn READ fuelWarningOn WRITE setFuelWarningOn NOTIFY fuelWarningOnChanged FINAL)
    Q_PROPERTY(bool parkBrakeOn READ parkBrakeOn WRITE setParkBrakeOn NOTIFY parkBrakeOnChanged FINAL)
    Q_PROPERTY(bool blinkerRightActive READ blinkerRightActive WRITE setBlinkerRightActive NOTIFY blinkerRightActiveChanged FINAL)
    Q_PROPERTY(bool blinkerLeftActive READ blinkerLeftActive WRITE setBlinkerLeftActive NOTIFY blinkerLeftActiveChanged FINAL)
    Q_PROPERTY(bool lightsOn READ lightsOn WRITE setLightsOn NOTIFY lightsOnChanged FINAL)
    Q_PROPERTY(bool highBeamOn READ highBeamOn WRITE setHighBeamOn NOTIFY highBeamOnChanged FINAL)
    Q_PROPERTY(int gear READ gear WRITE setGear NOTIFY gearChanged FINAL)
    Q_PROPERTY(int csSpeed READ csSpeed WRITE setCsSpeed NOTIFY csSpeedChanged FINAL)
    Q_PROPERTY(bool csOn READ csOn WRITE setCsOn NOTIFY csOnChanged FINAL)
    Q_PROPERTY(bool batteryVoltageWarningOn READ batteryVoltageWarningOn WRITE setBatteryVoltageWarningOn NOTIFY batteryVoltageWarningOnChanged FINAL)

public:
    explicit Game(QObject *parent = nullptr){
        GameInfo.placement.x=0.0;
        GameInfo.placement.y=0.0;
        GameInfo.placement.z=0.0;
        GameInfo.placement.heading=0.0;
        GameInfo.placement.pitch=0.0;
        GameInfo.placement.roll=0.0;
        GameInfo.connected=false;
        GameInfo.paused=true;
        GameInfo.date="1 sty 2025 00:00:00";
        setSpeed(0);
        setRpm(0);
        setMaxRpm(0);
        setGear(0);
        setFuelWarningOn(false);
        setBlinkerLeftActive(false);
        setBlinkerRightActive(false);
        setHighBeamOn(false);
        Truck.lightsDashboardValue=0.0;
        setParkBrakeOn(false);
        setLightsOn(false);
        setBatteryVoltageWarningOn(false);
        setCsSpeed(0);
        setCsOn(false);
    };

    // settery
    void setPlacement(
                    const float x,
                    const float y,
                    const float z,
                    const float heading,
                    const float pitch,
                    const float roll
        );
    void setConnected(const bool);

    void setPaused(const bool);

    void setDate(const QString);

    void setSpeed(const int);

    void setRpm(const int);

    void setMaxRpm(const int);

    void setFuelWarningOn(const bool);

    void setParkBrakeOn(const bool);

    void setLDV(const float);

    void setBlinkerRightActive(const bool);

    void setBlinkerLeftActive(const bool);

    void setLightsOn(const bool);

    void setHighBeamOn(const bool);

    void setGear(const int);

    void setBatteryVoltageWarningOn(const bool);

    void setCsSpeed(const int);

    void setCsOn(const bool);
    // gettery

    Placement placement() const;
    bool conneted() const;
    bool paused() const;
    QString date() const;

    int speed() const;
    int rpm() const;
    int maxRpm() const;
    int gear() const;
    bool fuelWarningOn() const;
    bool parkBrakeOn() const;
    float getLdv() const;
    bool blinkerRightActive() const;
    bool blinkerLeftActive() const;
    bool lightsOn() const;
    bool highBeamOn() const;
    bool batteryVoltageWarningOn() const;
    int csSpeed() const;
    bool csOn() const;


signals:
    void speedChanged();
    void rpmChanged();
    void maxRpmChanged();
    void fuelWarningOnChanged();
    void parkBrakeOnChanged();
    void blinkerLeftActiveChanged();
    void blinkerRightActiveChanged();
    void lightsOnChanged();
    void highBeamOnChanged();
    void gearChanged();
    void batteryVoltageWarningOnChanged();
    void csSpeedChanged();
    void csOnChanged();

private:
    struct GameInfo{
        Placement placement;

        bool connected;     // indicates wheater the telemetry server is connected to the game

        bool paused;        // true if game is currently paused, false otherwise

        QString date;

    }GameInfo;

    struct Truck{
        int speed;        // truck speed

        int engineRPM;    // truck RPM

        int engineRPMmax;

        int gear;

        int cruiseControlSpeed;

        bool fuelWarningOn;

        bool batteryVoltageWarningOn;

        bool parkBrakeOn;

        float lightsDashboardValue;

        bool blinkerRightActive;
        bool blinkerLeftActive;  //if both true hazard lights are on

        bool lightsOn;
        bool highBeamOn;

        bool cruiseControlOn;

    }Truck;

};



#endif // GAME_H

/* reference
 * {"game":{
 * "connected":false,
 * "gameName":"ETS2",
 * "paused":true,
 * "time":"0001-01-01T00:00:00Z",
 * "timeScale":0.0,
 * "nextRestStopTime":"0001-01-01T00:00:00Z",
 * "version":"1.18",
 * "telemetryPluginVersion":"9"},
 *
 * "truck":{
 * "id":"mercedes",
 * "make":"Mercedes-Benz",
 * "model":"New Actros",
 * "speed":0.0,
 * "cruiseControlSpeed":0.0,
 * "cruiseControlOn":false,
 * "odometer":0.0,
 * "gear":0,
 * "displayedGear":0,
 * "forwardGears":12,
 * "reverseGears":4,
 * "shifterType":"arcade",
 * "engineRpm":0.0,
 * "engineRpmMax":2300.0,
 * "fuel":0.0,
 * "fuelCapacity":1140.0,
 * "fuelAverageConsumption":0.0,
 * "fuelWarningFactor":0.15,
 * "fuelWarningOn":false,
 * "wearEngine":0.0,
 * "wearTransmission":0.0,
 * "wearCabin":0.0,
 * "wearChassis":0.0,
 * "wearWheels":0.0,
 * "userSteer":0.0,
 * "userThrottle":0.0,
 * "userBrake":0.0,
 * "userClutch":0.0,
 * "gameSteer":0.0,
 * "gameThrottle":0.0,
 * "gameBrake":0.0,
 * "gameClutch":0.0,
 * "shifterSlot":0,
 * "engineOn":false,
 * "electricOn":false,
 * "wipersOn":false,
 * "retarderBrake":0,
 * "retarderStepCount":4,
 * "parkBrakeOn":false,
 * "motorBrakeOn":false,
 * "brakeTemperature":0.0,
 * "adblue":0.0,
 * "adblueCapacity":90.0,
 * "adblueAverageConsumption":0.0,
 * "adblueWarningOn":false,
 * "airPressure":0.0,
 * "airPressureWarningOn":false,
 * "airPressureWarningValue":80.04,
 * "airPressureEmergencyOn":false,
 * "airPressureEmergencyValue":40.02,
 * "oilTemperature":0.0,
 * "oilPressure":0.0,
 * "oilPressureWarningOn":false,
 * "oilPressureWarningValue":10.15,
 * "waterTemperature":0.0,
 * "waterTemperatureWarningOn":false,
 * "waterTemperatureWarningValue":95.0,
 * "batteryVoltage":0.0,
 * "batteryVoltageWarningOn":false,
 * "batteryVoltageWarningValue":23.76,
 * "lightsDashboardValue":0.0,
 * "lightsDashboardOn":false,
 * "blinkerLeftActive":false,
 * "blinkerRightActive":false,
 * "blinkerLeftOn":false,
 * "blinkerRightOn":false,
 * "lightsParkingOn":false,
 * "lightsBeamLowOn":false,
 * "lightsBeamHighOn":false,
 * "lightsAuxFrontOn":false,
 * "lightsAuxRoofOn":false,
 * "lightsBeaconOn":false,
 * "lightsBrakeOn":false,
 * "lightsReverseOn":false,
 * "placement":{"x":0.0,"y":0.0,"z":0.0,"heading":0.0,"pitch":0.0,"roll":0.0},"acceleration":{"x":0.0,"y":0.0,"z":0.0},"head":{"x":-0.717515469,"y":1.603781,"z":0.5479934},"cabin":{"x":8.11042835E-16,"y":1.21850824,"z":-2.50167227},"hook":{"x":0.0,"y":1.0,"z":1.45}},"trailer":{"attached":false,"id":"","name":"","mass":0.0,"wear":0.0,"placement":{"x":0.0,"y":0.0,"z":0.0,"heading":0.0,"pitch":0.0,"roll":0.0}},"job":{"income":0,"deadlineTime":"0001-01-01T00:00:00Z","remainingTime":"0001-01-01T00:00:00Z","sourceCity":"","sourceCompany":"","destinationCity":"","destinationCompany":""},"navigation":{"estimatedTime":"0001-01-01T00:00:00Z","estimatedDistance":0,"speedLimit":0}}
 */
