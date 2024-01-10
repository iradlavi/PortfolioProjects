#!/usr/bin/env python
# coding: utf-8

# In[1]:


import selenium
from selenium import webdriver
import requests
import re
from bs4 import BeautifulSoup
from time import sleep

service = webdriver.chrome.service.Service(executable_path=r"C:\Program Files\Google\Chrome\Application\chromedriver.exe")
driver = webdriver.Chrome(service=service)

url = "https://mac.maccabi4u.co.il/magento/login?SAMLRequest=lZJbb9pAEIXf%2BRXRvmMvBtdkBUhuaFokChbQPuQlGuwJrLQXd2fdy7%2FvYpMLiRqpI%2B3LmTmfzox2QqBVLfLGH80GfzRIvncV6rdWhkTbnLLGGWGBJAkDGkn4Umzzr0uRRFzUznpbWsVe2d53ARE6L63pbIv5lK1Xn5brz4vVffbAEQYwrK7HKfAkxWE65rD%2FkIwgzZI0NLNhihl01u%2FoKHCmLGBZr6MRNbgw5MH4oPNk1OeDPs92fCxGqeDDu846D8tKA761H72vScSxhjIKr4S9HDVRaSOpgnZA422s7EGeExfntT9KU0lzeH%2FbfTdE4stuV%2FSL9XbXQfLHK9xYQ41Gt0X3U5b4bbO8CHQKUx%2FB6TfJiGx8unYSQ0ls1lInJ0G0R3Cz%2F6Ro9FCBh0n8EvKMrcUqbLeYF1bJ8k%2Brn%2BrWOg3%2B30cYRINWkVX%2FoR0VqEGqvKocErEnTq6U%2FXXjEDxOmXcNsqt41uvCXH7S2V8%3D&RelayState=https%3A%2F%2Fmaccabipharm.maccabi4u.co.il%2F&SigAlg=http%3A%2F%2Fwww.w3.org%2F2000%2F09%2Fxmldsig%23rsa-sha1&Signature=RRkloW%2BLomxbAZvZurZSw2eM%2F1zuLCMzCK1PGtmCclVUha3e7MjmNR%2FwLiDhSZcGuYxPaQThsxoyL5jkpnMkHnVL2vgxrpyngS4U3WYcYAYilknk6sjsmKgbeU8f2rMUuP08e8zcpK0jeLTR4sArtsRzmzTrBnjF6sOx6o2WHbY%3D"

driver.get(url)

page = requests.get("https://mac.maccabi4u.co.il/magento/login?SAMLRequest=lZJbb9pAEIXf%2BRXRvmMvBtdkBUhuaFokChbQPuQlGuwJrLQXd2fdy7%2FvYpMLiRqpI%2B3LmTmfzox2QqBVLfLGH80GfzRIvncV6rdWhkTbnLLGGWGBJAkDGkn4Umzzr0uRRFzUznpbWsVe2d53ARE6L63pbIv5lK1Xn5brz4vVffbAEQYwrK7HKfAkxWE65rD%2FkIwgzZI0NLNhihl01u%2FoKHCmLGBZr6MRNbgw5MH4oPNk1OeDPs92fCxGqeDDu846D8tKA761H72vScSxhjIKr4S9HDVRaSOpgnZA422s7EGeExfntT9KU0lzeH%2FbfTdE4stuV%2FSL9XbXQfLHK9xYQ41Gt0X3U5b4bbO8CHQKUx%2FB6TfJiGx8unYSQ0ls1lInJ0G0R3Cz%2F6Ro9FCBh0n8EvKMrcUqbLeYF1bJ8k%2Brn%2BrWOg3%2B30cYRINWkVX%2FoR0VqEGqvKocErEnTq6U%2FXXjEDxOmXcNsqt41uvCXH7S2V8%3D&RelayState=https%3A%2F%2Fmaccabipharm.maccabi4u.co.il%2F&SigAlg=http%3A%2F%2Fwww.w3.org%2F2000%2F09%2Fxmldsig%23rsa-sha1&Signature=RRkloW%2BLomxbAZvZurZSw2eM%2F1zuLCMzCK1PGtmCclVUha3e7MjmNR%2FwLiDhSZcGuYxPaQThsxoyL5jkpnMkHnVL2vgxrpyngS4U3WYcYAYilknk6sjsmKgbeU8f2rMUuP08e8zcpK0jeLTR4sArtsRzmzTrBnjF6sOx6o2WHbY%3D")

soup = BeautifulSoup(page.text, 'html')

sleep(7)

driver.maximize_window()

enter_with_password = driver.find_element(by='id', value="liTab1")

enter_with_password.click()

sleep(5)

teudat_zehut = driver.find_element(by='id', value="identifyWithPasswordCitizenId")

teudat_zehut.send_keys(315119032)

password = driver.find_element(by='id', value="password")

password.send_keys("23p2u3TvHYKvyvL")

submit_tz_password = driver.find_element(by='xpath', value='//*[@id="IdentifyWithPassword"]/button')

submit_tz_password.click()

sleep(15)

mirshamim = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div[1]/button[1]/div[1]/div[1]')

mirshamim.click()

sleep(10)

patient = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div[1]/div/div/div/div/div[2]/div/div/div/div/a')

patient.click()

sleep(7)

select_medicine = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div/div[2]/div[2]/div/div[2]/div[3]/div/div[2]/div/label/span')

select_medicine.click()

try:
    driver.find_element(by='xpath', value='//*[@id="questionnaire4170920"]/button/button/span').click()
except:
    pass

question1 = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div/div[2]/div[2]/div/div[2]/div[4]/div/div/div/div[2]/div[1]/div[1]/div/div[2]/label[2]/span')
question1.click()
question2 = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div/div[2]/div[2]/div/div[2]/div[4]/div/div/div/div[2]/div[1]/div[2]/div/div[2]/label[2]/span')
question2.click()
question3 = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div/div[2]/div[2]/div/div[2]/div[4]/div/div/div/div[2]/div[1]/div[3]/div/div[2]/label[2]/span')
question3.click()
question4 = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div/div[2]/div[2]/div/div[2]/div[4]/div/div/div/div[2]/div[1]/div[4]/div/div[2]/label[1]/span')
question4.click()
question5 = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div/div[2]/div[2]/div/div[2]/div[4]/div/div/div/div[2]/div[1]/div[5]/div/div[2]/label[2]/span')
question5.click()

for i in range(10):
    try:
        agreement_checkbox = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div/div[2]/div[2]/div/div[2]/div[4]/div/div/div/div[2]/div[2]/div/label[1]/span')
        driver.execute_script("$(arguments[0]).click()", agreement_checkbox)
        break
    except NoSuchElementException as e:
        print('Retry in 1 second')
        time.sleep(1)
else:
    raise e


try:
    driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div/div[2]/div[2]/div/div[2]/div[4]/div/div/div/div[2]/button').click()
except:
    pass

proceed_to_payment = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div/div[2]/div[5]/button[1]')
proceed_to_payment.click()

sleep(7)

approve_and_continue = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div[1]/div[2]/div/div/div[2]')
approve_and_continue.click()

sleep(5)

try:
    pickup_from_pharmacy = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div[1]/div[1]/div/div[1]/div/div/label[1]/input')
    pickup_from_pharmacy.click()
except Exception as e1:
    try:
        pickup_from_pharmacy = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div[1]/div[1]/div/div[1]/div/div/label[1]/input')
        driver.execute_script("$(arguments[0]).click()", pickup_from_pharmacy)
    except Exception as e2:
        print(e)

sleep(3)

choose_pharmacy1 = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div[1]/div[1]/div/div[1]/div/div[2]/div/div/div/div/div/input')
choose_pharmacy1.send_keys("לוד")
choose_pharmacy2 = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div[1]/div[1]/div/div[1]/div/div[2]/div/div/div/div/div/div/div')
choose_pharmacy2.click()

sleep(3)

proceed1 = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div[1]/div[1]/div/div[1]/div/div[2]/div/div[1]/button')
driver.execute_script("$(arguments[0]).click()", proceed1)

sleep(3)

proceed2 = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div[1]/div[1]/div/div[2]/div/div/form/button')
proceed2.click()

sleep(3)

approve_and_finish_order = driver.find_element(by='xpath', value='/html/body/div[2]/div/main/div[2]/div/div[1]/div[1]/div/div[3]/div/div/button')
approve_and_finish_order.click()


# In[ ]:




