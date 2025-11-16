% energy_calculation.m
% General script for calculating energy from any scopeXX dataset
% Change 'scopeXX' to your actual dataset variable name (e.g. scope15, scope18, etc.)

% --- Begin: Replace 'scopeXX' with your real table variable! ---
% Example: If your data table is called 'scope15', do a search and replace.

% Shift time values if experimental setup requires
scopeXX.time_s_(2:end) = scopeXX.time_s_(2:end) + 5;   % Adjust if time should start at 0

% Define load resistance value (Ohms)
R = 47000;

% Calculate current from voltage and resistance (I = V/R)
scopeXX.Current = scopeXX.voltage_V_ / R;

% Calculate power at each timestep (P = V * I)
scopeXX.Power = scopeXX.voltage_V_ .* scopeXX.Current;

% Extract time and power data as vectors
time = scopeXX.time_s_;
power = scopeXX.Power;

% Remove any missing/NaN entries
validData = ~isnan(time) & ~isnan(power);
time = time(validData);
power = power(validData);

% Cumulative energy over time (Joules)
total_cumenergy = cumtrapz(time, power);
scopeXX.Energy = total_cumenergy;

% Total energy produced over the experiment
total_energy = trapz(time, power);

% Display total energy to the MATLAB console
disp(['Total energy = ' num2str(total_energy) ' Joules']);
% --- End: Replace 'scopeXX' everywhere before running ---

