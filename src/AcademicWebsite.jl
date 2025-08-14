"""
AcademicWebsite.jl

A static site template for academics.
"""
module AcademicWebsite

  export init_site
  export build

  include("./init_site.jl")
  include("./build.jl")

end