import time

import allure
import pytest
from base.base_test import BaseTest
from pages import start_page


@allure.feature("Start tests")
class TestStart(BaseTest):

    @allure.title("Клик по кнопке заказы")
    @allure.severity(allure.severity_level.CRITICAL)
    @pytest.mark.smoke
    def test_click_first_button(self):
        self.start_page.open()
        self.start_page.click_submit_button()
        self.start_page.make_screenshot("Screenshot")
        time.sleep(3)