# Varbase functional testing suite

Playwright and Cucumber through [`@vardot/varbase-e2e`](https://www.npmjs.com/package/@vardot/varbase-e2e), on a
Varbase 11 site with this recipe applied.

| Feature | Covers |
| --- | --- |
| `01-01-ai-safety-image-check.feature` | An editor uploads an image: the vision model checks it and it is saved (`@live-ai`); the check on upload is in the AI log, whatever the verdict |
| `01-02-ai-safety-access.feature` | Only the webmaster opens the guardrails and the AI log |
| `01-03-ai-safety-accessibility.feature` | The add image form gives every field a label and every link a name |

The upload form elements are named selectors in `tests/selectors/ai-safety-selectors.json`.

One custom step, in `tests/step-definitions/files.steps.js`, attaches an upload to a file field by its label.

## Run it

```bash
npm install
LAUNCH_URL=https://your-site.ddev.site npm test
```

The site needs the webmaster (`webmaster`) and one user per role, named after the role (`content_editor`,
`content_admin`, `seo_admin`, `site_admin`), all with the password in `LOGIN_PASS` (default `dD.123123ddd`).
`.gitlab-ci.yml` shows the whole setup.

## AI provider

The recipe stops when no AI provider has a default model: CI checks that first. It then applies Drupal CMS AI,
which sets up an amazee.ai trial as the default provider, so no key is needed and the image check runs on a
real vision model.

When amazee.ai cannot be reached, `tests/scripts/ai-provider.sh` sets the AI module's Echo test provider instead,
prints "amazee.ai unavailable: running with the Echo test provider", exports `AI_PROVIDER=echoai` and skips the
scenarios tagged `@live-ai`, which need a real model's reply. `AMAZEE_UNREACHABLE=1` forces that path. To skip
them by hand: `CUCUMBER_TAGS="not @wip and not @live-ai" npm test`.

The add image form is held to the field label, link name and ARIA role checks rather than the full serious gate: the admin theme's
help toggles have no names and a details summary is low in contrast, which comes from the theme, not this
recipe.
