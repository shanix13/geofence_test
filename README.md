

# Description
- A geofence application developed using flutter

| Home  | Log |Map Select |Settings|
| ------------- | ------------- |------------- | ----------|
| <img src="https://user-images.githubusercontent.com/13599154/86922185-d69e3300-c15e-11ea-9727-1706b57c95f2.png" width="200" height="400">  | <img src="https://user-images.githubusercontent.com/13599154/86926147-511d8180-c164-11ea-9a67-d3159514b88a.png" width="200" height="400">  |<img src="https://user-images.githubusercontent.com/13599154/86926178-58448f80-c164-11ea-99bf-34a4a6da846f.png" width="200" height="400">  |<img src="https://user-images.githubusercontent.com/13599154/86926239-685c6f00-c164-11ea-8c5c-e3d434aa4580.png" width="200" height="400">





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
