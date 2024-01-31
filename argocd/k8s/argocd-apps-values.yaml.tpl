applications:
- name: argocd-apps
  namespace: argocd
  finalizers:
  - resources-finalizer.argocd.argoproj.io
  project: default
  source:
    repoURL: 'git@github.com:${github_org}/argocd-apps.git'
    targetRevision: main
    path: apps
    directory:
      recurse: true
  destination:
    server: https://kubernetes.default.svc
    namespace: argocd
  syncPolicy:
    automated:
      prune: false
      selfHeal: false
    syncOptions:
    - CreateNamespace=true
  revisionHistoryLimit: null
  ignoreDifferences:
  - group: apps
    kind: Deployment
    jsonPointers:
    - /spec/replicas
