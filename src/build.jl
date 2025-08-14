"""
generate the website.
"""
function build(topdir::String; kwargs...)

  if topdir == "." || topdir == "./"
    topdir = pwd()
  elseif topdir[1] == '.' && topdir[2] == '/'
    tmp = replace(topdir, "./" => "")
    topdir = joinpath(pwd(), tmp)
  else
    topdir = joinpath(pwd(), topdir)
  end

  template_dir = joinpath(@__DIR__, "template")

  for item in readdir(template_dir)
    src = joinpath(template_dir, item)
    dst = joinpath(topdir, item)
    
    @info "Copying over item.\n  $(tmp)"

    cp(src, dst; force=true)
  end

  joinpath(topdir, "_css") |> mkdir
  
end