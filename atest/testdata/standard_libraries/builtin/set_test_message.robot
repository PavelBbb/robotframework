*** Test Cases ***
Set Message To Successful Test
    Set Test Message    My Test Message
    [Teardown]    Should Be Equal    ${TEST MESSAGE}    My Test Message

Reset Message
    Set Test Message    My Test Message
    Set Test Message    My Real Test Message
    [Teardown]    Should Be Equal    ${TEST MESSAGE}    My Real Test Message

Append To Message
    Set Test Message    My message    append please
    Set Test Message    is continued    append=please
    [Teardown]    Should Be Equal    ${TEST MESSAGE}    My message is continued

Set Non-ASCII Message
    Set Test Message    Hyvää yötä
    [Teardown]    Should Be Equal    ${TEST MESSAGE}    Hyvää yötä

Set Multiline Message
    Set Test Message    1\n2\n3
    [Teardown]    Should Be Equal    ${TEST MESSAGE}    1\n2\n3

Use the HTML
    [Documentation]    PASS *HTML* custom message and another custom message in <HR> with a line
    Set Test Message  custom message
	Set Test Message  *HTML* and another custom message in <HR> with a line  append=True

Use the HTML first
    [Documentation]    PASS *HTML* and another custom message in <HR> with a line custom message
    Set Test Message    *HTML* and another custom message in <HR> with a line
	Set Test Message    custom message  append=True

Use the HTML combination
    [Documentation]    PASS *HTML* and another custom message in <HR> with a line custom message custom &lt;message&gt; and another custom message in <HR> with a line
    Set Test Message    *HTML* and another custom message in <HR> with a line
	Set Test Message    custom message  append=True
	Set Test Message    custom <message>  append=True
	Set Test Message    *HTML* and another custom message in <HR> with a line  append=True

Set Non-String Message
    Set Test Message    ${42}
    [Teardown]    Should Be Equal    ${TEST MESSAGE}    42

Failure Resets Set Message
    [Documentation]    FAIL Fail Message
    Set Test Message    Message That Will Be Ignored
    Fail    Fail Message
    [Teardown]    Should Be Equal    ${TEST MESSAGE}    Fail Message

Set Message To Failed Test On Teardown
    [Documentation]    FAIL Teardown Message
    Fail    Message That Will Be Ignored
    [Teardown]    Set Test Message    Teardown Message

Append To Failure Message
    [Documentation]    FAIL My failure is continued
    Fail    My failure
    [Teardown]    Set Test Message    is continued    append=jepa

Setting Message In Test Body After Continuable Failure Has No Effect
    [Documentation]    FAIL Failure Message
    Run Keyword And Continue On Failure    Fail    Failure Message
    Set Test Message    Ignored Message
    [Teardown]    Should Be Equal    ${TEST MESSAGE}    Failure Message

Setting Message In Teardown After Continuable Failure Works
    [Documentation]    FAIL Set Message
    Run Keyword And Continue On Failure    Fail    Failure Message
    [Teardown]    Set Test Message    Set Message

Set Message In Body and Fail In Teardown
    [Documentation]    FAIL Teardown failed:
    ...    Failing Teardown Message
    Set Test Message    Message Before Teardown
    [Teardown]    Fail    Failing Teardown Message

Set Message In Teardown And Fail Afterwards
    [Documentation]    FAIL Teardown failed:
    ...    My failure after message
    No Operation
    [Teardown]    Set Message In Teardown And Fail Afterwards

Fail In Teardown And Set Message Afterwards
    [Documentation]    FAIL Teardown failed:
    ...    My failure before message
    No Operation
    [Teardown]    Fail In Teardown And Set Message Afterwards

Set Message In Setup
    [Setup]    Set Test Message    Message set in setup
    Variable Should Not Exist    ${TEST MESSAGE}
    [Teardown]    Should Be Equal    ${TEST MESSAGE}    Message set in setup

Check Message From Previous Test
    Should Be Equal    ${PREV TEST MESSAGE}    Message set in setup

Test Message Variable Reacts On Set Test Message
    [Documentation]    PASS Other Second
    Pass_Execution    Initial Test Message
    [Teardown]    Check Test Message Variable Behavior Is Correct

*** Keywords ***
Set Message In Teardown And Fail Afterwards
    Set Test Message    My message before failure
    Fail    My failure after message

Fail In Teardown And Set Message Afterwards
    Fail    My failure before message
    Set Test Message    My message after failure

Check Test Message Variable Behavior Is Correct
    Should Be Equal    ${TEST_MESSAGE}    Initial Test Message
    Set Test Message    First    True
    Should Be Equal    ${TEST_MESSAGE}    Initial Test Message First
    Set Test Message    Other
    Should Be Equal    ${TEST_MESSAGE}    Other
    Set Test Message    Second    True
    Should Be Equal    ${TEST_MESSAGE}    Other Second
