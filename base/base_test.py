import allure
import pytest
from config.data import Data
from pages.start_page import Start_Page


class BaseTest:

    start_page: Start_Page

    @pytest.fixture(autouse=True)
    def setup(self, request, driver):
        request.cls.driver = driver
        request.cls.data = Data()

        request.cls.start_page = Start_Page(driver)

    def attach_screenshot_on_failure(self):
        if hasattr(self, 'driver') and self.driver:
            allure.attach(
                self.driver.get_screenshot_as_png(),
                name="screenshot_on_failure",
                attachment_type=allure.attachment_type.PNG
            )

