# Billora

Responsive React + Vite starter for multi-business invoices, quotations, customer records, payment tracking and downloadable PDF receipts. Uses Supabase Auth + PostgreSQL with Row Level Security. A local demo mode works before credentials are configured.

## Set up cloud mode
1. Create a project at https://supabase.com.
2. Open **SQL Editor** and run `supabase/schema.sql`.
3. Copy the Supabase Project URL and publishable/anon key from Project Settings → API / Connect.
4. Copy `.env.example` to `.env.local`, fill in the two values, and run `npm install` then `npm run dev`.
5. In Supabase Authentication → URL Configuration, add your Vercel domain to Site URL and Redirect URLs. For local testing, add `http://localhost:5173/**`.
6. Create a GitHub repository, upload the project files to its root (not `node_modules`), import the repository into Vercel, choose Vite, set build command `npm run build` and output `dist`.
7. In Vercel Project Settings → Environment Variables, add `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`, then redeploy.

## Included
- Sign-up/sign-in with email and password; Supabase row-level data policies
- Multiple business profiles and customer records
- Invoices and quotations with item lines, tax, discount and balances
- Full/partial payment recording, M-Pesa/cash/bank/card/other payment methods
- Payment receipts and document PDFs; dashboard and responsive mobile layout
- Local demo mode stored in the current browser if Supabase credentials are absent

## Important limitations
M-Pesa is recorded as a payment method only; automatic STK Push / Daraja verification needs a separate secure backend integration. PDF documents are generated client-side. This is a functional starter, not an audited accounting/tax product. Review local tax requirements before relying on it for official records. Never put the Supabase `service_role` key in the frontend.
