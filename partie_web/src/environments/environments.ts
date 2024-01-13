export const environment = {
    msalConfig: {
        auth: {
            clientId: 'f587a308-979f-450f-bd3a-9307e7cbeccb',
            authority: 'https://login.microsoftonline.com/606b4859-aaa5-49d1-b841-d026b1053dc8'
        }
    },
    apiConfig: {
        scopes: ['user.read'],
        uri: 'https://graph.microsoft.com/v1.0/me'
    }
};
