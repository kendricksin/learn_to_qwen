# AI Video Editor Project - AI Prompting Guide

Learn how to effectively prompt AI to help you build a personalized promotional campaign tool using Alibaba Cloud's WAN Animate Mix API for character swapping in videos.

## Project Overview

This project teaches you how to build an AI-powered video editing tool that uses character swap technology to create personalized promotional campaigns. You'll learn to work with cloud APIs, manage cloud storage, and create an interactive web interface.

## What You'll Learn

- **Cloud API Integration**: Work with Alibaba Cloud's WAN Animate Mix API
- **Cloud Storage**: Set up and use Object Storage Service (OSS) for video files
- **Service Accounts**: Configure authentication and access control
- **Server-Side JavaScript**: Build a Node.js server to handle API requests
- **Frontend Development**: Create an interactive web page for user interaction
- **Async Operations**: Handle long-running video processing tasks

## Tutorial Steps

Follow these sequential steps to build your project from scratch:

1. **[Step 1: Fill out your plan.md](STEP_1.md)**
   - Define your goals and prepare a structured plan for the AI.

2. **[Step 2: Set Up Alibaba Cloud Account](STEP_2.md)**
   - Create your Alibaba Cloud account and get API credentials.

3. **[Step 3: Configure OSS Service](STEP_3.md)**
   - Set up Object Storage Service for storing and serving video files.

4. **[Step 4: Explore the WAN API with Node.js](STEP_4.md)**
   - Build a Node.js server to test and interact with the WAN Animate Mix API.

5. **[Step 5: Create the User Interface](STEP_5.md)**
   - Build a simple web page for users to upload images/videos and see results.

6. **[Step 6: Deploy and Test](STEP_6.md)**
   - Finalize your application and check the reference answers.

---

## Prerequisites

Before starting this project, make sure you have:

- **Node.js and npm** installed (for the JavaScript server)
- **A credit/debit card** (Alibaba Cloud requires payment method for API access)
- **Basic JavaScript knowledge** (or willingness to learn with AI assistance)
- **Git** for version control

## ⚠️ Important: Set Up Environment Variables

> [!IMPORTANT]
> **Before you start coding**, copy the environment template file:
>
> ```bash
> cp .env.example .env
> ```
>
> Then edit `.env` with your actual API keys. **Never commit the `.env` file to Git!**
> The `.gitignore` file is already configured to protect your secrets.

## Estimated Costs

- **WAN Animate Mix API**: Pay-per-use pricing (check current rates)
- **OSS Storage**: Minimal costs for small projects
- **Free tier**: Some services may have free quotas for new users

> [!WARNING]
> This project involves cloud services that may incur costs. Always monitor your usage and set up billing alerts.

---

> [!TIP]
> Each step contains navigation links at the bottom to guide you through the process.

## Quick Links

- [WAN Animate Mix API Documentation](https://www.alibabacloud.com/help/en/model-studio/wan-animate-mix-api)
- [Alibaba Cloud OSS Documentation](https://www.alibabacloud.com/help/en/oss/)
- [Alibaba Cloud Console](https://www.alibabacloud.com/)
