---
title: "Projects"
layout: "page"
description: "My projects"
---

{{< rawhtml >}}
<style>
.projects-section {
    margin-top: 40px;
    margin-bottom: 60px;
}

.section-title {
    font-size: 1.5em;
    font-weight: 600;
    color: #333;
    margin-bottom: 30px;
    padding-bottom: 10px;
    border-bottom: 2px solid #0085a1;
}

.project-card {
    display: flex;
    gap: 30px;
    margin-bottom: 40px;
    padding: 30px;
    background: #fff;
    border-radius: 8px;
    border: 1px solid #eaeaea;
    transition: all 0.3s ease;
}

.project-card:hover {
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    border-color: #0085a1;
    transform: translateY(-2px);
}

.project-icon {
    flex-shrink: 0;
    width: 100px;
    height: 100px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 48px;
    color: white;
    font-weight: bold;
}

.project-content {
    flex: 1;
}

.project-title {
    font-size: 1.8em;
    font-weight: 600;
    color: #333;
    margin-bottom: 10px;
}

.project-title a {
    color: #333;
    text-decoration: none;
}

.project-title a:hover {
    color: #0085a1;
}

.project-description {
    font-size: 1.05em;
    color: #666;
    line-height: 1.6;
    margin-bottom: 15px;
}

.project-tech-stack {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
    margin-bottom: 15px;
}

.tech-tag {
    padding: 4px 12px;
    background: #f0f0f0;
    border-radius: 15px;
    font-size: 0.85em;
    color: #555;
    font-weight: 500;
}

.project-links {
    display: flex;
    gap: 15px;
}

.project-link {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    padding: 8px 20px;
    background: #0085a1;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    font-size: 0.95em;
    font-weight: 500;
    transition: all 0.3s ease;
}

.project-link:hover {
    background: #006d82;
    color: white;
    text-decoration: none;
}

.project-link.secondary {
    background: #555;
    border: 2px solid #555;
    color: white;
}

.project-link.secondary:hover {
    background: #333;
    border-color: #333;
    color: white;
}

.coming-soon-card {
    padding: 40px;
    background: #f9f9f9;
    border-radius: 8px;
    border: 2px dashed #ddd;
    text-align: center;
    color: #888;
    margin-bottom: 30px;
}

@media (max-width: 768px) {
    .project-card {
        flex-direction: column;
    }

    .project-icon {
        width: 80px;
        height: 80px;
        font-size: 36px;
    }

    .project-title {
        font-size: 1.4em;
    }
}
</style>

<div class="projects-section">

    <!-- Personal Projects -->
    <div class="section-title">🚀 Personal Projects</div>

    <!-- SUSTech C++ Project -->
    <div class="project-card">
        <div class="project-icon">🔧</div>
        <div class="project-content">
            <div class="project-title">
                <a href="https://github.com/BrightonXX/SUSTech-CPP-Project">SUSTech C++ Project</a>
            </div>
            <div class="project-description">
                My Projects for SUSTech CS219 Advanced Programming by Prof. Yu, 2025 Spring.
            </div>
            <div class="project-tech-stack">
                <span class="tech-tag">C++</span>
                <span class="tech-tag">OOP</span>
                <span class="tech-tag">STL</span>
                <span class="tech-tag">Design Patterns</span>
            </div>
            <div class="project-links">
                <a href="https://github.com/BrightonXX/SUSTech-CPP-Project" class="project-link secondary">⭐ GitHub</a>
            </div>
        </div>
    </div>

    <!-- Coming Soon -->
    <div class="coming-soon-card">
        <div style="font-size: 1.2em; margin-bottom: 10px;">🚧 More Projects Coming Soon...</div>
        <div>I'm working on some exciting projects. Stay tuned!</div>
    </div>

    <!-- Research Projects -->
    <div class="section-title">🔬 Research & Academic</div>

    <div class="coming-soon-card">
        <div style="font-size: 1.2em; margin-bottom: 10px;">📚 Research Projects</div>
        <div>VLM, NLP, and other research work will be shared here soon.</div>
    </div>

    <!-- Open Source -->
    <div class="section-title">🌟 Open Source Contributions</div>

    <div class="coming-soon-card">
        <div style="font-size: 1.2em; margin-bottom: 10px;">🤝 Contributions</div>
        <div>My open source contributions and collaborations will be listed here.</div>
    </div>

</div>
{{< /rawhtml >}}
