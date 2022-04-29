library(reticulate)

# Set SDK_KEY to your LaunchDarkly SDK key
SDK_KEY="YOUR_SDK_KEY"
# Set FEATURE_FLAG_KEY to the feature flag key you want to evaluate
FEATURE_FLAG_KEY="YOUR_FEATURE_KEY"

ldclient <- import("ldclient")

ldclient$set_config(ldclient$config$Config(SDK_KEY))

user = list(key = "alice@example.com")

if (ldclient$get()$variation(FEATURE_FLAG_KEY, user, FALSE)) {
    print("feature is launched")
} else {
    print("feature is hidden")
}
