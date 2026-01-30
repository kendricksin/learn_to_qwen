import React from 'react';
import { GraduationCap, Calendar } from 'lucide-react';

const Education = ({ education }) => {
    return (
        <section className="section" style={{ animationDelay: '0.4s' }}>
            <h3 className="section-title">
                <GraduationCap size={24} />
                Education
            </h3>
            {education.map((edu, index) => (
                <div key={index} className="card">
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'baseline', marginBottom: '0.5rem' }}>
                        <h4 style={{ fontSize: '1.25rem' }}>{edu.institution}</h4>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', color: 'var(--text-secondary)', fontSize: '0.9rem' }}>
                            <Calendar size={14} />
                            <span>{edu.startDate} — {edu.endDate}</span>
                        </div>
                    </div>
                    <p style={{ color: 'var(--accent-color)', marginBottom: '0.5rem' }}>
                        {edu.studyType} in {edu.area}
                    </p>
                    {edu.score && (
                        <p style={{ fontSize: '0.9rem', color: 'var(--text-secondary)' }}>
                            GPA: {edu.score}
                        </p>
                    )}
                    {edu.courses && (
                        <div style={{ marginTop: '1rem' }}>
                            {edu.courses.map((course, i) => (
                                <span key={i} className="pill" style={{ opacity: 0.8, fontSize: '0.8rem' }}>{course}</span>
                            ))}
                        </div>
                    )}
                </div>
            ))}
        </section>
    );
};

export default Education;
