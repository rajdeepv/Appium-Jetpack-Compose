require 'appium_lib'

def android_compose_caps()
  {
    platformName: 'Android',
    deviceName: 'emulator-5556',
    app: File.join(File.dirname(__FILE__), '../' + 'compose_playground.apk'),
    automationName: 'espresso',
    newCommandTimeout: 0,
    skipUnlock: true,
    fullReset: false,
    forceEspressoRebuild: true,
    showGradleLog: true,
    espressoBuildConfig: '{"additionalAndroidTestDependencies": ["androidx.lifecycle:lifecycle-extensions:2.2.0", "androidx.activity:activity:1.3.1",  "androidx.fragment:fragment:1.2.0"]}'
  }
end

@driver = Appium::Driver.new({ caps: android_compose_caps }, false)
@driver.start_driver

# click on the button with text 'Clickable Component'.
# This will later load a Compose screen with a clickable button
non_compose_button = @driver.find_element(xpath: "//*[@text='Clickable Component']")
non_compose_button.click

# Change the drive context to 'compose' because now we are on a Compose screen
@driver.update_settings({'driver' => 'compose'})

# We can find Compose button using it's text with XPATH!
button = @driver.find_element(xpath: "//*[@text='Click to see dialog']")

# we could also find the button using content-description as below
# button = @driver.find_element(accessibility_id: "desc")

fail("Text mismatch") unless button.text ==  'Click to see dialog'

