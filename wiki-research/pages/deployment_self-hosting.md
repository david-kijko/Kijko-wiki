---
url: https://supermemory.ai/docs/deployment/self-hosting
title: Self Hosting - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/deployment/self-hosting#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Self Hosting

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Prerequisites](https://supermemory.ai/docs/deployment/self-hosting#prerequisites)
- [Enterprise Deployment Package](https://supermemory.ai/docs/deployment/self-hosting#enterprise-deployment-package)
- [Cloudflare](https://supermemory.ai/docs/deployment/self-hosting#cloudflare)
- [Create Account](https://supermemory.ai/docs/deployment/self-hosting#create-account)
- [Create API Token](https://supermemory.ai/docs/deployment/self-hosting#create-api-token)
- [Enable Workers](https://supermemory.ai/docs/deployment/self-hosting#enable-workers)
- [Database](https://supermemory.ai/docs/deployment/self-hosting#database)
- [LLM Providers](https://supermemory.ai/docs/deployment/self-hosting#llm-providers)
- [OpenAI](https://supermemory.ai/docs/deployment/self-hosting#openai)
- [Anthropic](https://supermemory.ai/docs/deployment/self-hosting#anthropic)
- [Gemini](https://supermemory.ai/docs/deployment/self-hosting#gemini)
- [Groq](https://supermemory.ai/docs/deployment/self-hosting#groq)
- [Email Service Setup](https://supermemory.ai/docs/deployment/self-hosting#email-service-setup)
- [Resend](https://supermemory.ai/docs/deployment/self-hosting#resend)
- [Connectors (Optional)](https://supermemory.ai/docs/deployment/self-hosting#connectors-optional)
- [Google Drive](https://supermemory.ai/docs/deployment/self-hosting#google-drive)
- [Microsoft OneDrive](https://supermemory.ai/docs/deployment/self-hosting#microsoft-onedrive)
- [Notion](https://supermemory.ai/docs/deployment/self-hosting#notion)
- [Setup deployment files](https://supermemory.ai/docs/deployment/self-hosting#setup-deployment-files)
- [Configure environment variables](https://supermemory.ai/docs/deployment/self-hosting#configure-environment-variables)
- [Deploy](https://supermemory.ai/docs/deployment/self-hosting#deploy)
- [Updating Your Deployment](https://supermemory.ai/docs/deployment/self-hosting#updating-your-deployment)

This guide is intended for **enterprise customers only** who have specifically opted for self-hosting as part of their enterprise plan. If you’re on a standard plan, please use our hosted API at [console.supermemory.ai](https://console.supermemory.ai/).

## [​](https://supermemory.ai/docs/deployment/self-hosting\#prerequisites)  Prerequisites

Before you start, you’ll need to gather several API keys and set up accounts with various services. This comprehensive guide will walk you through obtaining each required component.

### [​](https://supermemory.ai/docs/deployment/self-hosting\#enterprise-deployment-package)  Enterprise Deployment Package

Your enterprise deployment package is provided by the supermemory team and contains:

- Your unique Host ID (`NEXT_PUBLIC_HOST_ID`)
- The compiled JavaScript bundle
- The deployment script

Contact your supermemory enterprise representative to receive your deployment package.

### [​](https://supermemory.ai/docs/deployment/self-hosting\#cloudflare)  Cloudflare

#### [​](https://supermemory.ai/docs/deployment/self-hosting\#create-account)  Create Account

1. Go to [cloudflare.com](https://dash.cloudflare.com/sign-up) and create an account
2. Your **Account ID** is the long randon string in the URL bar

#### [​](https://supermemory.ai/docs/deployment/self-hosting\#create-api-token)  Create API Token

1. Navigate to [Cloudflare API Tokens](https://dash.cloudflare.com/?to=/:account/api-tokens)
2. Click **“Create Token”**
3. Use the **“Custom token”** template
4. Configure the token with these permissions:
   - **Account:AI Gateway:Edit**
   - **Account:Hyperdrive:Edit**
   - **Account:Workers KV Storage:Edit**
   - **Account:Workers R2 Storage:Edit**
5. Click **“Continue to summary”** → **“Create Token”**
6. **Important**: Copy and securely store the token immediately (it won’t be shown again)

#### [​](https://supermemory.ai/docs/deployment/self-hosting\#enable-workers)  Enable Workers

1. In your Cloudflare dashboard, go to **Workers & Pages**
2. If prompted, accept the Workers terms of service
3. Choose a subdomain for your workers (e.g., `yourcompany.workers.dev`)

Your `CLOUDFLARE_ACCOUNT_ID` and `CLOUDFLARE_API_TOKEN` are now ready.

### [​](https://supermemory.ai/docs/deployment/self-hosting\#database)  Database

You’ll need to provide a PostgreSQL connection string via the `DATABASE_URL` environment variable.The database must:

- Support the **pgvector extension** for vector operations
- Be accessible from Cloudflare Workers
- Support SSL connections
- Allow connections from Cloudflare’s IP ranges

Your connection string should follow this format:

```
postgresql://username:password@hostname:port/database
```

### [​](https://supermemory.ai/docs/deployment/self-hosting\#llm-providers)  LLM Providers

#### [​](https://supermemory.ai/docs/deployment/self-hosting\#openai)  OpenAI

1. Go to [platform.openai.com](https://platform.openai.com/)
2. Sign in or create an account
3. Navigate to **API Keys** in the left sidebar
4. Click **“Create new secret key”**
5. Name your key (e.g., “supermemory Self-Hosted”)
6. Copy the key and store it securely
7. Add billing information if you haven’t already

#### [​](https://supermemory.ai/docs/deployment/self-hosting\#anthropic)  Anthropic

1. Go to [console.anthropic.com](https://console.anthropic.com/)
2. Create an account and complete verification
3. Navigate to **API Keys**
4. Click **“Create Key”**
5. Name your key and copy it securely

#### [​](https://supermemory.ai/docs/deployment/self-hosting\#gemini)  Gemini

1. Go to [Google AI Studio](https://aistudio.google.com/)
2. Sign in with your Google account
3. Click **“Get API key”** → **“Create API key”**
4. Choose an existing Google Cloud project or create a new one
5. Copy your API key

#### [​](https://supermemory.ai/docs/deployment/self-hosting\#groq)  Groq

1. Go to [console.groq.com](https://console.groq.com/)
2. Sign up for an account
3. Navigate to **API Keys**
4. Click **“Create API Key”**
5. Name your key and copy it

### [​](https://supermemory.ai/docs/deployment/self-hosting\#email-service-setup)  Email Service Setup

#### [​](https://supermemory.ai/docs/deployment/self-hosting\#resend)  Resend

1. Go to [resend.com](https://resend.com/) and create an account
2. Navigate to **API Keys**
3. Click **“Create API Key”**
4. Name your key (e.g., “supermemory Production”)
5. Copy the key for `RESEND_API_KEY`
6. Verify your sending domain in the **Domains** section

### [​](https://supermemory.ai/docs/deployment/self-hosting\#connectors-optional)  Connectors (Optional)

#### [​](https://supermemory.ai/docs/deployment/self-hosting\#google-drive)  Google Drive

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create or select a project
3. Enable the **Google Drive API**
4. Go to **Credentials** → **Create Credentials** → **OAuth client ID**
5. Configure the OAuth consent screen if required
6. Choose **Web application**
7. Add authorized redirect URIs for your domain
8. Copy `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET`

#### [​](https://supermemory.ai/docs/deployment/self-hosting\#microsoft-onedrive)  Microsoft OneDrive

1. Go to [Azure Portal](https://portal.azure.com/)
2. Navigate to **Microsoft Entra ID** → **App registrations**
3. Click **“New registration”**
4. Name your app and set redirect URI
5. Go to **Certificates & secrets** → **New client secret**
6. Copy the **Application (client) ID** and **Client secret**
7. Use for `MICROSOFT_CLIENT_ID` and `MICROSOFT_CLIENT_SECRET`

#### [​](https://supermemory.ai/docs/deployment/self-hosting\#notion)  Notion

1. Go to [Notion Developers](https://developers.notion.com/)
2. Click **“Create new integration”**
3. Fill in the integration details
4. Copy the **Internal Integration Token**
5. Set up OAuth if needed for user connections
6. Use for `NOTION_CLIENT_ID` and `NOTION_CLIENT_SECRET`

* * *

## [​](https://supermemory.ai/docs/deployment/self-hosting\#setup-deployment-files)  Setup deployment files

Extract the deployment package provided by the supermemory team to your preferred directory:

```
# Extract the deployment package
$ unzip supermemory-enterprise-deployment.zip
$ cd supermemory-deployment
```

* * *

## [​](https://supermemory.ai/docs/deployment/self-hosting\#configure-environment-variables)  Configure environment variables

The deployment script reads **all** environment variables from your shell at runtime. We ship an example file that lists the full set supported by the worker.

```
# Copy the template and start editing
$ cp packages/alchemy/env.example .env

# Open the file in your editor of choice and fill in the blanks
$ $EDITOR .env
```

Below is a quick reference.

**Required** values are mandatory for a successful deploy – leave optional ones empty if you don’t need the related feature.

| Name | Required? | Description |
| --- | --- | --- |
| `NODE_ENV` | ✅ | `development`, `staging` or `production`. |
| `NEXT_PUBLIC_HOST_ID` | ✅ | Your unique Host ID provided by the supermemory team. |
| `BETTER_AUTH_SECRET` | ✅ | Random 32-byte string – run `openssl rand -base64 32`. |
| `BETTER_AUTH_URL` | ✅ | Public base URL for the API (no trailing `/`). Example: `https://api.example.com`. |
| `DATABASE_URL` | ✅ | Postgres connection string (e.g. `postgres://user:pass@host:5432/db`). |
| `CLOUDFLARE_ACCOUNT_ID` | ✅ | Your Cloudflare account ID. |
| `CLOUDFLARE_API_TOKEN` | ✅ | Token created in _Prerequisites_. |
| `OPENAI_API_KEY` | ✅ | Key from [platform.openai.com](https://platform.openai.com/). |
| `RESEND_API_KEY` | ✅ | E-mail provider key if you plan to send e-mails. |
| `ANTHROPIC_API_KEY` |  | Needed to use Claude models. |
| `GEMINI_API_KEY` |  | Key for Google Gemini models. |
| `GROQ_API_KEY` |  | Key for Groq models. |
| `AUTH_GITHUB_ID` / `AUTH_GITHUB_SECRET` |  | Enable GitHub OAuth login. |
| `AUTH_GOOGLE_ID` / `AUTH_GOOGLE_SECRET` |  | Enable Google OAuth login. |
| `GOOGLE_CLIENT_ID` / `GOOGLE_CLIENT_SECRET` |  | Needed for Google Drive connector. |
| `MICROSOFT_CLIENT_ID` / `MICROSOFT_CLIENT_SECRET` |  | Needed for OneDrive connector. |
| `NOTION_CLIENT_ID` / `NOTION_CLIENT_SECRET` |  | Needed for Notion connector. |
| `CLOUDFLARE_AI_GATEWAY_NAME` / `CLOUDFLARE_AI_GATEWAY_TOKEN` |  | Only if you want to route requests through an AI Gateway. |
| `SENTRY_DSN` |  | If you use Sentry for error reporting. |

* * *

## [​](https://supermemory.ai/docs/deployment/self-hosting\#deploy)  Deploy

With your `.env` in place, run the deployment script:

```
# Run the deployment script provided in your package
$ bun ./deploy.ts
```

* * *

## [​](https://supermemory.ai/docs/deployment/self-hosting\#updating-your-deployment)  Updating Your Deployment

To update your supermemory deployment, follow the same process as the initial deployment described in the **Deploy** section above. You can reuse your existing `.env` file and add/remove any new environment variables as needed.

* * *

Was this page helpful?

YesNo

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)