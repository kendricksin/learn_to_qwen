# Step 3 Reference: Iteration Example

Once the basics are working, you'll want to refine the look. Here is an example of an iteration loop.

### The Request (Prompt)
>
> "The resume looks a bit plain. Can we add a global dark theme using CSS variables? I want a customized look with a dark slate background and emerald green accents. Also, please add a fade-in animation to the sections."

### The Changes

The AI would modify your `src/index.css` to add variables like:

```css
:root {
  --bg-primary: #0f172a;
  --accent-color: #10b981;
}
```

And update your components to use these variables.

### Another Iteration
>
> "I want to add a proper 'Experience' section that lists my jobs. Please create an `Experience.jsx` component that maps through the `work` array in my JSON."

This is how you build the app piece by piece!

---
[← Back to Step 3](../STEP_3.md) | [Next: Step 4 Reference →](STEP_4_COMPLETED.md)
