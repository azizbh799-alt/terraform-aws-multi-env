<<<<<<< HEAD
# AWS Multi-Environment Infrastructure — Terraform

Infrastructure AWS complète (VPC, EC2 avec Auto Scaling, RDS MySQL) provisionnée avec Terraform,
organisée en modules réutilisables et déployée sur 3 environnements isolés (dev, staging, prod).

## 🏗️ Architecture

```
                        Internet
                           │
                    ┌──────▼──────┐
                    │ Internet GW │
                    └──────┬──────┘
                           │
        ┌──────────────────┴──────────────────┐
        │              VPC (10.x.0.0/16)        │
        │  ┌────────────────────────────────┐  │
        │  │   Subnets publics (multi-AZ)    │  │
        │  │        NAT Gateway              │  │
        │  └────────────────┬─────────────────┘  │
        │                   │                    │
        │  ┌────────────────▼─────────────────┐  │
        │  │   Subnets privés (multi-AZ)      │  │
        │  │  ┌──────────┐    ┌────────────┐  │  │
        │  │  │ EC2 ASG  │───▶│  RDS MySQL │  │  │
        │  │  └──────────┘    └────────────┘  │  │
        │  └───────────────────────────────────┘  │
        └───────────────────────────────────────┘
```

## 📁 Structure du projet

```
terraform-aws-multi-env/
├── backend-setup/         # Bootstrap : bucket S3 + table DynamoDB (à déployer une seule fois)
├── modules/
│   ├── vpc/                # VPC, subnets publics/privés, IGW, NAT Gateway
│   ├── security-groups/    # SG web + SG base de données
│   ├── ec2/                # Launch Template + Auto Scaling Group
│   └── rds/                # Base de données MySQL managée
└── environments/
    ├── dev/                # 1 instance t2.micro, pas de NAT (économie), pas de multi-AZ
    ├── staging/             # 2 instances t3.small, NAT activé
    └── prod/                # 2-6 instances t3.medium, RDS multi-AZ (haute dispo)
```

## 🔐 Gestion des différences par environnement

| Paramètre | Dev | Staging | Prod |
|---|---|---|---|
| NAT Gateway | ❌ (économie) | ✅ | ✅ |
| Instance EC2 | t2.micro | t3.small | t3.medium |
| Auto Scaling | 1-1 | 1-3 | 2-6 |
| RDS | db.t3.micro | db.t3.small | db.t3.medium |
| Multi-AZ RDS | ❌ | ❌ | ✅ |
| Deletion protection | ❌ | ❌ | ✅ |
| Backup retention | 1 jour | 1 jour | 7 jours |

## 🚀 Déploiement

### 1. Bootstrap du backend distant (une seule fois)

```bash
cd backend-setup
terraform init
terraform apply -var="state_bucket_name=TON-NOM-UNIQUE-2026"
```

Note le `state_bucket_name` en sortie, puis remplace `REPLACE-WITH-YOUR-STATE-BUCKET-NAME`
dans chaque `environments/*/backend.tf`.

### 2. Déployer un environnement

```bash
cd environments/dev
cp terraform.tfvars.example terraform.tfvars   # puis édite my_ip_cidr
export TF_VAR_db_password="un_mot_de_passe_solide"

terraform init
terraform plan
terraform apply
```

Répète pour `staging/` et `prod/` — chaque environnement a son propre state,
donc aucun risque de conflit ou d'écrasement entre eux.

### 3. Détruire un environnement (dev par exemple)

```bash
cd environments/dev
terraform destroy
```

## ✅ Bonnes pratiques appliquées

- **State distant** avec verrouillage DynamoDB : plusieurs personnes peuvent travailler sans conflit
- **Modules réutilisables** : le même code sert aux 3 environnements, seules les variables changent
- **Secrets jamais committés** : `db_password` passé via variable d'environnement, `.tfvars` réels ignorés par git
- **Prod protégée** : `deletion_protection`, backups 7 jours, multi-AZ
- **Coûts maîtrisés en dev** : pas de NAT Gateway, instances minimales

## 🔜 Améliorations possibles

- Pipeline CI/CD (GitHub Actions/GitLab) avec `terraform plan` automatique sur PR
- Module EKS en remplacement/complément du module EC2
- Intégration HashiCorp Vault ou AWS Secrets Manager pour `db_password`
=======
# terraform-aws-multi-env
>>>>>>> d435c222f81f0e54ef69f1a8b27977e1ecd69d93
