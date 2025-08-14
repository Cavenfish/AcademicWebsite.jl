"""
initialize the user controled items.
"""
function init_site(topdir::String)

  if topdir == "." || topdir == "./"
    topdir = pwd()
  elseif topdir[1] == '.' && topdir[2] == '/'
    tmp = replace(topdir, "./" => "")
    topdir = joinpath(pwd(), tmp)
  else
    topdir = joinpath(pwd(), topdir)
  end

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
  end

  joinpath(topdir, "pages") |> mkdir

end