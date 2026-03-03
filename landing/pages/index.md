---
title: NuDox - Truth is timeless
---

<section id="hero">
  <h1>
    <span>Truth</span>
    for a truthless age
  </h1>
  <div class="card">
    <h2>
      We build an intermediate representation of every codebase, at every point in time,
      to allow users and agents alike to intelligently query with facts, not summaries
    </h2>
    <hr aria-hidden="true">
    <div>
      <button type="button" class="primary" aria-label="Try NuDox for free">
        <span>Try For Free</span>
      </button>
      <a href="#dashboard" role="button" aria-label="Go to dashboard">
        <span>Dashboard</span>
      </a>
    </div>
  </div>
</section>
<section id="query-interface">
  <div class="aqua-window" id="code-window">
    <strong>NuDox Query Engine</strong>
    <pre><code><span class="comment">// Query the source of truth</span>
<span class="keyword">const</span> <span class="var">schema</span> <span class="op">=</span> <span class="keyword">await</span> <span class="obj">nudox</span>
  .<span class="func">library</span>(<span class="str">"react"</span>)
  .<span class="func">version</span>(<span class="str">"18.2.0"</span>)
  .<span class="func">function</span>(<span class="str">"useState"</span>)
  .<span class="func">get</span>();
<span class="comment">// Returns compiler-verified types</span>
<span class="var">schema</span>.<span class="func">params</span> <span class="comment">// [initialState: S | (() → S)]</span>
<span class="var">schema</span>.<span class="func">returns</span> <span class="comment">// [S, Dispatch SetStateAction&lt;S&gt;&gt;]</span></code></pre>
   </div>
    <!-- These are my stickies, any dl within this id block is considered a sticky btw -->
    <dl>
      <dt>The End of Hallucinations</dt>
      <dd>
        Eliminate hallucinated APls and unreliable documentation. NuDox gives Al agents compiler-accurate knowledge of
        ANY codebase.
      </dd>
    </dl>
</section>
