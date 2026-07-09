[![Varbase](https://raw.githubusercontent.com/Vardot/varbase/11.0.x/images/varbase-logo.png)](https://www.drupal.org/project/varbase)

# Varbase AI Safety
[![pipeline status](https://git.drupalcode.org/project/varbase_ai_safety/badges/1.0.x/pipeline.svg)](https://git.drupalcode.org/project/varbase_ai_safety/-/pipelines)
[![Varbase AI Safety](https://img.shields.io/badge/Varbase%20AI%20Safety-1.0.0--beta1-0d6efc?labelColor=001d38&style=flat-square)](https://git.drupalcode.org/project/varbase_ai_safety/-/pipelines?ref=1.0.0-beta1)
[![Automated Functional Testing](https://git.drupalcode.org/project/varbase_project/badges/11.0.x/pipeline.svg)](https://git.drupalcode.org/project/varbase_project/-/pipelines)

A recipe to bundle a complete AI safety stack for Varbase — guardrails, logging, and observability.

This recipe provides a defense-in-depth AI safety setup including:
- Drupal AI module ([`ai`](https://www.drupal.org/project/ai))
- AI Logging ([`ai_logging`](https://www.drupal.org/project/ai)) with 90-day retention enabled by default
- AI Observability ([`ai_observability`](https://www.drupal.org/project/ai)) for transparency and compliance reporting
- 14 guardrail rules across 3 sets, configured against `restrict_to_topic` and `regexp_guardrail` plugins

## Sub-Recipes Applied

This recipe chains the following upstream recipes via the `recipes:` key:
- [`drupal/ai_recipe_guardrails_prompt_safety`](https://www.drupal.org/project/ai_recipe_guardrails_prompt_safety) — Prompt Safety: Liability set + Prompt Safety: Security set
- [`drupal/ai_recipe_guardrails_pii`](https://www.drupal.org/project/ai_recipe_guardrails_pii) — PII Protection set

## Included Guardrail Sets

### Prompt Safety: Liability (`prompt_safety_liability`)
Blocks topics that carry legal or reputational risk for the site owner.
- Liability: Legal Advice
- Liability: Medical Advice
- Liability: Sensitive Topics

### Prompt Safety: Security (`prompt_safety_security`)
Blocks structurally malicious input and semantic prompt attacks (XSS, HTML/CSS/JavaScript injection, prompt manipulation/jailbreak detection).
- Security: CSS Expression Injection
- Security: Dangerous HTML Tags
- Security: HTML Event Handler Injection
- Security: JavaScript Execution Functions
- Security: JavaScript Protocol
- Security: Prompt Manipulation
- Security: Script Tag Injection

### PII Protection (`pii_protection`)
Detects and blocks personally identifiable information (PII) in both user input and AI output. Baseline GDPR / data-protection coverage.
- PII: Credit Card Number
- PII: Email Address
- PII: IBAN
- PII: Phone Number

## AI Logging Settings Applied

- `prompt_logging`: `true` (automatic logging enabled)
- `prompt_logging_max_age`: `90` days (older entries auto-deleted)
- `prompt_logging_max_messages`: `1000`

## Compatible With

- Drupal core `~11.3.0`
- Varbase
- [`drupal/ai`](https://www.drupal.org/project/ai) `~1`
- [`drupal/ai_recipe_guardrails_prompt_safety`](https://www.drupal.org/project/ai_recipe_guardrails_prompt_safety) `~1`
- [`drupal/ai_recipe_guardrails_pii`](https://www.drupal.org/project/ai_recipe_guardrails_pii) `~1`

## Apply the Recipe

Add the recipe using composer:
```
composer require drupal/varbase_ai_safety:~1.0.0
```

Change directory to `/web` or `/docroot`

Run the Drupal recipe bash script:
```
bash core/scripts/drupal recipe recipes/contrib/varbase_ai_safety
```

or

Run the Drush recipe command:
```
drush recipe recipes/contrib/varbase_ai_safety
```

or

Apply via the Project Browser UI at `/admin/modules/browse/varbase_recipes` → click **Install** on **Varbase AI Safety**.

## Why This Matters for Varbase Enterprise Clients

Varbase targets enterprise Drupal deployments. Enterprise clients require:
- **Compliance evidence** — `ai_logging` + `ai_observability` provide the audit trail.
- **PII protection** — GDPR requirement for EU clients.
- **Liability control** — legal teams need assurance AI won't generate legal/medical advice.
- **Security hardening** — prevents AI-assisted XSS via content injection vectors.
