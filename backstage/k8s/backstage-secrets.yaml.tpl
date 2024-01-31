apiVersion: v1
kind: Secret
metadata:
  name: backstage-secrets
  namespace: backstage
data:
  AUTH_GITHUB_CLIENT_ID: ${auth_github_client_id}
  AUTH_GITHUB_CLIENT_SECRET: ${auth_github_client_secret}
  INTEGRATION_GITHUB_APP_ID: ${integration_github_app_id}
  INTEGRATION_GITHUB_CLIENT_ID: ${integration_github_client_id}
  INTEGRATION_GITHUB_CLIENT_SECRET: ${integration_github_client_secret}
  INTEGRATION_GITHUB_PRIVATE_KEY: ${integration_github_private_key}
  INTEGRATION_GITHUB_WEBHOOK_SECRET: ${integration_github_webhook_secret}
  POSTGRES_ADMIN_PASSWORD: ${postgres_admin_password}
  POSTGRES_USER_PASSWORD: ${postgres_user_password}
  GOOGLE_APPLICATION_CREDENTIALS: ${google_application_credentials}
