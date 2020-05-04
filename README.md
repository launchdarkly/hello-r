# LaunchDarkly Sample R Server-Side Application
We've built a simple console application that demonstrates how LaunchDarkly's SDK works. Below, you'll find the basic build procedure. While LaunchDarkly does not have a dedicated R SDK, the Python SDK can be conveniently utilized. Use this as a starting point for integrating the `python-server-sdk` with your R application.

## Dependencies
- Install the reticulate package `R -e "install.packages('reticulate')"`
- Install the LaunchDarkly Python SDK `pip3 install launchdarkly-server-sdk`

## Instructions
1. Install the dependencies described above
2. Copy your SDK key and feature flag key from your LaunchDarkly dashboard into `hello.r`
5. Run `Rscript hello.r`
