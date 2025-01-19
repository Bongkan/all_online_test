*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${URL}              https://www.allonline.7eleven.co.th/
${PRODUCT_IMAGE}    //*[@id="page"]/div[2]/div[2]/div/div/div[2]/div/div/div/div/div/div[3]/div[1]/div/a[1]/div/img
${SUMMARY}          //*[@id="stepModel"]/div[1]/div[2]/div[2]/table/tbody[1]/tr[1]/td/div/span
${text}=            Get Text    xpath=//span[@class="address ellipsis-full "]


*** Test Cases ***
Successfully Buy 10 Pcs of Hygiene Expert Care on All Online
    Open Browser And Enter All Online
    Search Keyword
    Select Product
    Select Quantity And Buy
    Log in to buy
    Input Delivery Info
    Input Payment Info
    Close Browser


*** Keywords ***
Open Browser And Enter All Online
    Open Browser    ${URL}    chrome

Search Keyword
    Input Text    name=q    ไฮยีน เอ็กซ์เพิร์ทแคร์ น้ำยาปรับผ้านุ่ม ขาวมิลค์กี้ 1100 มล.
    Press Keys    None    RETURN

Select Product
    Wait Until Element Is Visible    ${PRODUCT_IMAGE}
    # Click accept cookies in case it is visible
    Click Element    id=alert-cookie-gdpr-allonline__button
    Click Element    ${PRODUCT_IMAGE}

Select Quantity And Buy
    Wait Until Element Is Visible    //*[@id="page"]/div[2]/div[2]/section/div[1]/div/div[1]/div[1]/div/img
    Input Text    name=order_count    10
    Click Element    //button[contains(text(), "ซื้อเลย")]

Log in to buy
    Input Text    name=email    bongkan.jj@gmail.com
    Input Text    name=password    Bkjj_605003
    Click Element    //a[contains(text(), "เข้าสู่ระบบ")]

Input Delivery Info
    Wait Until Element Is Visible    //*[@id="address-tabs"]/ul/li[2]/a
    Sleep    1s
    Click Element    //*[@id="address-tabs"]/ul/li[2]/a
    Input Text    id=new-address-name    กิตติพงศ์
    Input Text    id=new-address-lastname    วัฒนชัย
    Input Text    id=new-address-mobile    0811034067
    Input Text    id=new-address-addrno    89/12
    Input Text    id=new-address-moo    ม.9
    Select From List By Value    id=new-address-province    ปทุมธานี
    Select From List By Value    id=new-address-district    ลำลูกกา
    Select From List By Value    id=new-address-sub-district    ลำลูกกา
    Sleep    1s
    Wait Until Element Is Visible    id=selected-location
    Click Element    id=selected-location
    Sleep    1s
    Wait Until Element Is Visible    id=conf-dif-addr
    Click Element    id=conf-dif-addr
    Sleep    1s
    Wait Until Element Is Visible    id=continue-payment-btn
    Scroll Element Into View    id=continue-payment-btn
    Click Element    id=continue-payment-btn

Input Payment Info
    Wait Until Element Is Visible    //*[@id="payment-options"]/div[2]/button
    Click Element    //*[@id="payment-options"]/div[2]/button
    Wait Until Element Is Visible    id=checkoutData.paymentData.trueMoneyMobileNumber
    Input Text    id=checkoutData.paymentData.trueMoneyMobileNumber    0811034067
    Element Should Contain
    ...    //*[@id="stepModel"]/div[1]/div[2]/div[2]/table/tbody[1]/tr[3]/td[2]
    ...    ไฮยีน เอ็กซ์เพิร์ทแคร์ น้ำยาปรับผ้านุ่ม ขาวมิลค์กี้ 1100 มล.
    Element Should Contain    //*[@id="stepModel"]/div[1]/div[2]/div[2]/table/tbody[1]/tr[3]/td[3]    10
    Element Should Contain    //*[@id="stepModel"]/div[1]/div[2]/div[2]/table/tbody[1]/tr[3]/td[4]    ฿ 1,190
    Element Should Contain    //*[@id="js-invoice-details-tbody"]/tr[17]/td[2]/b    357
    Element Should Contain    //*[@id="js-invoice-details-tbody"]/tr[2]/td[2]/b    ฟรี
    Element Should Contain    ${SUMMARY}    กิตติพงศ์ วัฒนชัย
    Element Should Contain    ${SUMMARY}    0811034067
    # sleep    10s
    # Element Should Contain    ${SUMMARY}/text()[2]    89/12
    # Element Should Contain    ${SUMMARY}/text()[2]    ม.9
    # Element Should Contain    ${SUMMARY}/text()[2]    ลำลูกกา
    # Element Should Contain    ${SUMMARY}/text()[2]    ปทุมธานี
    # Element Should Contain    ${SUMMARY}/text()[2]    12150
    Should Contain    ${text}    89/12 ม.9, , ลำลูกกา ลำลูกกา ปทุมธานี 12150
