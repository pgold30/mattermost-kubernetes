{{- define "config.tpl" -}}
{
    "ServiceSettings": {
        "SiteURL": "{{ .Values.global.siteUrl }}",
        "LicenseFileLocation": "/mattermost/mattermost.mattermost-license",
        "ListenAddress": ":8065",
        "ConnectionSecurity": "",
        "TLSCertFile": "",
        "TLSKeyFile": "",
        "UseLetsEncrypt": false,
        "LetsEncryptCertificateCacheFile": "./config/letsencrypt.cache",
        "Forward80To443": false,
        "ReadTimeout": 300,
        "WriteTimeout": 300,
        "MaximumLoginAttempts": 10,
        "GoroutineHealthThreshold": -1,
        "GoogleDeveloperKey": "",
        "EnableOAuthServiceProvider": false,
        "EnableIncomingWebhooks": true,
        "EnableOutgoingWebhooks": true,
        "EnableCommands": true,
        "EnableOnlyAdminIntegrations": false,
        "EnablePostUsernameOverride": false,
        "EnablePostIconOverride": false,
        "EnableLinkPreviews": {{ .Values.global.features.linkPreviews.enabled }},
        "EnableTesting": false,
        "EnableDeveloper": false,
        "EnableSecurityFixAlert": true,
        "EnableInsecureOutgoingConnections": false,
        "EnableMultifactorAuthentication": false,
        "EnforceMultifactorAuthentication": false,
        "AllowCorsFrom": "",
        "SessionLengthWebInDays": 30,
        "SessionLengthMobileInDays": 30,
        "SessionLengthSSOInDays": 30,
        "SessionCacheInMinutes": 10,
        "WebsocketSecurePort": 443,
        "WebsocketPort": 80,
        "WebserverMode": "gzip",
        "EnableCustomEmoji": {{ .Values.global.features.customEmoji.enabled }},
        "RestrictCustomEmojiCreation": "all",
        "EnableGifPicker": {{ .Values.global.features.enableGifPicker.enabled }},
        "GfycatApiKey": "2_KtH_W5",
        "GfycatApiSecret": "3wLVZPiswc3DnaiaFoLkDvB4X0IV6CpMkj4tf2inJRsBY6-FnkT08zGmppWFgeof",
        "RestrictPostDelete": "all",
        "AllowEditPost": "always",
        "PostEditTimeLimit": 300,
        "TimeBetweenUserTypingUpdatesMilliseconds": 5000,
        "EnablePostSearch": true,
        "EnableUserTypingMessages": true,
        "EnableUserStatuses": true,
        "ClusterLogTimeoutMilliseconds": 2000
    },
    "ElasticsearchSettings": {
        {{- if .Values.global.features.elasticsearch.enabled }}
        "ConnectionUrl": "http://{{ .Release.Name }}-mattermost-elasticsearch:9200",
        {{- else }}
        "ConnectionUrl": "",
        {{- end }}
        "Username": "",
        "Password": "",
        "EnableIndexing": {{ .Values.global.features.elasticsearch.enabled }},
        "EnableSearching": {{ .Values.global.features.elasticsearch.enabled }},
        "Sniff": true
    },
    "TeamSettings": {
        "SiteName": {{ .Values.global.siteName }},
        "MaxUsersPerTeam": 50000,
        "EnableTeamCreation": {{ .Values.global.features.teamCreation.enabled }},
        "EnableUserCreation": true,
        "EnableOpenServer": {{ .Values.global.openServer.enabled }},
        "RestrictCreationToDomains": {{ .Values.global.features.restrictCreationtoDomains }},
        "EnableCustomBrand": {{ .Values.global.enableCustonBrand.enabled }},
        "CustomBrandText": {{ .Values.global.customBrandText }},
        "CustomDescriptionText": {{ .Values.global.customBrandDescriptionText }},
        "RestrictDirectMessage": "any",
        "RestrictTeamInvite": "all",
        "RestrictPublicChannelManagement": "all",
        "RestrictPrivateChannelManagement": "all",
        "RestrictPublicChannelCreation": "all",
        "RestrictPrivateChannelCreation": "all",
        "RestrictPublicChannelDeletion": "all",
        "RestrictPrivateChannelDeletion": "all",
        "RestrictPrivateChannelManageMembers": "all",
        "UserStatusAwayTimeout": 300,
        "MaxChannelsPerTeam": 50000,
        "MaxNotificationsPerChannel": 1000
    },
    "SqlSettings": {
        {{- if .Values.global.features.database.useInternal }}
        "DriverName": "mysql",
        "DataSource": "{{ .Values.global.features.database.internal.dbUser }}:{{ .Values.global.features.database.internal.dbPassword }}@tcp({{ .Release.Name }}-mysqlha-0.{{ .Release.Name }}-mysqlha:3306)/{{ .Values.global.features.database.internal.dbName }}?charset=utf8mb4,utf8&readTimeout=30s&writeTimeout=30s",
        "DataSourceReplicas": ["{{ .Values.global.features.database.internal.dbUser }}:{{ .Values.global.features.database.internal.dbPassword }}@tcp({{ .Release.Name }}-mysqlha-readonly:3306)/{{ .Values.global.features.database.internal.dbName }}?charset=utf8mb4,utf8&readTimeout=30s&writeTimeout=30s"],
        {{- else }}
        "DriverName": "{{ .Values.global.features.database.external.driver }}",
        "DataSource": "{{ .Values.global.features.database.external.dataSource }}",
        "DataSourceReplicas": [
            {{ range $index, $element := .Values.global.features.database.external.dataSourceReplicas }}
                {{if $index}},{{end}}
                {{$element}}
            {{end}}
        ],
        {{- end }}
        "DataSourceSearchReplicas": [],
        "MaxIdleConns": 20,
        "MaxOpenConns": 35,
        "Trace": false,
        "AtRestEncryptKey": "{{ randAlphaNum 32 }}",
        "QueryTimeout": 30
    },
    "LogSettings": {
        "EnableConsole": true,
        "ConsoleLevel": "INFO",
        "EnableFile": true,
        "FileLevel": "INFO",
        "FileFormat": "",
        "FileLocation": "",
        "EnableWebhookDebugging": true,
        "EnableDiagnostics": true
    },
    "PasswordSettings": {
        "MinimumLength": {{ .Values.global.passwordLength }},
        "Lowercase": false,
        "Number": false,
        "Uppercase": false,
        "Symbol": false
    },
    "FileSettings": {
        "EnableFileAttachments": {{ .Values.global.features.enableFileAttachment.enabled }},
        "MaxFileSize": 52428800,
        "DriverName": "amazons3",
        "Directory": "./data/",
        "EnablePublicLink": false,
        "PublicLinkSalt": "{{ randAlphaNum 32 }}",
        "ThumbnailWidth": 120,
        "ThumbnailHeight": 100,
        "PreviewWidth": 1024,
        "PreviewHeight": 0,
        "ProfileWidth": 128,
        "ProfileHeight": 128,
        "InitialFont": "luximbi.ttf",
        "AmazonS3AccessKeyId": "{{ .Values.minio.accessKey }}",
        "AmazonS3SecretAccessKey": "{{ .Values.minio.secretKey }}",
        "AmazonS3Bucket": "bucket",
        "AmazonS3Region": "",
        "AmazonS3Endpoint": "{{ .Release.Name }}-minio:9000",
        "AmazonS3SSL": false,
        "AmazonS3SignV2": false
    },
    "EmailSettings": {
        "EnableSignUpWithEmail": {{ .Values.emailSettings.enableSignUpWithEmail.enabled }},
        "EnableSignInWithEmail": true,
        "EnableSignInWithUsername": true,
        "SendEmailNotifications": {{ .Values.emailSettings.sendEmailNotifications.enabled }},
        "RequireEmailVerification": {{ .Values.emailSettings.requireEmailVerification.enabled }},
        "FeedbackName": {{ .Values.emailSettings.feedbackName }},
        "FeedbackEmail": {{ .Values.emailSettings.feedbackEmail }},
        "FeedbackOrganization": {{ .Values.emailSettings.feedbackOrganization }},
        "SMTPUsername": {{ .Values.emailSettings.SMTPUsername }},
        "SMTPPassword": {{ .Values.emailSettings.SMTPPassword }},
        "SMTPServer": {{ .Values.emailSettings.SMTPServer }},
        "SMTPPort": {{ .Values.emailSettings.SMTPPort }},
        "ConnectionSecurity": {{ .Values.emailSettings.connectionSecurity }},
        "InviteSalt": "{{ randAlphaNum 32 }}",
        "SendPushNotifications": {{ .Values.global.features.notifications.push.enabled }},
        {{- if .Values.global.features.notifications.push.useHPNS -}}
        "PushNotificationServer": "https://push.mattermost.com",
        {{- else -}}
        "PushNotificationServer": "http://{{ .Release.Name }}-mattermost-push-proxy:8066",
        {{- end -}}
        "PushNotificationContents": "generic",
        "EnableEmailBatching": false,
        "EmailBatchingBufferSize": 256,
        "EmailBatchingInterval": 30,
        "SkipServerCertificateVerification": false
    },
    "RateLimitSettings": {
        "Enable": false,
        "PerSec": 10,
        "MaxBurst": 100,
        "MemoryStoreSize": 10000,
        "VaryByRemoteAddr": true,
        "VaryByHeader": ""
    },
    "PrivacySettings": {
        "ShowEmailAddress": true,
        "ShowFullName": true
    },
    "SupportSettings": {
        "TermsOfServiceLink": "https://about.mattermost.com/default-terms/",
        "PrivacyPolicyLink": "https://about.mattermost.com/default-privacy-policy/",
        "AboutLink": "https://about.mattermost.com/default-about/",
        "HelpLink": "https://about.mattermost.com/default-help/",
        "ReportAProblemLink": "https://about.mattermost.com/default-report-a-problem/",
        "SupportEmail": "feedback@mattermost.com"
    },
    "AnnouncementSettings": {
        "EnableBanner": false,
        "BannerText": "",
        "BannerColor": "#f2a93b",
        "BannerTextColor": "#333333",
        "AllowBannerDismissal": true
    },
    "GitLabSettings": {
        "Enable": false,
        "Secret": "",
        "Id": "",
        "Scope": "",
        "AuthEndpoint": "",
        "TokenEndpoint": "",
        "UserApiEndpoint": ""
    },
    "GoogleSettings": {
        "Enable": false,
        "Secret": "",
        "Id": "",
        "Scope": "profile email",
        "AuthEndpoint": "https://accounts.google.com/o/oauth2/v2/auth",
        "TokenEndpoint": "https://www.googleapis.com/oauth2/v4/token",
        "UserApiEndpoint": "https://www.googleapis.com/plus/v1/people/me"
    },
    "Office365Settings": {
        "Enable": false,
        "Secret": "",
        "Id": "",
        "Scope": "User.Read",
        "AuthEndpoint": "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
        "TokenEndpoint": "https://login.microsoftonline.com/common/oauth2/v2.0/token",
        "UserApiEndpoint": "https://graph.microsoft.com/v1.0/me"
    },
    "LdapSettings": {
        "Enable": false,
        "LdapServer": "",
        "LdapPort": 389,
        "ConnectionSecurity": "",
        "BaseDN": "",
        "BindUsername": "",
        "BindPassword": "",
        "UserFilter": "",
        "FirstNameAttribute": "",
        "LastNameAttribute": "",
        "EmailAttribute": "",
        "UsernameAttribute": "",
        "NicknameAttribute": "",
        "IdAttribute": "",
        "PositionAttribute": "",
        "SyncIntervalMinutes": 60,
        "SkipCertificateVerification": false,
        "QueryTimeout": 60,
        "MaxPageSize": 0,
        "LoginFieldName": ""
    },
    "ComplianceSettings": {
        "Enable": false,
        "Directory": "./data/",
        "EnableDaily": false
    },
    "LocalizationSettings": {
        "DefaultServerLocale": "en",
        "DefaultClientLocale": "en",
        "AvailableLocales": ""
    },
    "SamlSettings": {
        "Enable": false,
        "Verify": true,
        "Encrypt": true,
        "IdpUrl": "",
        "IdpDescriptorUrl": "",
        "AssertionConsumerServiceURL": "",
        "IdpCertificateFile": "",
        "PublicCertificateFile": "",
        "PrivateKeyFile": "",
        "FirstNameAttribute": "",
        "LastNameAttribute": "",
        "EmailAttribute": "",
        "UsernameAttribute": "",
        "NicknameAttribute": "",
        "LocaleAttribute": "",
        "PositionAttribute": "",
        "LoginButtonText": "With SAML"
    },
    "NativeAppSettings": {
        "AppDownloadLink": "https://about.mattermost.com/downloads/",
        "AndroidAppDownloadLink": "https://about.mattermost.com/mattermost-android-app/",
        "IosAppDownloadLink": "https://about.mattermost.com/mattermost-ios-app/"
    },
    "ClusterSettings": {
        "Enable": true,
        "ClusterName": "{{ .Release.Name }}-cluster",
        "OverrideHostname": "",
        "UseIpAddress": true,
        "UseExperimentalGossip": true,
        "ReadOnlyConfig": false,
        "GossipPort": 8074,
        "StreamingPort": 8075
    },
    "MetricsSettings": {
        "Enable": true,
        "BlockProfileRate": 0,
        "ListenAddress": ":8067"
    },
    "AnalyticsSettings": {
        "MaxUsersForStatistics": 2500
    },
    "WebrtcSettings": {
        "Enable": false,
        "GatewayWebsocketUrl": "",
        "GatewayAdminUrl": "",
        "GatewayAdminSecret": "",
        "StunURI": "",
        "TurnURI": "",
        "TurnUsername": "",
        "TurnSharedKey": ""
    },
    "DataRetentionSettings": {
        "Enable": false
    }
    {{- if .Values.global.features.jobserver.enabled -}}
    ,
    "JobSettings": {
        "RunJobs": false,
        "RunScheduler": false
    }
    {{- end -}}
}
{{- end -}}
