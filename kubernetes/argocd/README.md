# Implantação do argocd

Após executar o setup, para aplicar alterações e permitir execução do terminal web nos pods:

Set the exec.enabled key to "true" on the argocd-cm ConfigMap.

Patch the argocd-server Role (if using namespaced Argo) or ClusterRole (if using clustered Argo) to allow argocd-server to exec into pods


- apiGroups:
  - ""
  resources:
  - pods/exec
  verbs:
  - create
Add RBAC rules to allow your users to create the exec resource, i.e.


p, role:myrole, exec, create, */*, allow
