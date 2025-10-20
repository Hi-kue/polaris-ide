# Postfix Web

[![NextJs](https://img.shields.io/badge/-NextJs%20-black?style=flat&logo=nextdotjs)](https://nextjs.org/)
[![Tailwind CSS](https://img.shields.io/badge/-Tailwind%20CSS-black?style=flat&logo=tailwindcss&logoColor=38B2AC)](https://tailwindcss.com)
[![TypeScript](https://img.shields.io/badge/-TypeScript-black?style=flat&logo=typescript&logoColor=007ACC)](https://www.typescriptlang.org/)
[![React](https://img.shields.io/badge/-React-black?style=flat&logo=react&logoColor=61DAFB)](https://reactjs.org/)

> [WARNING]
> The site is still currently under development and is not yet complete.
> As updates are made to the codebase, it may also result in the `README`
> also being updated alongside the codebase's internal structure.

This repo contains two primary apps situated within the `apps` folder:

- `apps/deslib`;
- `apps/site`

`deslib` serves as our comprehensive design library built on top of Shadcn components,
providing a unified design system across all other apps that will exist within this
codebase moving forward, while `site` is our main web application that showcases our
work and serves as the primary digital presence for Postfix Studios.

## Getting Started

In order to get stated with the project, clone the repo and install all necessary
dependencies for both apps (or a single application of interst):

```bash
# 1. Clone the repository to your local machine.
git clone <repo-url> .

# 2. Install all necessary dependencies or run the script `scripts/app_install.sh`
cd apps/deslib && pnpm install
cd ../site && pnpm install

# Or the following script `app_install.sh`:
chmod +x scripts/app_install.sh
./app_install.sh [-d "deslib,site"] [--use-pnpm] [--use-npm]

```

## Deployment Structure

Our deployment structure is pretty straightforward, with two (2) sites under a domain
structured like the following:

- **Deslib** will be deployed to the subdomain `deslib.postfix-studios.com`.
- **Site** will be deployed to the main domain `postfix-studios.com`.

Any other domains will be under a subdomain of `postfix-studios.com` unless
there is a reason to have an entirely seperate domain to be used.

## Contributing

Please see our [contributing guidelines](.github/CONTRIBUTING.md) for information on how to
contribute to this project if you are working as an outside collaborator or already are a
part of the team.

## License

This repo is currently `UNLICENSED`.
