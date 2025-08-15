"""
generate the website.
"""
function build(topdir::String; kwargs...)

  topdir = prep_topdir(topdir)

  template_dir = joinpath(@__DIR__, "template")

  for item in readdir(template_dir)
    src = joinpath(template_dir, item)
    dst = joinpath(topdir, item)
    
    @info "Copying over item.\n  $(item)"

    cp(src, dst; force=true)
  end

  css = joinpath(topdir, "_css")
  
  if !isdir(css)
    mkdir(css)
  end

end