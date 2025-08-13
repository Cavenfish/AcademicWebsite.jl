"""
AcademicWebsite.jl

A static site template for academics.
"""
module AcademicWebsite

  using Franklin

  export init_site
  export build

  include("./init_site.jl")
  include("./build.jl")

end