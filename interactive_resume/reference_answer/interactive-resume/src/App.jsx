import { useState } from 'react'
import Header from './components/Header'
import Experience from './components/Experience'
import Education from './components/Education'
import Skills from './components/Skills'
import resumeData from './data/resume.json'

function App() {
  const [count, setCount] = useState(0)

  return (
    <div className="container">
      <Header basics={resumeData.basics} />
      <Experience work={resumeData.work} />
      <Education education={resumeData.education} />
      <Skills skills={resumeData.skills} />

      <footer style={{ textAlign: 'center', marginTop: '4rem', paddingBottom: '2rem', color: 'var(--text-secondary)', fontSize: '0.9rem' }}>
        <p>Built with React & Vite. Designed by AI.</p>
        <p>© {new Date().getFullYear()} {resumeData.basics.name}</p>
      </footer>
    </div>
  )
}

export default App
