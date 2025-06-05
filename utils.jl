using TOML, FranklinUtils

const ROOT = Franklin.FOLDER_PATH[]
const CONF = TOML.parsefile("./config.toml")

include("./utils/cover.jl")
include("./utils/sidebar.jl")
include("./utils/showcase.jl")

function hfun_navigation()
  io  = IOBuffer()
  dir = joinpath(ROOT, "pages")

  for i in walkdir(dir)
    if !(isempty(i[3]))
      for page in i[3]
        tmp = split(page, '.')[1]
        ref = joinpath("pages", tmp)
        nam = pagevar(ref, "name")
        write(io, "<li><a href=\"/$(ref)\">$(nam)</a></li>\n")
      end
    end
  end

  take!(io) |> String
end

@lx function br(; n=1)
  repeat("<br>", n)  |> html
end