# CheckGong starter
Early-stage Next.js visual scaffold and PostgreSQL schema. NOT a complete production system.

## Run locally
1. Install Node.js 20+.
2. Run `npm install` and `npm run dev`.
3. Open http://localhost:3000.

## Database
Create a Supabase project, then run `supabase/schema.sql` in its SQL editor. The SQL deliberately denies most client access. Do not use it as a complete API until server-side authorization, validation, complaint review, private evidence storage, admin MFA, abuse prevention, privacy policy, retention, and security tests are implemented.

## Deploy
Push project to a private Git repository and import into Vercel. Configure environment variables securely; do not commit keys. Connect a purchased domain via Vercel DNS instructions. No domain or backend is provisioned by this package.
