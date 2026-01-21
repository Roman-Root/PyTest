import pytest
import undetected_chromedriver as uc


@pytest.fixture(scope="function")
def driver():
    options = uc.ChromeOptions()
    options.add_argument("--window-size=1920,1080")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    # options.headless = True  # если нужен headless

    drv = uc.Chrome(options=options, use_subprocess=True)
    yield drv
    drv.quit()


