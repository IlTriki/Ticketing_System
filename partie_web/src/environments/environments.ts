export const environment = {
    msalConfig: {
        auth: {
            clientId: 'your-client-id-here',
            authority: 'https://login.microsoftonline.com/your-tenant-id-here'
        }
    },
    apiConfig: {
        scopes: ['user.read'],
        uri: 'https://graph.microsoft.com/v1.0/me'
    }
};
