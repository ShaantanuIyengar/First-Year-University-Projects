% Energy Calculation for Motor B Experimental Data (scope18)

% Adjust time values if initial readings are negative
scope18.time_s_(2:end) = scope18.time_s_(2:end) + 5;

% Define load resistance (in Ohms)
R = 47000;

% Calculate current using Ohm's Law
scope18.Current = scope18.voltage_V_ / R;

% Calculate instantaneous power
scope18.Power = scope18.voltage_V_ .* scope18.Current;

% Extract time and power vectors
time = scope18.time_s_;
power = scope18.Power;

% Remove any NaN values from time and power arrays
validData = ~isnan(time) & ~isnan(power);
time = time(validData);
power = power(validData);

% Cumulative energy calculation
total_cumenergy = cumtrapz(time, power);
scope18.Energy = total_cumenergy;

% Total energy delivered in experiment
total_energy = trapz(time, power);

% Display total energy in Joules
disp(['Total energy = ' num2str(total_energy) ' Joules']);
