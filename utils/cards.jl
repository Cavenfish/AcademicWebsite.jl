
struct Person{S<:String}
  alt::S
  name::S
  image::S
  title::S
  bio::S
  email::S
end

function get_people(config)
  team   = config["team"]
  people = Person[] 

  for k in keys(team)
    p = Person(
      team[k]["alt"],
      team[k]["name"],
      team[k]["image"],
      team[k]["title"],
      team[k]["bio"],
      team[k]["email"]
    )

    push!(people, p)
  end

  people
end

function add_card(io, obj::Person)
  write(
    io,
    """
    <div class=\"card\">
      <img src=\"$(obj.image)\" alt=\"$(obj.alt)\" style="width:100%">
      <div class="container">
        <h2>$(obj.name)</h2>
        <p class=\"title\">$(obj.title)</p>
        <p>$(obj.bio)</p>
        <p>$(obj.email)</p>
      </div>
    </div>
    """
  )
end

@lx function teamcards()
  team = get_people(CONF)
  io   = IOBuffer()

  for p in team
    add_card(io, p)
    write(io, "\n<br>\n")
  end

  take!(io) |> String |> html
end