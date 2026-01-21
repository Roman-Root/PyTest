import allure
import pytest

from base.base_page import BasePage
from config.links import Links
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By

@pytest.mark.usefixtures("driver")
@allure.feature("Start tests")
class Start_Page(BasePage):

    PAGE_URL = Links.START_PAGE

    SIGNIN_BUTTON = (By.XPATH, "//a[.//span[text()='Заказы']]")

    @allure.title("Клик по кнопке submit / sign in")
    @allure.severity(allure.severity_level.CRITICAL)
    @pytest.mark.smoke
    def click_submit_button(self):
        self.wait.until(EC.element_to_be_clickable(self.SIGNIN_BUTTON)).click()