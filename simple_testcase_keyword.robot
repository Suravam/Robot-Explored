*** settings ***
Library    SSHLibrary
Library    OperatingSystem

*** Variables ***
${server}    10.0.0.3
${user}    %{remote_user}
${pass}    %{remote_pass}

*** Keywords ***
connect to remote server
    open connection    ${server}    port=22
    login    ${user}    ${pass}    4
this service should be running
    [Arguments]    ${service}
    connect to remote server
    ${output}=    execute command    service ${service} status
    Log    ${output}
    should contain    ${output}    Active: active (running)
    close connection
    

*** Test Cases ***
verify apache is running
    this service should be running    apache2
