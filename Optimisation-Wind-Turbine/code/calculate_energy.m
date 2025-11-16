
% Correct time values (if data starts at -5s):
scope15.time_s_(2:end) = scope15.time_s_(2:end) + 5;

% Define resistance value (Ohms)
R = 47000;

% Calculate current using Ohm's law
scope15.Current = scope15.voltage_V_ / R;

% Calculate power
scope15.Power = scope15.voltage_V_ .* scope15.Current;

% Extract valid time and power columns
time = scope15.time_s_;
power = scope15.Power;
validData = ~isnan(time) & ~isnan(power);
time = time(validData);
power = power(validData);

% Calculate cumulative energy
total_cumenergy = cumtrapz(time, power);
scope15.Energy = total_cumenergy;

% Calculate total energy
total_energy = trapz(time, power);

% Display total energy
disp(['Total energy = ' num2str(total_energy) ' Joules']);
