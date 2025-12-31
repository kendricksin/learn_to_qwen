# Interactive Resume Page with Node.js

This project demonstrates how to create an interactive resume web page using Node.js, npm, and Markdown parsing.

## What You'll Learn

- Node.js project setup and npm commands
- Basic npm packages and dependencies
- Markdown parsing and conversion
- Creating a simple web server with Express
- Static site generation from Markdown

## How to Create This Project

### 1. Initialize your Node.js project
```bash
mkdir interactive_resume
cd interactive_resume
npm init -y
```

### 2. Install required packages
```bash
npm install express marked dotenv
npm install --save-dev nodemon
```

### 3. Create your project structure
```
interactive_resume/
├── package.json
├── server.js
├── resume.md
├── public/
│   ├── index.html
│   ├── style.css
│   └── script.js
└── .env
```

### 4. Create your resume in Markdown format (resume.md)
```markdown
# John Doe

## About Me
Passionate web developer with 5 years of experience in JavaScript and Node.js.

## Skills
- JavaScript
- Node.js
- HTML/CSS
- React
- Express

## Experience
### Senior Developer at Tech Corp
*Jan 2020 - Present*
- Developed web applications using React and Node.js
- Led a team of 5 developers

### Junior Developer at Startup Inc
*Mar 2018 - Dec 2019*
- Built responsive web pages
- Implemented REST APIs

## Education
### B.S. Computer Science
University of Technology, 2017
```

### 5. Create the main server file (server.js)
```javascript
const express = require('express');
const fs = require('fs');
const marked = require('marked');
const path = require('path');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Set up static files
app.use(express.static('public'));

// Route to serve the resume page
app.get('/', (req, res) => {
  fs.readFile('resume.md', 'utf8', (err, data) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error reading resume file');
      return;
    }
    
    // Convert markdown to HTML
    const resumeHtml = marked.parse(data);
    
    // Create a complete HTML page
    const htmlPage = `
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Interactive Resume</title>
        <link rel="stylesheet" href="/style.css">
    </head>
    <body>
        <div id="resume-container">
            ${resumeHtml}
        </div>
        <script src="/script.js"></script>
    </body>
    </html>`;
    
    res.send(htmlPage);
  });
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
```

### 6. Create the CSS file (public/style.css)
```css
body {
  font-family: Arial, sans-serif;
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  background-color: #f5f5f5;
}

#resume-container {
  background-color: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

h1 {
  color: #2c3e50;
  border-bottom: 2px solid #3498db;
  padding-bottom: 10px;
}

h2 {
  color: #34495e;
  margin-top: 25px;
}

h3 {
  color: #7f8c8d;
  margin-top: 20px;
}

ul {
  margin: 10px 0;
}

li {
  margin: 5px 0;
}

#resume-container a {
  color: #3498db;
  text-decoration: none;
}

#resume-container a:hover {
  text-decoration: underline;
}

@media (max-width: 600px) {
  body {
    padding: 10px;
  }
  
  #resume-container {
    padding: 20px;
  }
}
```

### 7. Create the JavaScript file (public/script.js)
```javascript
// Add interactivity to the resume
document.addEventListener('DOMContentLoaded', function() {
  // Add smooth scrolling for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      document.querySelector(this.getAttribute('href')).scrollIntoView({
        behavior: 'smooth'
      });
    });
  });
  
  // Add print functionality
  const printButton = document.createElement('button');
  printButton.textContent = 'Print Resume';
  printButton.style.cssText = `
    position: fixed;
    top: 20px;
    right: 20px;
    padding: 10px 15px;
    background-color: #3498db;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    z-index: 1000;
  `;
  printButton.addEventListener('click', () => {
    window.print();
  });
  
  document.body.appendChild(printButton);
});
```

### 8. Update your package.json to include a start script
```json
{
  "name": "interactive_resume",
  "version": "1.0.0",
  "description": "Interactive resume built with Node.js",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "marked": "^4.2.0",
    "dotenv": "^16.0.3"
  },
  "devDependencies": {
    "nodemon": "^2.0.20"
  }
}
```

### 9. Run your application
```bash
npm run dev  # For development with auto-restart
# or
npm start    # For production
```

Visit http://localhost:3000 to see your interactive resume!

## Key npm Commands Used

- `npm init`: Initialize a new Node.js project
- `npm install <package>`: Install a package
- `npm install --save-dev <package>`: Install a development dependency
- `npm run <script>`: Run a script defined in package.json
- `npm list`: List installed packages