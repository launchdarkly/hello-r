library(reticulate)

# Set SDK_KEY to your LaunchDarkly SDK key
SDK_KEY=""
# Set FEATURE_FLAG_KEY to the feature flag key you want to evaluate
FEATURE_FLAG_KEY="my-boolean-flag"

ldclient <- import("ldclient")

ldclient$set_config(ldclient$config$Config(SDK_KEY))

# Set up the user properties. This user should appear on your LaunchDarkly
# users dashboard soon after you run the demo.
user = list(key = "example-user-key", name="Sandy")

if (ldclient$get()$variation(FEATURE_FLAG_KEY, user, FALSE)) {
    print("Feature flag %s is true for this user", FEATURE_FLAG_KEY)
} else {
    print("Feature flag %s is false for this user", FEATURE_FLAG_KEY)
}

# Here we ensure that the SDK shuts down cleanly and has a chance to deliver analytics
# events to LaunchDarkly before the program exits. If analytics events are not delivered,
# the user properties and flag usage statistics will not appear on your dashboard. In a
# normal long-running application, the SDK would continue running and events would be
# delivered automatically in the background.
ldclient$get()$close()
