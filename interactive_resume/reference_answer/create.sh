#!/bin/bash

# Create project directory
PROJECT_NAME="interactive_resume"
mkdir -p $PROJECT_NAME
cd $PROJECT_NAME

# Create project structure
mkdir -p src/{css,js,assets}
mkdir -p dist

# Create package.json for npm management
cat > package.json << 'EOF'
{
  "name": "interactive_resume",
  "version": "1.0.0",
  "description": "Modern interactive resume website with JSON data",
  "main": "index.html",
  "scripts": {
    "start": "python -m http.server 8000",
    "build": "cp -r src/* dist/ && cp index.html dist/",
    "test": "echo \"No tests specified\" && exit 0"
  },
  "keywords": ["resume", "portfolio", "personal-website"],
  "author": "",
  "license": "MIT"
}
EOF

# Create main HTML file with tabs and animation
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Professional Resume</title>
    <link rel="stylesheet" href="src/css/style.css">
    <link rel="stylesheet" href="src/css/theme.css">
    <link rel="stylesheet" href="src/css/tabs.css">
</head>
<body>
    <div id="app">
        <header class="header">
            <nav class="navbar">
                <div class="animation-container">
                    <div class="flower">
                        <div class="petal petal-1"></div>
                        <div class="petal petal-2"></div>
                        <div class="petal petal-3"></div>
                        <div class="petal petal-4"></div>
                        <div class="center"></div>
                    </div>
                </div>
                <div class="nav-buttons">
                    <button id="theme-toggle">Toggle Theme</button>
                    <button id="pdf-download">Download PDF</button>
                </div>
            </nav>
        </header>
        
        <main class="container">
            <section id="profile-section" class="profile-section">
                <div class="profile-header">
                    <h1 id="full-name">Loading...</h1>
                    <p id="job-title" class="subtitle">Loading...</p>
                    <p id="summary"></p>
                </div>
                
                <div class="contact-info">
                    <div id="location"></div>
                    <a id="email-link" href="#"></a>
                    <a id="phone-link" href="#"></a>
                    <a id="website-link" href="#" target="_blank"></a>
                </div>
            </section>
            
            <!-- Interactive Tabs -->
            <div class="tabs-container">
                <div class="tab-nav">
                    <button class="tab-button active" data-tab="experience">Experience</button>
                    <button class="tab-button" data-tab="education">Education</button>
                    <button class="tab-button" data-tab="skills">Skills</button>
                    <button class="tab-button" data-tab="projects">Projects</button>
                    <button class="tab-button" data-tab="about">About Me</button>
                </div>
                
                <div class="tab-content">
                    <div id="experience-tab" class="tab-pane active">
                        <h2>Work Experience</h2>
                        <div id="work-experience"></div>
                    </div>
                    
                    <div id="education-tab" class="tab-pane">
                        <h2>Education</h2>
                        <div id="education-list"></div>
                    </div>
                    
                    <div id="skills-tab" class="tab-pane">
                        <h2>Skills & Technologies</h2>
                        <div id="skills-container"></div>
                    </div>
                    
                    <div id="projects-tab" class="tab-pane">
                        <h2>Projects</h2>
                        <div id="projects-list"></div>
                    </div>
                    
                    <div id="about-tab" class="tab-pane">
                        <h2>About Me</h2>
                        <div id="about-content">
                            <h3>Interests & Hobbies</h3>
                            <div id="interests-list"></div>
                            <h3>Awards & Certifications</h3>
                            <div id="awards-list"></div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="src/js/resume-data.js"></script>
    <script src="src/js/theme-manager.js"></script>
    <script src="src/js/renderer.js"></script>
    <script src="src/js/tabs.js"></script>
    <script src="src/js/animations.js"></script>
    <script src="src/js/main.js"></script>
</body>
</html>
EOF

# Create sample resume.json with additional fields
cat > src/resume.json << 'EOF'
{
  "basics": {
    "name": "Your Full Name",
    "label": "Professional Title",
    "image": "",
    "email": "your.email@example.com",
    "phone": "(555) 123-4567",
    "url": "https://your-website.com",
    "summary": "A brief summary of your professional background and key strengths...",
    "location": {
      "address": "Street Address",
      "postalCode": "ZIP",
      "city": "City",
      "countryCode": "US",
      "region": "State"
    },
    "profiles": [
      {
        "network": "LinkedIn",
        "username": "your-linkedin",
        "url": "https://linkedin.com/in/your-profile"
      },
      {
        "network": "GitHub",
        "username": "your-github",
        "url": "https://github.com/your-profile"
      }
    ]
  },
  "work": [
    {
      "name": "Company Name",
      "position": "Job Title",
      "startDate": "2020-01-01",
      "endDate": "2023-12-31",
      "summary": "Description of responsibilities and achievements...",
      "highlights": [
        "Key achievement or responsibility",
        "Notable project or accomplishment"
      ]
    }
  ],
  "volunteer": [],
  "education": [
    {
      "institution": "University Name",
      "area": "Field of Study",
      "studyType": "Degree Type",
      "startDate": "2016-09-01",
      "endDate": "2020-05-01",
      "gpa": "3.8"
    }
  ],
  "awards": [
    {
      "title": "Award Title",
      "date": "2022-01-01",
      "awarder": "Organization Name",
      "summary": "Brief description of the award"
    }
  ],
  "certificates": [
    {
      "name": "Certificate Name",
      "date": "2023-01-01",
      "issuer": "Issuing Organization",
      "url": "https://certificate-url.com"
    }
  ],
  "publications": [],
  "skills": [
    {
      "name": "JavaScript",
      "level": "Expert",
      "keywords": ["React", "Node.js", "ES6"]
    },
    {
      "name": "Web Development",
      "level": "Advanced",
      "keywords": ["HTML", "CSS", "Responsive Design"]
    }
  ],
  "languages": [
    {
      "language": "English",
      "fluency": "Native speaker"
    },
    {
      "language": "Spanish",
      "fluency": "Conversational"
    }
  ],
  "interests": [
    {
      "name": "Photography",
      "keywords": ["Landscape", "Portrait", "Travel"]
    },
    {
      "name": "Hiking",
      "keywords": ["Mountains", "Trails", "Adventure"]
    }
  ],
  "references": [],
  "projects": [
    {
      "name": "Project Name",
      "startDate": "2023-01-01",
      "endDate": "2023-06-01",
      "summary": "Brief description of the project...",
      "highlights": [
        "Key feature or technology used",
        "Result or impact achieved"
      ],
      "url": "https://project-url.com"
    }
  ]
}
EOF

# Create main CSS file
cat > src/css/style.css << 'EOF'
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    transition: background-color 0.3s ease, color 0.3s ease;
}

.container {
    max-width: 1000px;
    margin: 0 auto;
    padding: 2rem;
}

.header {
    background: var(--header-bg);
    padding: 1rem 2rem;
    position: sticky;
    top: 0;
    z-index: 100;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.animation-container {
    display: flex;
    align-items: center;
    margin-right: 1rem;
}

.flower {
    width: 30px;
    height: 30px;
    position: relative;
    animation: sway 3s ease-in-out infinite;
}

.petal {
    position: absolute;
    width: 10px;
    height: 15px;
    background: var(--accent-color);
    border-radius: 50%;
}

.petal-1 { top: 0; left: 10px; transform: rotate(0deg); }
.petal-2 { top: 5px; right: 0; transform: rotate(90deg); }
.petal-3 { bottom: 0; left: 10px; transform: rotate(180deg); }
.petal-4 { top: 5px; left: 0; transform: rotate(270deg); }

.center {
    position: absolute;
    top: 8px;
    left: 8px;
    width: 14px;
    height: 14px;
    background: gold;
    border-radius: 50%;
}

@keyframes sway {
    0%, 100% { transform: rotate(-5deg); }
    50% { transform: rotate(5deg); }
}

.nav-buttons {
    display: flex;
    gap: 1rem;
}

.navbar button {
    padding: 0.5rem 1rem;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    background: var(--button-bg);
    color: var(--button-text);
    transition: transform 0.2s ease;
}

.navbar button:hover {
    transform: scale(1.05);
}

.profile-section {
    text-align: center;
    padding: 2rem 0;
    border-bottom: 1px solid var(--border-color);
}

.profile-header h1 {
    font-size: 2.5rem;
    margin-bottom: 0.5rem;
    color: var(--heading-color);
    animation: fadeInDown 0.8s ease-out;
}

.subtitle {
    font-size: 1.2rem;
    color: var(--text-secondary);
    margin-bottom: 1rem;
    animation: fadeInUp 0.8s ease-out 0.2s both;
}

.contact-info {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 1rem;
    margin-top: 1rem;
    animation: fadeInUp 0.8s ease-out 0.4s both;
}

.contact-info div, .contact-info a {
    color: var(--text-primary);
    text-decoration: none;
    font-weight: 500;
    transition: color 0.3s ease;
}

.contact-info a:hover {
    color: var(--accent-color);
}

.tabs-container {
    margin-top: 2rem;
}

.tab-nav {
    display: flex;
    border-bottom: 2px solid var(--border-color);
    margin-bottom: 1.5rem;
    overflow-x: auto;
}

.tab-button {
    padding: 1rem 1.5rem;
    border: none;
    background: transparent;
    color: var(--text-secondary);
    cursor: pointer;
    border-bottom: 3px solid transparent;
    transition: all 0.3s ease;
    white-space: nowrap;
}

.tab-button.active {
    color: var(--accent-color);
    border-bottom-color: var(--accent-color);
    background: var(--card-bg);
}

.tab-button:hover:not(.active) {
    color: var(--heading-color);
    background: var(--hover-bg);
}

.tab-pane {
    display: none;
    animation: slideIn 0.3s ease-out;
}

.tab-pane.active {
    display: block;
}

.content-section {
    margin: 3rem 0;
}

.content-section h2 {
    font-size: 1.8rem;
    margin-bottom: 1.5rem;
    color: var(--heading-color);
    border-bottom: 2px solid var(--accent-color);
    padding-bottom: 0.5rem;
}

.work-item, .education-item, .project-item {
    margin-bottom: 2rem;
    padding: 1rem;
    border-left: 3px solid var(--accent-color);
    background: var(--card-bg);
    border-radius: 4px;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.work-item:hover, .education-item:hover, .project-item:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.work-item h3, .education-item h3, .project-item h3 {
    color: var(--heading-color);
    margin-bottom: 0.5rem;
}

.work-item .dates, .education-item .dates, .project-item .dates {
    color: var(--text-secondary);
    font-style: italic;
    margin-bottom: 0.5rem;
}

.skill-category {
    margin-bottom: 1rem;
    padding: 0.75rem;
    background: var(--card-bg);
    border-radius: 4px;
    border-left: 3px solid var(--accent-color);
}

.skill-name {
    font-weight: bold;
    margin-right: 0.5rem;
    color: var(--heading-color);
}

.skill-level {
    color: var(--text-secondary);
    font-size: 0.9em;
}

.skill-keywords {
    margin-top: 0.25rem;
}

.skill-keywords span {
    display: inline-block;
    background: var(--tag-bg);
    color: var(--tag-text);
    padding: 0.25rem 0.5rem;
    border-radius: 12px;
    margin: 0.25rem;
    font-size: 0.8rem;
    transition: transform 0.2s ease;
}

.skill-keywords span:hover {
    transform: scale(1.05);
}

.interest-item, .award-item {
    margin-bottom: 1rem;
    padding: 0.75rem;
    background: var(--card-bg);
    border-radius: 4px;
    border-left: 3px solid var(--accent-color);
}

@keyframes fadeInDown {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@media print {
    .navbar, .tabs-container, .tab-nav {
        display: none;
    }
    
    .tab-pane {
        display: block !important;
    }
    
    body {
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
    }
}

@media (max-width: 768px) {
    .navbar {
        flex-direction: column;
        gap: 1rem;
    }
    
    .animation-container {
        margin-right: 0;
        margin-bottom: 0.5rem;
    }
    
    .tab-nav {
        flex-wrap: wrap;
    }
    
    .tab-button {
        padding: 0.75rem 1rem;
        font-size: 0.9rem;
    }
}
EOF

# Create tabs CSS
cat > src/css/tabs.css << 'EOF'
.tab-nav {
    display: flex;
    border-bottom: 2px solid var(--border-color);
    margin-bottom: 1.5rem;
    overflow-x: auto;
    gap: 0.5rem;
}

.tab-button {
    padding: 1rem 1.5rem;
    border: none;
    background: transparent;
    color: var(--text-secondary);
    cursor: pointer;
    border-bottom: 3px solid transparent;
    transition: all 0.3s ease;
    white-space: nowrap;
    font-weight: 500;
    position: relative;
}

.tab-button::after {
    content: '';
    position: absolute;
    bottom: -2px;
    left: 0;
    width: 0;
    height: 2px;
    background: var(--accent-color);
    transition: width 0.3s ease;
}

.tab-button:hover::after {
    width: 100%;
}

.tab-button.active {
    color: var(--accent-color);
    border-bottom-color: var(--accent-color);
    background: var(--card-bg);
}

.tab-button:hover:not(.active) {
    color: var(--heading-color);
    background: var(--hover-bg);
}

.tab-pane {
    display: none;
    animation: slideIn 0.3s ease-out;
    min-height: 300px;
}

.tab-pane.active {
    display: block;
}

.tab-pane h2 {
    color: var(--heading-color);
    margin-bottom: 1rem;
    font-size: 1.5rem;
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Mobile responsive tabs */
@media (max-width: 768px) {
    .tab-nav {
        flex-wrap: wrap;
    }
    
    .tab-button {
        padding: 0.75rem 1rem;
        font-size: 0.9rem;
        min-width: fit-content;
    }
}
EOF

# Create theme CSS file
cat > src/css/theme.css << 'EOF'
:root {
    --bg-color: #ffffff;
    --text-primary: #333333;
    --text-secondary: #666666;
    --heading-color: #2c3e50;
    --header-bg: #f8f9fa;
    --card-bg: #ffffff;
    --hover-bg: #f8f9fa;
    --button-bg: #3498db;
    --button-text: #ffffff;
    --accent-color: #3498db;
    --border-color: #e0e0e0;
    --tag-bg: #e3f2fd;
    --tag-text: #1976d2;
}

[data-theme="dark"] {
    --bg-color: #1a1a1a;
    --text-primary: #e0e0e0;
    --text-secondary: #b0b0b0;
    --heading-color: #ffffff;
    --header-bg: #2d2d2d;
    --card-bg: #2d2d2d;
    --hover-bg: #3a3a3a;
    --button-bg: #2980b9;
    --button-text: #ffffff;
    --accent-color: #3498db;
    --border-color: #404040;
    --tag-bg: #3a3a3a;
    --tag-text: #64b5f6;
}

body {
    background-color: var(--bg-color);
    color: var(--text-primary);
}
EOF

# Create JavaScript for resume data handling
cat > src/js/resume-data.js << 'EOF'
// Load resume data from JSON file
async function loadResumeData() {
    try {
        const response = await fetch('src/resume.json');
        return await response.json();
    } catch (error) {
        console.error('Error loading resume data:', error);
        // Fallback data if JSON fails to load
        return {
            basics: {
                name: "Your Name",
                label: "Professional Title",
                summary: "Default summary text - update your resume.json file",
                email: "email@example.com",
                phone: "(555) 123-4567",
                url: "https://example.com",
                location: { city: "City", region: "Region" },
                profiles: []
            },
            work: [],
            education: [],
            skills: [],
            projects: [],
            awards: [],
            interests: [],
            certificates: []
        };
    }
}
EOF

# Create theme manager
cat > src/js/theme-manager.js << 'EOF'
class ThemeManager {
    constructor() {
        this.currentTheme = localStorage.getItem('theme') || 'light';
        this.applyTheme();
    }

    toggleTheme() {
        this.currentTheme = this.currentTheme === 'light' ? 'dark' : 'light';
        this.applyTheme();
        localStorage.setItem('theme', this.currentTheme);
    }

    applyTheme() {
        document.documentElement.setAttribute('data-theme', this.currentTheme);
    }

    initializeToggle() {
        const toggleButton = document.getElementById('theme-toggle');
        if (toggleButton) {
            toggleButton.addEventListener('click', () => this.toggleTheme());
        }
    }
}

const themeManager = new ThemeManager();
EOF

# Create renderer functions
cat > src/js/renderer.js << 'EOF'
function renderProfile(basics) {
    document.getElementById('full-name').textContent = basics.name || 'Name Not Available';
    document.getElementById('job-title').textContent = basics.label || '';
    document.getElementById('summary').textContent = basics.summary || '';
    
    // Render contact info
    if (basics.location?.city && basics.location?.region) {
        document.getElementById('location').textContent = `${basics.location.city}, ${basics.location.region}`;
    }
    
    if (basics.email) {
        const emailLink = document.getElementById('email-link');
        emailLink.textContent = basics.email;
        emailLink.href = `mailto:${basics.email}`;
    }
    
    if (basics.phone) {
        const phoneLink = document.getElementById('phone-link');
        phoneLink.textContent = basics.phone;
        phoneLink.href = `tel:${basics.phone}`;
    }
    
    if (basics.url) {
        const websiteLink = document.getElementById('website-link');
        websiteLink.textContent = basics.url;
        websiteLink.href = basics.url;
    }
}

function renderWorkExperience(work) {
    const container = document.getElementById('work-experience');
    container.innerHTML = '';
    
    work.forEach(job => {
        const jobElement = document.createElement('div');
        jobElement.className = 'work-item';
        jobElement.innerHTML = `
            <h3>${job.position} - ${job.name}</h3>
            <div class="dates">${formatDate(job.startDate)} - ${job.endDate ? formatDate(job.endDate) : 'Present'}</div>
            <p>${job.summary || ''}</p>
            <ul>
                ${(job.highlights || []).map(highlight => `<li>${highlight}</li>`).join('')}
            </ul>
        `;
        container.appendChild(jobElement);
    });
}

function renderEducation(education) {
    const container = document.getElementById('education-list');
    container.innerHTML = '';
    
    education.forEach(edu => {
        const eduElement = document.createElement('div');
        eduElement.className = 'education-item';
        eduElement.innerHTML = `
            <h3>${edu.area} - ${edu.institution}</h3>
            <div class="dates">${formatDate(edu.startDate)} - ${formatDate(edu.endDate)}</div>
            <p>${edu.studyType || ''}${edu.gpa ? `, GPA: ${edu.gpa}` : ''}</p>
        `;
        container.appendChild(eduElement);
    });
}

function renderSkills(skills) {
    const container = document.getElementById('skills-container');
    container.innerHTML = '';
    
    skills.forEach(skill => {
        const skillElement = document.createElement('div');
        skillElement.className = 'skill-category';
        skillElement.innerHTML = `
            <span class="skill-name">${skill.name}</span>
            <span class="skill-level">(${skill.level})</span>
            <div class="skill-keywords">
                ${(skill.keywords || []).map(keyword => `<span>${keyword}</span>`).join('')}
            </div>
        `;
        container.appendChild(skillElement);
    });
}

function renderProjects(projects) {
    const container = document.getElementById('projects-list');
    container.innerHTML = '';
    
    projects.forEach(project => {
        const projectElement = document.createElement('div');
        projectElement.className = 'project-item';
        projectElement.innerHTML = `
            <h3><a href="${project.url || '#'}" target="_blank">${project.name}</a></h3>
            <div class="dates">${formatDate(project.startDate)} - ${project.endDate ? formatDate(project.endDate) : 'Present'}</div>
            <p>${project.summary || ''}</p>
            <ul>
                ${(project.highlights || []).map(highlight => `<li>${highlight}</li>`).join('')}
            </ul>
        `;
        container.appendChild(projectElement);
    });
}

function renderInterests(interests) {
    const container = document.getElementById('interests-list');
    container.innerHTML = '';
    
    interests.forEach(interest => {
        const interestElement = document.createElement('div');
        interestElement.className = 'interest-item';
        interestElement.innerHTML = `
            <h4>${interest.name}</h4>
            <div class="skill-keywords">
                ${(interest.keywords || []).map(keyword => `<span>${keyword}</span>`).join('')}
            </div>
        `;
        container.appendChild(interestElement);
    });
}

function renderAwards(awards) {
    const container = document.getElementById('awards-list');
    container.innerHTML = '';
    
    awards.forEach(award => {
        const awardElement = document.createElement('div');
        awardElement.className = 'award-item';
        awardElement.innerHTML = `
            <h4>${award.title}</h4>
            <p><strong>${award.awarder}</strong> - ${formatDate(award.date)}</p>
            <p>${award.summary || ''}</p>
        `;
        container.appendChild(awardElement);
    });
}

function formatDate(dateString) {
    if (!dateString) return '';
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { year: 'numeric', month: 'short' });
}

function initializePDFDownload() {
    const downloadButton = document.getElementById('pdf-download');
    if (downloadButton) {
        downloadButton.addEventListener('click', () => {
            window.print(); // Simple PDF generation via browser print
        });
    }
}
EOF

# Create tabs functionality
cat > src/js/tabs.js << 'EOF'
class TabManager {
    constructor() {
        this.initTabs();
    }

    initTabs() {
        const tabButtons = document.querySelectorAll('.tab-button');
        const tabPanes = document.querySelectorAll('.tab-pane');

        tabButtons.forEach(button => {
            button.addEventListener('click', (e) => {
                const targetTab = e.target.getAttribute('data-tab');
                
                // Remove active class from all buttons and panes
                tabButtons.forEach(btn => btn.classList.remove('active'));
                tabPanes.forEach(pane => pane.classList.remove('active'));
                
                // Add active class to clicked button
                e.target.classList.add('active');
                
                // Show corresponding pane
                document.getElementById(`${targetTab}-tab`).classList.add('active');
            });
        });
    }
}

const tabManager = new TabManager();
EOF

# Create animations
cat > src/js/animations.js << 'EOF'
class AnimationManager {
    constructor() {
        this.initAnimations();
    }

    initAnimations() {
        // Add scroll animations
        this.addScrollAnimations();
        
        // Add hover effects for better interactivity
        this.addHoverEffects();
    }

    addScrollAnimations() {
        // Observer for elements entering viewport
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        // Apply to cards and sections
        const animatedElements = document.querySelectorAll('.work-item, .education-item, .project-item, .skill-category, .interest-item, .award-item');
        animatedElements.forEach(el => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(20px)';
            el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(el);
        });
    }

    addHoverEffects() {
        // Add subtle hover effects to make the site feel more interactive
        const hoverables = document.querySelectorAll('a, button, .work-item, .education-item, .project-item');
        hoverables.forEach(el => {
            el.addEventListener('mouseenter', () => {
                el.style.cursor = 'pointer';
            });
        });
    }
}

const animationManager = new AnimationManager();
EOF

# Create main application logic
cat > src/js/main.js << 'EOF'
document.addEventListener('DOMContentLoaded', async function() {
    try {
        const resumeData = await loadResumeData();
        
        // Render all sections
        renderProfile(resumeData.basics);
        renderWorkExperience(resumeData.work);
        renderEducation(resumeData.education);
        renderSkills(resumeData.skills);
        renderProjects(resumeData.projects);
        renderInterests(resumeData.interests);
        renderAwards(resumeData.awards);
        
        // Initialize theme manager
        themeManager.initializeToggle();
        
        // Initialize PDF download
        initializePDFDownload();
        
        // Initialize animations
        animationManager.initAnimations();
        
    } catch (error) {
        console.error('Failed to render resume:', error);
    }
});
EOF

# Create README.md
cat > README.md << 'EOF'
# My Professional Resume Website

A modern, interactive resume website built with vanilla HTML/CSS/JS using JSON data format.

## Features
- ✅ Interactive tabs for different sections
- ✅ Animated swaying flower in header
- ✅ Smooth scroll animations
- ✅ Light/Dark theme toggle
- ✅ PDF export capability
- ✅ Responsive design
- ✅ Fast loading
- ✅ Easy to customize via JSON
- ✅ Hosted on GitHub Pages

## Quick Start

1. Edit `src/resume.json` with your information
2. Serve the site locally:
   ```bash
   npm start