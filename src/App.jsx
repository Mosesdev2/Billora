import { useState } from "react";

export default function App() {
  const [activeTab, setActiveTab] = useState("Dashboard");

  const tabs = ["Dashboard", "Invoices", "Quotations", "Customers", "Settings"];

  return (
    <div className="app-shell">
      <aside className="sidebar">
        <div className="brand">
          <span className="brand-mark">B</span>
          <span>billora<span className="brand-dot">.</span></span>
        </div>

        <p className="nav-label">WORKSPACE</p>

        <nav>
          {tabs.map((tab) => (
            <button
              key={tab}
              className={`nav-item ${activeTab === tab ? "active" : ""}`}
              onClick={() => setActiveTab(tab)}
            >
              <span>{{
                Dashboard: "▦",
                Invoices: "▤",
                Quotations: "▧",
                Customers: "♙",
                Settings: "⚙"
              }[tab]}</span>
              {tab}
            </button>
          ))}
        </nav>

        <div className="sidebar-bottom">
          <span className="status-dot" />
          Your workspace is ready
        </div>
      </aside>

      <main className="main-content">
        <header className="topbar">
          <div>
            <p className="eyebrow">BILLORA WORKSPACE</p>
            <h1>{activeTab}</h1>
          </div>
          <div className="profile-badge">B</div>
        </header>

        {activeTab === "Dashboard" ? (
          <>
            <section className="welcome">
              <div>
                <p className="eyebrow">YOUR BUSINESS, SIMPLIFIED</p>
                <h2>Clarity in every transaction.</h2>
                <p>Manage invoices, quotations and customers in one place.</p>
              </div>
              <span className="welcome-icon">↗</span>
            </section>

            <section className="stats-grid">
              <article className="stat-card">
                <span>Total invoices</span>
                <strong>0</strong>
                <small>All invoices created</small>
              </article>
              <article className="stat-card">
                <span>Outstanding</span>
                <strong>KSh 0.00</strong>
                <small>Awaiting payment</small>
              </article>
              <article className="stat-card">
                <span>Collected</span>
                <strong>KSh 0.00</strong>
                <small>Payments received</small>
              </article>
            </section>

            <section className="content-card">
              <div className="section-heading">
                <div>
                  <h3>Get started</h3>
                  <p>Your business documents start here.</p>
                </div>
                <span className="live-tag">WELCOME</span>
              </div>

              <div className="empty-state">
                <div className="empty-icon">▤</div>
                <h3>Your workspace is ready</h3>
                <p>
                  Create your first invoice or quotation to start
                  organising your business transactions.
                </p>
                <button
                  className="primary-button"
                  onClick={() => setActiveTab("Invoices")}
                >
                  Explore invoices <span>→</span>
                </button>
              </div>
            </section>
          </>
        ) : (
          <section className="content-card page-placeholder">
            <div className="empty-icon">✳</div>
            <h2>{activeTab}</h2>
            <p>
              This section is part of your Billora workspace.
              Document management and data storage will be added next.
            </p>
            <button
              className="secondary-button"
              onClick={() => setActiveTab("Dashboard")}
            >
              ← Back to dashboard
            </button>
          </section>
        )}

        <footer>Billora © 2026 · Built for better business.</footer>
      </main>
    </div>
  );
}
