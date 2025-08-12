"""
AcademicWebsite.jl

A static site template for academics.
"""
module AcademicWebsite

  using Franklin

  export init_site
  export deploy

  include("./init_site.jl")
  include("./deploy.jl")

end