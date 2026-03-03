---
title: Features - Nudox
---

<section id="hero">
  <h1>
    <span>Encyclopedia</span>
    for code
  </h1>
  <div class="card">
    <h2>
      Make AI code generation reliable by grounding agents in compiler-verified, versioned source-of-truth knowledge.
    </h2>
  </div>
</section>

<section>
  <div class="aqua-window">
    <strong>Compiler-Truth Graph</strong>
    <pre><code><span class="comment">// Query accurate symbol existence</span>
<span class="keyword">const</span> <span class="var">symbol</span> <span class="op">=</span> <span class="keyword">await</span> <span class="obj">nudox</span>.<span class="func">query</span>(<span class="str">"MyComponent"</span>, <span class="str">"v2.1.0"</span>);

<span class="comment">// Returns version-specific API signature</span>
<span class="var">symbol</span>.<span class="func">signature</span> <span  
class="comment">// (props: MyProps) => JSX.Element</span>

<span class="comment">// Track lineage and changes</span>
<span class="var">symbol</span>.<span class="func">diff</span>(<span  
class="str">“v2.0.0”</span>) <span class="comment">// { changed:
[“props.variant”] }</span></code></pre>

  </div>
</section>
<section id="features-grid">
  <div class="card feature-card">
    <h2>Symbol Existence</h2>
    <hr aria-hidden="true">
    <p>Know exactly what functions, types, and modules exist in any version of the library. Eliminate hallucinations of non-existent APIs.</p>
  </div>
  <div class="card feature-card">
    <h2>Version Awareness</h2>
    <hr aria-hidden="true">
    <p>Agents code against specific versions, avoiding hallucinations of deprecated or future APIs. Supports both legacy systems and bleeding-edge libraries.</p>
  </div>
  <div class="card feature-card">
    <h2>Lineage & Impact</h2>
    <hr aria-hidden="true">
    <p>Understand how symbols change over time and the impact of those changes across the codebase. Enable safer refactors with queryable lineage.</p>
  </div>
</section>
<section>
  <div class="card card-centered">
    <h2>How It Works</h2>
    <hr aria-hidden="true">
    <ol class="steps-list">
      <li class="step-item">
        <strong class="step-number">1.</strong>
        <div>
          <strong>Scan / Ingest</strong><br>
          <span class="step-description">We scan public or private repositories (including enterprise private installs).</span>
        </div>
      </li>
      <li class="step-item">
        <strong class="step-number">2.</strong>
        <div>
          <strong>Compile / Extract</strong><br>
          <span class="step-description">We derive structured representation of symbols and capture relationships (calls, members, visibility).</span>
        </div>
      </li>
      <li class="step-item">
        <strong class="step-number">3.</strong>
        <div>
          <strong>Graph + Query</strong><br>
          <span class="step-description">We store a versioned graph that agents can query via MCP to get compiler-truth facts.</span>
        </div>
      </li>
      <li class="step-item">
        <strong class="step-number">4.</strong>
        <div>
          <strong>Feedback</strong><br>
          <span class="step-description">We track what symbols are queried repeatedly and mismatch points to provide analytics.</span>
        </div>
      </li>
    </ol>
  </div>
</section>
