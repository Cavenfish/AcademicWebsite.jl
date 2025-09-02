"""
AcademicWebsite.jl

A static site template for academics.
"""
module AcademicWebsite

  export init_site
  export update_site

  include("./init_site.jl")
  include("./update.jl")

  function prep_topdir(topdir::String)
    if topdir == "." || topdir == "./"
      ret = pwd()
    elseif topdir[1] == '.' && topdir[2] == '/'
      tmp = replace(topdir, "./" => "")
      ret = joinpath(pwd(), tmp)
    else
      ret = joinpath(pwd(), topdir)
    end
    ret
  end

  function restore_permissions(topdir::String)
    if isfile(topdir)
      chmod(topdir, 0o644)
      return
    end
    
    for (root, dirs, files) in walkdir(topdir)
      map(e -> chmod(joinpath(root, e), 0o644), files)
    end
  end

end