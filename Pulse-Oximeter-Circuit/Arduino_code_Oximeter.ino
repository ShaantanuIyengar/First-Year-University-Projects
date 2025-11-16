#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <Wire.h>
#include "MAX30100_PulseOximeter.h"
// OLED Screen Parameters
#define SCREEN_WIDTH 96
#define SCREEN_HEIGHT 16
#define OLED_RESET -1
#define SCREEN_ADDRESS 0x3C
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);
#define REPORTING_PERIOD_MS 1000 // Polling rate of the sensor
// Global heart rate and oyxgen variables
float heartRate = 0;
float oxygenLevel = 0;
// pin positions of LEDS
int red = A3;
int green = A2;
unsigned long RMillis = 0; //Previous time in milliseconds for red
Blinker
unsigned long GMillis = 0; //Previous time in milliseconds for green
Pulse
int onoff = 1; // Variable to blink red LED
PulseOximeter pox;
uint32_t tsLastReport = 0;
void onBeatDetected()
{
 GMillis = millis(); // Records current time
 digitalWrite(green, 1); // Turns on green LED
}
// Program initilisation
void setup() {
 pinMode(red, OUTPUT);
 pinMode(green, OUTPUT);
 Serial.begin(9600);
 Serial.begin(115200);
 display.begin(SSD1306_SWITCHCAPVCC, SCREEN_ADDRESS);
 pox.begin();
 pox.setOnBeatDetectedCallback(onBeatDetected);
}
void loop() {
 pox.update();
 // Updates heart rate and SpO2 every 1000 milliseconds
 if (millis() - tsLastReport > REPORTING_PERIOD_MS) {
 heartRate = pox.getHeartRate(); // Collects heart rate using
library
 oxygenLevel = pox.getSpO2(); // Collect Oxygen level using library
 // Displays heart rate and SpO2 in serial monitor
 Serial.print("Heart rate: ");
 Serial.print(heartRate);
 Serial.print(" bpm / SpO2: ");
 Serial.print(oxygenLevel);
 Serial.println(" %");
 updateDisplayText(heartRate, oxygenLevel); // Calls the Display
Text function to updates the screen with new Heart rate and SpO2 values
 tsLastReport = millis(); // Resets the heart rate time to wait 1000
milliseconds
 }
 // Red LED Blinker Control
 if (heartRate <= 40 || heartRate >=100) { // Upper and Lower bounds for
no blinking
 // Toggle Red LED after 500 milliseconds have passed
 if(millis() - RMillis > 500){
 digitalWrite(red, onoff); // Sets the red LED to on or off
dependant on onoff variable value
 RMillis = millis(); // Resets the red LED time to wait 500
milliseconds
 // Makes sure the LED is alternatively turned on and off every
cycle
 if(onoff == 0) {
 onoff = 1;
 }
 else {
 onoff = 0;
 }
 }
 }
 else { // When within boundaries:
 digitalWrite(red, 0); // Turns off the LED
 onoff = 1; // Ensures the LED starts in the ON position when blinking
 }
 // Green LED Pulse control
 if(millis() - GMillis >= 75) { // Ensures that the Green LED only
Pulses for 75 milliseconds
 digitalWrite(green, 0); // Turns off green LED
 GMillis = millis(); // resets the green LED time to wait 75
milliseconds
 }
}
// Function that updates the information on the OLED screen
void updateDisplayText(float heartRate, float oxygenLevel) {
 display.clearDisplay(); // Clears the display buffer
 display.setTextSize(1); // Sets the text size
 display.setTextColor(SSD1306_WHITE); // Sets text colour
 // Display Heart Rate
 display.setCursor(0, 0); // Sets the cursor to the top-left corner of
the screen
 display.print("HR: ");
 display.print(heartRate); // Updates with data obtained from MAX30100
 display.println(" BPM");
 // Display Oxygen Level
 display.setCursor(0, 8); // Moves the cursor 8 pixels down to print on
second line
 display.print("SpO2: ");
 display.print(oxygenLevel); // Updates with data obtained from MAX30100
 display.println(" %");
 display.display(); // Updates the display
}