library(reticulate)

# Set SDK_KEY to your LaunchDarkly SDK key
SDK_KEY <- Sys.getenv("LAUNCHDARKLY_SDK_KEY")

# Set FEATURE_FLAG_KEY to the feature flag key you want to evaluate
FEATURE_FLAG_KEY <- Sys.getenv("LAUNCHDARKLY_FLAG_KEY", "sample-feature")

ldclient <- import("ldclient")

ldclient$set_config(ldclient$config$Config(SDK_KEY))

if (ldclient$get()$is_initialized()) {
  cat("SDK successfully initialized!\n")
} else {
  cat("SDK failed to initialize\n")
  exit()
}

context = ldclient$context$ContextBuilder("example-user-key")$kind("user")$name("Sandy")$build()

if (ldclient$get()$variation(FEATURE_FLAG_KEY, context, FALSE)) {
    cat("The ", FEATURE_FLAG_KEY, " feature flag evaluates to true.\n")
} else {
    cat("The ", FEATURE_FLAG_KEY, " feature flag evaluates to false\n")
}

# Here we ensure that the SDK shuts down cleanly and has a chance to deliver analytics
# events to LaunchDarkly before the program exits. If analytics events are not delivered,
# the user properties and flag usage statistics will not appear on your dashboard. In a
# normal long-running application, the SDK would continue running and events would be
# delivered automatically in the background.
ldclient$get()$close()
