"""
AcademicWebsite.jl

A static site template for academics.
"""
module AcademicWebsite

  export init_site
  export update_site

  include("./init_site.jl")
  include("./update.jl")

  function prep_topdir(topdir)
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

end