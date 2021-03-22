const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "eu-central-1:222c50f6-dc80-4cad-8a52-24089bbef4ef",
                            "Region": "eu-central-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-central-1_qH7U4XIvC",
                        "AppClientId": "jf8gn279eh323pbs79vutevb6",
                        "Region": "eu-central-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "OAuth": {
                            "WebDomain": "herbaria076aed6e-076aed6e-dev.auth.eu-central-1.amazoncognito.com",
                            "AppClientId": "jf8gn279eh323pbs79vutevb6",
                            "SignInRedirectURI": "herbaria://",
                            "SignOutRedirectURI": "herbaria://",
                            "Scopes": [
                                "phone",
                                "email",
                                "openid",
                                "profile",
                                "aws.cognito.signin.user.admin"
                            ]
                        },
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                }
            }
        }
    }
}''';
