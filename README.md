# LaunchDarkly sample R server-side application

We've built a console application that demonstrates how LaunchDarkly's SDK works. Below, you'll find the basic build procedure. While LaunchDarkly does not have a dedicated R SDK, you can use the Python SDK. Use this as a starting point for integrating the `python-server-sdk` with your R application. To learn more, read the [Python SDK reference guide](https://docs.launchdarkly.com/sdk/server-side/python).

## Dependencies
1. Install the reticulate package: `R -e "install.packages('reticulate')"`
2. Install the LaunchDarkly Python SDK: `pip3 install launchdarkly-server-sdk`

## Build instructions

1. Set the environment variable `LAUNCHDARKLY_SDK_KEY` to your LaunchDarkly SDK key. If there is an existing boolean feature flag in your LaunchDarkly project that you want to evaluate, set `LAUNCHDARKLY_FLAG_KEY` to the flag key; otherwise, a boolean flag of `sample-feature` will be assumed.

    ```bash
    export LAUNCHDARKLY_SDK_KEY="1234567890abcdef"
    export LAUNCHDARKLY_FLAG_KEY="my-boolean-flag"
    ```

1. On the command line, run `Rscript main.r`

You should receive the message "The <flagKey> feature flag evaluates to <flagValue>.". The application will run continuously and react to the flag changes in LaunchDarkly.
