import sentry_sdk
import os
sentry_sdk.init(
    dsn=os.getenv("DSN"),
    send_default_pii=True,
    traces_sample_rate=1.0,
    environment="development",
)
print("Sentry initialized!")
print("Sending test message...")
sentry_sdk.capture_message("Test message from homework project")
print("Generating ZeroDivisionError...")
try:
    result = 10 / 0
except ZeroDivisionError as e:
    sentry_sdk.capture_exception(e)
    print("Exception captured!")
print("Flushing events...")
sentry_sdk.flush(timeout=5)
print("Done! Check your Sentry dashboard.")
