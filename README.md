Monorepo

# Goals

- No need for explicit version management (all packages always use the latest)
- Simple, single command dependency installation and builds
- Still properly model things as separate packages so things could be broken out and versioned if desired
- Able to share dependencies (e.g. typescript) across all packages so everything is on the same version

# Do stuff

```
cd workspace-b
yarn start # Installs, builds, and runs
```

# Adding a local package reference

Say you want to have workspace-b reference workspace-c

1. Add `workspace-c` to `references` in `workspace-b/tsconfig.json`
1. Add `workspace-c: 1.0.0` as a dependency in `workspace-b/package.json`

And you're done - building and running should work as they already do

# Monorepo testing

`yarn clean` at the root to rip out `node_modules` and `dist` directories to start fresh

# Open questions

- Lambdas should package the minimal amount - can serverless be configured to follow symlinks when packaging? Might need
  some sort of smarter bundler if not
- Similar case for services - no need to push all code in the monorepo if we don't need to
- Automatic deployments - changing a dependency won't automatically deploy all services that use it if those services
  themselves never changed. Probably a rare case that this occurs. I don't think auto-deploying all users of a given
  dependency on every change is desirable even if you could do that.
