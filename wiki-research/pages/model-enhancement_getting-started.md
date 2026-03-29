---
url: https://supermemory.ai/docs/model-enhancement/getting-started
title: Getting Started with Model Enhancement - supermemory | Memory API for the AI era
---

[Skip to main content](https://supermemory.ai/docs/model-enhancement/getting-started#content-area)

[supermemory \| Memory API for the AI era home page![light logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/light.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=e4571d11b31900b962a200bf7206e7d9)![dark logo](https://mintcdn.com/supermemory/1szAHJ3-ym4bjQ4U/logo/dark.svg?fit=max&auto=format&n=1szAHJ3-ym4bjQ4U&q=85&s=23c339f1eafcd1c5ad241c14d94dad53)](https://supermemory.ai/docs)

Search...

Ctrl KAsk AI

Search...

Navigation

Getting Started with Model Enhancement

[Developer Platform](https://supermemory.ai/docs/intro) [API Integrations](https://supermemory.ai/docs/integrations/supermemory-sdk) [Plugins](https://supermemory.ai/docs/integrations/openclaw) [API Reference](https://supermemory.ai/docs/api-reference/manage-documents/add-document) [MemoryBench](https://supermemory.ai/docs/memorybench/overview) [Cookbook](https://supermemory.ai/docs/cookbook/overview) [Changelog](https://supermemory.ai/docs/changelog/overview)

On this page

- [Get your supermemory API key](https://supermemory.ai/docs/model-enhancement/getting-started#get-your-supermemory-api-key)
- [Get your LLM provider’s API key](https://supermemory.ai/docs/model-enhancement/getting-started#get-your-llm-provider%E2%80%99s-api-key)
- [Choose your endpoint](https://supermemory.ai/docs/model-enhancement/getting-started#choose-your-endpoint)
- [Making your first request](https://supermemory.ai/docs/model-enhancement/getting-started#making-your-first-request)

## [​](https://supermemory.ai/docs/model-enhancement/getting-started\#get-your-supermemory-api-key)  Get your supermemory API key

Head to [supermemory’s Developer Platform](https://console.supermemory.ai/) built to help you monitor and manage every aspect of the API.

Getting an API Key

[Navigate to header](https://supermemory.ai/docs/model-enhancement/getting-started#)

Create an account

An account will automatically be created on your first login.![Dev Platform Login Pn](https://mintcdn.com/supermemory/nafXZdsbm5CLncox/images/dev-platform-login.png?fit=max&auto=format&n=nafXZdsbm5CLncox&q=85&s=efd0960dda5c30f04c0019adb2c19eb7)

[Navigate to header](https://supermemory.ai/docs/model-enhancement/getting-started#)

Create an API Key

1

[Navigate to header](https://supermemory.ai/docs/model-enhancement/getting-started#)

Navigate to API Keys

![Dev Platform Api Keys Pn](https://mintcdn.com/supermemory/nafXZdsbm5CLncox/images/dev-platform-api-keys.png?fit=max&auto=format&n=nafXZdsbm5CLncox&q=85&s=486f73cc6892034cd2c84142b0f88207)Click `Create API Key`

2

[Navigate to header](https://supermemory.ai/docs/model-enhancement/getting-started#)

Choose Name and Expiry (Optional)

![Dev Platform Create Key Pn](https://mintcdn.com/supermemory/nafXZdsbm5CLncox/images/dev-platform-create-key.png?fit=max&auto=format&n=nafXZdsbm5CLncox&q=85&s=fd5be367f5652f8b48827baf12e73369)Click `Create`

3

[Navigate to header](https://supermemory.ai/docs/model-enhancement/getting-started#)

Copy New Key

![Dev Platform Copy Key Pn](https://mintcdn.com/supermemory/nafXZdsbm5CLncox/images/dev-platform-copy-key.png?fit=max&auto=format&n=nafXZdsbm5CLncox&q=85&s=5ea2a3072bfadef225abf3ea0f69cc8c)Click  to copy

Done! You can now use your API key to authenticate requests to the supermemory API.Next up, let’s add your first memory.

## [​](https://supermemory.ai/docs/model-enhancement/getting-started\#get-your-llm-provider%E2%80%99s-api-key)  Get your LLM provider’s API key

Head to your LLM provider’s dashboard and get your API key.

- [OpenAI](https://platform.openai.com/api-keys)
- [Gemini](https://aistudio.google.com/apikey)
- [Anthropic](https://console.anthropic.com/account/keys)
- [Groq](https://console.groq.com/keys)

## [​](https://supermemory.ai/docs/model-enhancement/getting-started\#choose-your-endpoint)  Choose your endpoint

OpenAI

Gemini

Anthropic

Groq

Other provider

```
https://api.supermemory.ai/v3/https://api.openai.com/v1/chat/completions
```

## [​](https://supermemory.ai/docs/model-enhancement/getting-started\#making-your-first-request)  Making your first request

cURL

TypeScript

```
curl https://api.supermemory.ai/v3/https://api.openai.com/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "x-supermemory--api-key: $SUPERMEMORY_API_KEY" \
  -H 'x-sm-user-id: user_id' \
  -d '{
    "model": "gpt-5",
    "messages": [\
      {"role": "user", "content": "What is the capital of France?"}\
    ]
  }'
```

Was this page helpful?

YesNo

Ctrl+I

Assistant

Responses are generated using AI and may contain mistakes.

Suggestions

User profiles and tool use together for multimodal use casesI am building XYZ. how do I use user profiles with the python SDK?

[Contact support](mailto:support@supermemory.com)

![Dev Platform Login Pn](https://mintcdn.com/supermemory/nafXZdsbm5CLncox/images/dev-platform-login.png?w=1100&fit=max&auto=format&n=nafXZdsbm5CLncox&q=85&s=f2d1a8744edf1271270fef1bc0575776)

![Dev Platform Api Keys Pn](https://mintcdn.com/supermemory/nafXZdsbm5CLncox/images/dev-platform-api-keys.png?w=1100&fit=max&auto=format&n=nafXZdsbm5CLncox&q=85&s=2802f88a862f5a9d8497b2c07933f706)

![Dev Platform Create Key Pn](https://mintcdn.com/supermemory/nafXZdsbm5CLncox/images/dev-platform-create-key.png?w=1100&fit=max&auto=format&n=nafXZdsbm5CLncox&q=85&s=62a4acb5a329816a48e8b2dd69a304d8)

![Dev Platform Copy Key Pn](https://mintcdn.com/supermemory/nafXZdsbm5CLncox/images/dev-platform-copy-key.png?w=1100&fit=max&auto=format&n=nafXZdsbm5CLncox&q=85&s=8574fcb6dcd21cd6d692550445ad78d9)