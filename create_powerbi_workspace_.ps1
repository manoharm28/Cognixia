
 
#credentials
$clientId = ""
$clientSecret = ""
$tenantId = ""
$resourceUrl = "https://analysis.windows.net/powerbi/api"
 
#token endpoint URL
$tokenEndpoint = "https://login.microsoftonline.com/$tenantId/oauth2/token"
 
#body for the token request
$body = @{
    grant_type    = "client_credentials"
    client_id     = $clientId
    client_secret = $clientSecret
    resource      = $resourceUrl
}
 
# Get the token
$tokenResponse = Invoke-RestMethod -Method Post -Uri $tokenEndpoint -Body $body -ContentType "application/x-www-form-urlencoded"
$accessToken = $tokenResponse.access_token
 
#API URL for creating workspace
$apiUrl = "https://api.powerbi.com/v1.0/myorg/groups"
 
#payload for the workspace creation
$workspaceData = @{
    name = "Test Power BI Workspace"
} | ConvertTo-Json
 
#headers for the request
$headers = @{
    "Authorization" = "Bearer $accessToken"
    "Content-Type"  = "application/json"
}
 
#request to create the workspace
$workspaceResponse = Invoke-RestMethod -Method Post -Uri $apiUrl -Headers $headers -Body $workspaceData
    