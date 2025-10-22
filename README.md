### _This project is still in the development phase_

Please see the roadmap for an indication of how far along development is for the current state.

# AcademicWebsite.jl

This project aims to be a static site template for [Franklin.jl](https://github.com/tlienart/Franklin.jl), which hopefully can one day be added to [FranklinTemplates.jl](https://github.com/tlienart/FranklinTemplates.jl). The project will hopefully also become a package in the Julia general registry, so that existing websites using this template can easily update their sites as the template updates.

The focus for this template is websites for academics, and it was heavily inspired by the [AcademicPages](https://github.com/academicpages/academicpages.github.io) template.

## How to Setup a Website

First add the package from GitHub using Julia Pkg manager.

```
pkg> add https://github.com/Cavenfish/AcademicWebsite.jl.git
```

The use to package to scaffold your website

```julia
using AcademicWebsite

init_site("./site_dir")
```

If you use GitHub to deploy your website, you can use this
GitHub action to compile the SASS and run some JS code before
deploying your site. For the action below to work you need to
make sure the directory you initialize you site in is in the 
root of the GitHub repo.

```yaml
name: Deploy

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Install Julia
        uses: julia-actions/setup-julia@latest
      - name: Build Package
        uses: julia-actions/julia-buildpkg@v1
      - name: Setup Node
        uses: actions/setup-node@v4
        with:
          node-version: 18
      - name: Run JS Code
        run: |
          mkdir _css
          npm install
          node ./utils/js/compile_sass.js
          node ./utils/js/generate_jdenticons.js
      - name: Build Franklin Site
        shell: julia --project=./ {0}
        run: |
          using Pkg
          Pkg.instantiate()
          using Franklin
          optimize(minify=false, prerender=false)
      - name: Build and Deploy
        uses: JamesIves/github-pages-deploy-action@releases/v3
        with:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          BRANCH: gh-pages
          FOLDER: ./__site
```

## Updating a Website

Unlike other website templates you can update an existing 
website with `AcademicWebsite.jl`. 

```julia
using AcademicWebsite

update_site("./site/dir")
```

This will only copy over template files, leaving your personal
changes to files like `config.toml` unchanged. This isn't a 
perfect system, but it at least gives some amount of 
ability to update an existing website. One main flaw is that
updating does not delete stale files yet, so if unused files
might build-up in your site directory.

**Warning**: This package is still not very stable so updating
to furture version may cause your site to break.

## Local Build
**Requires npm and nodejs**

After running the `init_site` function, if needed enter the 
site directory, then run the following.

```
npm install
mkdir _css
node utils/js/compile_sass.js
node utils/js/generate_jdenticons.js
```

After that you can serve the site with `Franklin`.

```julia
using Pkg
Pkg.activate("./")
Pkg.instantiate()

using Franklin

serve()
```

## To Do

- [ ] Make everything prettier (subjective but still important)
- [ ] Add more cover styles
- [ ] Add color themes (like cover style but for site colors)
- [ ] Refactor sass for better organization
- [ ] Make news feed
- [ ] Add RSS for blog


## Credits

The example CV was taken from this Overleaf [template](https://www.overleaf.com/latex/templates/a-customised-curve-cv/mvmbhkwsnmwv).