redis-ha:
  enabled: false

controller:
  replicas: 1

server:
  autoscaling:
    enabled: true
    minReplicas: 1

  ingress:
    enabled: true
    annotations:
      cert-manager.io/cluster-issuer: letsencrypt-prod
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
      nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
    ingressClassName: nginx
    hosts:
      - ${argocd_host}
    paths:
      - /
    tls:
      - secretName: argocd-tls
        hosts:
          - ${argocd_host}

repoServer:
  autoscaling:
    enabled: true
    minReplicas: 1

applicationSet:
  enabled: false

configs:
  credentialTemplates:
    argocd-apps:
      url: ${argocd_apps_repository_url}
  rbac:
    policy.default: role:readonly
    policy.csv: |
      p, role:platform-role, applications, create, */*, allow
      p, role:platform-role, applications, delete, */*, allow
      p, role:platform-role, applications, get, */*, allow
      p, role:platform-role, applications, override, */*, allow
      p, role:platform-role, applications, sync, */*, allow
      p, role:platform-role, applications, update, */*, allow
      p, role:platform-role, repositories, create, *, allow
      p, role:platform-role, repositories, update, *, allow
      p, role:platform-role, repositories, delete, *, allow
      g, ${{__GITHUB_ORG__}}:platform, role:platform-role
  cm:
    url: 'https://${argocd_host}'
    dex.config: |
      connectors:
        - type: github
          id: github
          name: GitHub
          config:
            clientID: ${argocd_sso_client_id}
            clientSecret: ${argocd_sso_client_secret}
            orgs:
            - name: ${{__GITHUB_ORG__}}
dex:
  enabled: true
