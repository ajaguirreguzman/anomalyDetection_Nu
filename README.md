# Anomaly Detection algorithm for heat transport measurements

## Description
In rotating Rayleigh-Bénard convection, time series of heat transport data (convective Nusselt number) are commonly used to assess the system's response to thermal forcing. This data often consist of both: transient state data and statistically converged data. The latter information is crucial for the characterisation of the well-established thermal convection modes, whereas the former should therefore be filtered out. Here, the challenge is to decisively pinpoint the time instance that that separates the transient data from the statistically converged data. Up until now, such process is typically done by eye in a completely arbitrary fashion. Here, I use an anomaly detection algorithm to flag (hereby deemed) "anomalous" data points. This allows a more systematic filtering process. The choice of the threshold value for anomaly detection is intended to maximise the F1-score.

## Goals
- Flag transitent data (and potential numerical artefacts) as anomalous data.
- Filter these data out from the statistically converged data.
- Compute the mean convective heat transfer using the filtered data.

## Results:
The anomaly detection algorithm turned out to be far too simple for detection of transient data in heat transfer measurements. Another approach would be to train a neural network for recognition of the underlying patterns in the statistically converged state. This alternative approach would moreover set the stage for additional insighful and more exciting analysis of these data. See https://github.com/ajaguirreguzman/transient_recognition_neural_networks


