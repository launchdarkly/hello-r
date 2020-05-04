library(reticulate)

ldclient <- import("ldclient")

ldclient$set_sdk_key("YOUR_SDK_KEY")

user = list(key = "alice@example.com")

if (ldclient$get()$variation("YOUR_FEATURE_KEY", user, FALSE)) {
    print("feature is launched")
} else {
    print("feature is hidden")
}
