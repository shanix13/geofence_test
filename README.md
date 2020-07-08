# geofence_test

# version v1.0.0+1

A Geofence test app

## Getting Started

Application contains 2 screen Home and Logs

Home:

- Is the main view for application contains map that will display use location and whether used inside or outside geofence
- If user INSIDE geofence a circle with GREEN color will be drawn on map
- If user OUTSIDE geofence a circle with RED color will be drawn on map

Logs:

- List of user location will be displayed here
- A status if user in or out of geofence,distance between user location and geofence,ssid,latLong and capture time will di displayed
- Data will be refreshed after 30 data.

Things to do when starting application:

1. Click on gear icon at top right corner to open setting
2. Enter geofence name
3. Enter wifi ssid or click GET SSID to get current wifi connection
4. Click open map to choose lat long and radius
5. From map view click gps to get current location or click on map to select location.
6. Type in radius for geofence
7. Click use this location to select location and radius

# Test Method

## Tested device

- samsung s10 plus
- nox emulator

## test method

- tested using mock location and hola app
