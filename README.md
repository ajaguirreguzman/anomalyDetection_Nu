# Anomaly Detection algorithm for heat transport measurements

## Description
In rotating Rayleigh-Bénard convection, time series of heat transport data (measured through the convective Nusselt number) are used to assess the response of the system to convective motions. In general, the data may display behaviours representative of the (brief) transient state of the system as well as of its (much-longer) statistically equilibrium state. The latter state contains the desired information to characterise well-established convection modes. Thus, the unwanted transient information must be filtered out. Additional unwanted data may arise from direct numerical simulations, where sometimes numerical artefacts are introduced. Up until now, the time instance that divides the transient data from the statistically converged data is typically chosen by eye in a process that is completely arbitrary. Similarly, the filtering of numerical artefacts is typically done manually. Here, I use an Anomaly Detection algorithm to flag anomalous data points. This allows a more systematic filtering process. The selection of a threshold value for anomaly detection maximises the F1-score.

## Goals
- Flag transitent data and numerical artefacts as anomalous data.
- Filter these data from the statistically equilibrium data
- Computed the mean convective heat transfer

## Compile:
matlab ...


