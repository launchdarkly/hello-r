library(reticulate)

# Set SDK_KEY to your LaunchDarkly SDK key
SDK_KEY <- Sys.getenv("LAUNCHDARKLY_SDK_KEY")

# Set FEATURE_FLAG_KEY to the feature flag key you want to evaluate
FEATURE_FLAG_KEY <- Sys.getenv("LAUNCHDARKLY_FLAG_KEY", "sample-feature")

# Set this environment variable to skip the loop process and evaluate the flag
# a single time.
CI <- Sys.getenv("CI", "")

show_banner <- function() {
    cat("\n")
    cat("        ██       \n")
    cat("          ██     \n")
    cat("      ████████   \n")
    cat("         ███████ \n")
    cat("██ LAUNCHDARKLY █\n")
    cat("         ███████ \n")
    cat("      ████████   \n")
    cat("          ██     \n")
    cat("        ██       \n")
    cat("\n")
}

show_evaluation_result <- function(key, value) {
    cat("*** The", key, "feature flag evaluates to", value, "\n")

    if (value) {
        show_banner()
    }
}

flag_change_listener <- function(flag_change) {
    show_evaluation_result(flag_change$key, flag_change$new_value)
}

ldclient <- import("ldclient")
threading <- import("threading")

ldclient$set_config(ldclient$config$Config(SDK_KEY))

if (!ldclient$get()$is_initialized()) {
  cat("*** SDK failed to initialize. Please check your internet connection and SDK credential for any typo.\n")
  stop()
}

cat("*** SDK successfully initialized\n")

# Set up the evaluation context. This context should appear on your
# LaunchDarkly contexts dashboard soon after you run the demo.
context = ldclient$context$ContextBuilder("example-user-key")$kind("user")$name("Sandy")$build()

flag_value = ldclient$get()$variation(FEATURE_FLAG_KEY, context, FALSE)
show_evaluation_result(FEATURE_FLAG_KEY, flag_value)

if (CI == "") {
    change_listener <- ldclient$get()$flag_tracker$add_flag_value_change_listener(
        FEATURE_FLAG_KEY, context, flag_change_listener)

    threading$Event()$wait()
}
