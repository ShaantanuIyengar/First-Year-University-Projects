% Energy Calculation for Motor C Experimental Data (scope20)

% Adjust time values
scope20.time_s_(2:end) = scope20.time_s_(2:end) + 5;

% Load resistance in Ohms
R = 47000;

% Current calculation
scope20.Current = scope20.voltage_V_ / R;

% Power calculation
scope20.Power = scope20.voltage_V_ .* scope20.Current;

% Get time and power data
time = scope20.time_s_;
power = scope20.Power;

% Filter out NaN values
validData = ~isnan(time) & ~isnan(power);
time = time(validData);
power = power(validData);

% Cumulative energy integration
total_cumenergy = cumtrapz(time, power);
scope20.Energy = total_cumenergy;

% Total energy calculation
total_energy = trapz(time, power);

% Show result
disp(['Total energy = ' num2str(total_energy) ' Joules']);
