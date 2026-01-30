# Step 2 Reference: The Starting Prompt

Here is an example of a good opening prompt to send to the AI, based on the plan from Step 1.

### The Application

Copy and paste this into your AI chat:

> Hi Qwen! I want to build a custom interactive resume using React and Vite. Here is my plan:
>
> **Project**: Interactive Resume
> **Goal**: A responsive, single-page resume populated by a `resume.json` file.
> **Tech Stack**: React, Vite, CSS Modules or Reference CSS, Lucide React (for icons).
>
> **Specifics**:
>
> 1. I want to start with a blank Vite project.
> 2. I need a `resume.json` schema that covers Basics, Work, Education, and Skills.
> 3. Please create the folder structure and the first component (`Header.jsx`) to display my name and summary.
>
> Can you guide me through the setup?

### The Outcome

By sending this prompt, the AI should:

1. Give you the `npm create vite` command.
2. Provide the JSON structure for `src/data/resume.json`.
3. Write the initial code for `App.jsx` and `Header.jsx`.

---
[← Back to Step 2](../STEP_2.md) | [Next: Step 3 Reference →](STEP_3_COMPLETED.md)
