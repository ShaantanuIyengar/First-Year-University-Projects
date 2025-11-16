% Energy Calculation for Motor A Experimental Data (scope15)

% Adjust time values if initial readings are negative
scope15.time_s_(2:end) = scope15.time_s_(2:end) + 5;

% Define load resistance (in Ohms)
R = 47000;

% Calculate current using Ohm's Law (I = V/R)
scope15.Current = scope15.voltage_V_ / R;

% Calculate instantaneous power (P = V * I)
scope15.Power = scope15.voltage_V_ .* scope15.Current;

% Extract time and power vectors
time = scope15.time_s_;
power = scope15.Power;

% Remove any NaN (missing) data from time and power arrays
validData = ~isnan(time) & ~isnan(power);
time = time(validData);
power = power(validData);

% Calculate cumulative energy over time using trapezoidal integration
total_cumenergy = cumtrapz(time, power);
scope15.Energy = total_cumenergy;

% Calculate total energy delivered by integrating over the trial
total_energy = trapz(time, power);

% Display total energy result in Joules
disp(['Total energy = ' num2str(total_energy) ' Joules']);
