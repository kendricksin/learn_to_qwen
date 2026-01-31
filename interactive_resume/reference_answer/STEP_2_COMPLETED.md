# Step 2 Reference: The Starting Prompt

Here is an example of a good opening prompt to send to the AI, based on the plan from Step 1.

### The Application

Copy and paste this into your AI chat:

> Help me build my resume website given the following plan.md input. create a shell script to setup my project folder.
> 
> ## Project Overview:
> I want to build a modern, interactive resume web page using React that displays my professional profile from a standard JSON format that I can edit easily.
> 
> ## 1. What are you trying to build?
> - Resume website designed for Clarity, Speed, and Professional Tone
> - Easy to Verify and Connect with links to my other profile pages and contact information
> 
> ## 2. What does 'done' look like?
> - It Loads Fast and Works Everywhere
> - Key Info Is Easy to Find (in <10 seconds)
> - Looks Clean and Professional
> 
> ## 3. What technologies will you use?
> - HTML
> - CSS
> - GitHub Pages
> - JSON resume
> 
> ## Additional Requirements
> - Customization: Have downloadable PDF format on click, allow light and dark mode
> - Deployment: It should be easy to host on GitHub Pages and I can refresh it anytime
> 
> ## Specific Questions
> - Can you provide a sample `resume.json` based on the standard?
> - How can I add a personal touch to the theme?

https://chat.qwen.ai/s/t_89430767-0932-47ac-9f07-9cd82e95d9de?fev=0.1.38

### The Outcome

By sending this prompt, the AI should:

1. Give you the `npm create vite` command.
2. Provide the JSON structure for `src/data/resume.json`.
3. Write the initial code for `App.jsx` and `Header.jsx`.

---
[← Back to Step 2](../STEP_2.md) | [Next: Step 3 Reference →](STEP_3_COMPLETED.md)
