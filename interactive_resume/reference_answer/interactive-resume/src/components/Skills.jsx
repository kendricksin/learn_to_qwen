import React from 'react';
import { Cpu } from 'lucide-react';

const Skills = ({ skills }) => {
    return (
        <section className="section" style={{ animationDelay: '0.6s' }}>
            <h3 className="section-title">
                <Cpu size={24} />
                Skills
            </h3>
            <div className="card">
                {skills.map((skillGroup, index) => (
                    <div key={index} style={{ marginBottom: index === skills.length - 1 ? 0 : '1.5rem' }}>
                        <h4 style={{ marginBottom: '1rem', color: 'var(--text-primary)', fontSize: '1.1rem' }}>
                            {skillGroup.name}
                        </h4>
                        <div style={{ display: 'flex', flexWrap: 'wrap' }}>
                            {skillGroup.keywords.map((keyword, i) => (
                                <span key={i} className="pill">
                                    {keyword}
                                </span>
                            ))}
                        </div>
                    </div>
                ))}
            </div>
        </section>
    );
};

export default Skills;
