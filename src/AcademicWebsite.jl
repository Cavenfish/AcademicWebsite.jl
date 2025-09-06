"""
AcademicWebsite.jl

A static site template for academics.
"""
module AcademicWebsite

  using TOML

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

  function check_site_proj_file(topdir::String)
    projFile = joinpath(topdir, "Project.toml")

    if isfile(projFile)
      tom = TOML.parsefile(projFile)
      
      if !haskey(tom, "deps")
        tom["deps"] = Dict(
          "Franklin" => "713c75ef-9fc9-4b05-94a9-213340da978e",
          "FranklinUtils" => "dcd8a645-c81d-482f-af4b-568f72f3e16d"
        )
      elseif !haskey(tom["deps"], "Franklin")
        tom["deps"]["Franklin"] = "713c75ef-9fc9-4b05-94a9-213340da978e"
      elseif !haskey(tom["deps"], "FranklinUtils")
        tom["deps"]["FranklinUtils"] = "dcd8a645-c81d-482f-af4b-568f72f3e16d"
      end
    else
      open(projFile, "w") do io
        print(
          io,
          """
          [deps]
          Franklin = "713c75ef-9fc9-4b05-94a9-213340da978e"
          FranklinUtils = "dcd8a645-c81d-482f-af4b-568f72f3e16d"
          """
        )
      end
    end
  end
  
end