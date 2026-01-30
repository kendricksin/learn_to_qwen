import React from 'react';
import { Briefcase, Calendar } from 'lucide-react';

const Experience = ({ work }) => {
    return (
        <section className="section" style={{ animationDelay: '0.2s' }}>
            <h3 className="section-title">
                <Briefcase size={24} />
                Experience
            </h3>
            {work.map((job, index) => (
                <div key={index} className="card">
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'baseline', marginBottom: '0.5rem', flexWrap: 'wrap', gap: '0.5rem' }}>
                        <h4 style={{ fontSize: '1.25rem', color: 'var(--text-primary)' }}>
                            {job.position} <span style={{ color: 'var(--accent-color)' }}>@ {job.name}</span>
                        </h4>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', color: 'var(--text-secondary)', fontSize: '0.9rem' }}>
                            <Calendar size={14} />
                            <span>{job.startDate} — {job.endDate}</span>
                        </div>
                    </div>
                    <p style={{ color: 'var(--text-secondary)', marginBottom: '1rem', fontStyle: 'italic' }}>
                        {job.summary}
                    </p>
                    <ul style={{ listStyleType: 'none', padding: 0 }}>
                        {job.highlights.map((highlight, i) => (
                            <li key={i} style={{ marginBottom: '0.5rem', paddingLeft: '1.5rem', position: 'relative' }}>
                                <span style={{ position: 'absolute', left: 0, color: 'var(--accent-color)' }}>▹</span>
                                {highlight}
                            </li>
                        ))}
                    </ul>
                </div>
            ))}
        </section>
    );
};

export default Experience;
