import React from 'react';
import { Mail, Phone, MapPin, Globe, Github, Linkedin, ExternalLink } from 'lucide-react';

const Header = ({ basics }) => {
    const { name, label, email, phone, location, profiles, summary, url } = basics;

    return (
        <header className="section" style={{ animationDelay: '0s' }}>
            <div className="card" style={{ border: 'none', background: 'transparent', padding: 0 }}>
                <h1 style={{ fontSize: '3rem', marginBottom: '0.5rem', background: 'linear-gradient(to right, #38bdf8, #818cf8)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>
                    {name}
                </h1>
                <h2 style={{ fontSize: '1.5rem', color: 'var(--text-secondary)', marginBottom: '1.5rem' }}>
                    {label}
                </h2>

                <p style={{ maxWidth: '600px', marginBottom: '2rem', fontSize: '1.1rem', lineHeight: '1.8' }}>
                    {summary}
                </p>

                <div style={{ display: 'flex', flexWrap: 'wrap', gap: '1.5rem', fontSize: '0.95rem' }}>
                    {location && (
                        <div style={{ display: 'flex', items: 'center', gap: '0.5rem', color: 'var(--text-secondary)' }}>
                            <MapPin size={18} />
                            <span>{location.city}, {location.region}</span>
                        </div>
                    )}
                    {email && (
                        <a href={`mailto:${email}`} style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                            <Mail size={18} />
                            <span>{email}</span>
                        </a>
                    )}
                    {url && (
                        <a href={url} target="_blank" rel="noopener noreferrer" style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                            <Globe size={18} />
                            <span>Portfolio</span>
                        </a>
                    )}
                    {profiles.map((profile) => (
                        <a key={profile.network} href={profile.url} target="_blank" rel="noopener noreferrer" style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                            {profile.network.toLowerCase() === 'github' ? <Github size={18} /> :
                                profile.network.toLowerCase() === 'linkedin' ? <Linkedin size={18} /> : <ExternalLink size={18} />}
                            <span>{profile.network}</span>
                        </a>
                    ))}
                </div>
            </div>
        </header>
    );
};

export default Header;
