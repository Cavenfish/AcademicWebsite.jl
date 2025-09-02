"""
initialize the website template.
"""
function init_site(topdir::String)

  topdir = prep_topdir(topdir)

  if !isdir(topdir)
    @info "Making new directory at:\n  $(topdir)"
    mkdir(topdir)
  end

  user_items_dir = joinpath(@__DIR__, "user_items")

  for item in readdir(user_items_dir)
    src = joinpath(user_items_dir, item)
    dst = joinpath(topdir, item)
    
    @info "Copying over item.\n  $(item)"

    cp(src, dst; force=true)
    chmod(dst, 0o644)
  end

  template_dir = joinpath(@__DIR__, "template")

  for item in readdir(template_dir)
    src = joinpath(template_dir, item)
    dst = joinpath(topdir, item)
    
    @info "Copying over item.\n  $(item)"

    cp(src, dst; force=true)
    chmod(dst, 0o644)
  end

  pages = joinpath(topdir, "pages")

  if !isdir(pages)
    mkdir(pages)
  end

end