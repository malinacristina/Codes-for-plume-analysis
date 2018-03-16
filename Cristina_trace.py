import scipy.io as spio
import numpy as np
from matplotlib import pyplot as plt
import pandas as pd

# Loads the matlab file
mat = spio.loadmat('C:/Users/marinc/OneDrive - The Francis Crick Institute/Data/Tunnel Calibration/Raw data/171129_40cm_def.mat')

# Extracts the trace infos from the file, they're a tuple of arrays
trace_info = mat['V171129_EB_40cm_def_Ch1'] # Actual trace
odour_info = mat['V171129_EB_40cm_def_Ch2'] # Odour pulse

# Extract the meaningful information, e.g. the
dirty_trace_y_vals = trace_info[0][0][-1]
dirty_odour_y_vals = odour_info[0][0][-1]

# Create some empty arrays to hold the smell machined recorded value
trace_y_vals = []
odour_y_vals = []

# Cleaning the data, each of the arrays is actually first an array of arrays with only one value in each
# therefore we need to run through and put the data from all the tiny arrays into one big one
for i in range(len(dirty_trace_y_vals)):
	trace_y_vals.append(dirty_trace_y_vals[i][0])
	odour_y_vals.append(dirty_odour_y_vals[i][0]/10)



# Creating an array to plot the traces against, simply the number of sampling points
# divide by sampling rate to get the time
x = list(range(0, len(trace_y_vals)))


# Plotting the graphs, commented out for now

plt.plot(x, odour_y_vals)
plt.plot(x, trace_y_vals)
plt.xlim(17000, 30000)
plt.show()


# A rolling mean of the odour pulse, finds the time at which the odour pulse was emitted
rolling_odour_mean = pd.rolling_mean(pd.Series(odour_y_vals), 2001)
rolling_trace_mean = pd.rolling_mean(pd.Series(trace_y_vals), 2001)
non_naned_odour_mean= rolling_odour_mean[2000:]
non_naned_trace_mean = rolling_trace_mean[2000:]

# Some conditions that need to be set, the start and end refer to the pulse
# and spike to the detected spikes
found_start = False
found_end= False
found_spike = False

# Empty arrays to hold the times when they occur
pulse_starts = []
pulse_ends = []
spike_starts =[]

# Runs through all the recorded values, starting from 2000
for j in range(2000, len(x)):
	if odour_y_vals[j]>non_naned_odour_mean[j]+0.01: 

		# Checking if the odour pulse has started
		if found_start==False:
			pulse_starts.append(j)
			found_start=True
			found_end=False

	# Only runs once a pulse has started and not finished
	if found_start==True:

		# Checking if the spike beginning has been found
		if found_spike==False:
			if trace_y_vals[j]>non_naned_trace_mean[j]+0.01:
				spike_starts.append(j)
				found_spike=True

		if odour_y_vals[j]==0:
			if found_end==False:
				pulse_ends.append(j)
				found_end=True
				found_start=False
				found_spike=False
	if j==len(x)//2:
		print('Halfway there')

# Plot with vertical lines
plt.plot(x, odour_y_vals)
plt.plot(x, trace_y_vals)
plt.xlim(17000, 30000)
for xc in spike_starts:
	plt.axvline(x=xc, c='k')
plt.show()



# Last step is to calculate the delays
delays = []
for k in range(len(spike_starts)):
	delays.append(spike_starts[k]-pulse_starts[k])

# And the definite last step, printing it all out
print('Delays'+str(delays))
print('Average: '+str(np.mean(delays))+', calculated '+str(len(delays))+' from a set of '+str(len(pulse_starts))+' pulses')

