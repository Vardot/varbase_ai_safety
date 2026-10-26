# Varbase functional testing suite

Playwright and Cucumber through [`@vardot/varbase-e2e`](https://www.npmjs.com/package/@vardot/varbase-e2e), on a
Varbase 11 site with this recipe applied.

| Feature | Covers |
| --- | --- |
| `01-01-ai-safety-image-check.feature` | An editor uploads an image: the vision model checks it, it is saved, and the check is in the AI log |
| `01-02-ai-safety-access.feature` | Only the webmaster opens the guardrails and the AI log |
| `01-03-ai-safety-accessibility.feature` | The add image form keeps the label, link name and ARIA rules |

The upload form elements are named selectors in `tests/selectors/ai-safety-selectors.json`.

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

The add image form is held to pinned accessibility rules rather than the full serious gate: the admin theme's
help toggles have no names and a details summary is low in contrast, which comes from the theme, not this
recipe.
