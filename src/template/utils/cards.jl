
struct Person{S<:String}
  alt::S
  name::S
  image::S
  title::S
  bio::S
  email::S
end

function get_person(config, key)
  team   = config["team"]

  Person(
    team[key]["alt"],
    team[key]["name"],
    team[key]["image"],
    team[key]["title"],
    team[key]["bio"],
    team[key]["email"]
  )
end

function get_people(config)
  team   = config["team"]
  order  = team["order"]
  people = Person[]
  
  for k in order
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
    <div class="card">
      <div class="card-img">
        <img src="$(obj.image)" alt="$(obj.alt)">
      </div>
      <div class="card-info">
        <h2>$(obj.name)</h2>
        <p class="title">$(obj.title)</p>
        <p>$(obj.bio)</p>
        <a href="mailto:$(obj.email)">
          <i class="fa fa-solid fa-envelope" aria-hidden="true"></i>
        </a>
      </div>
    </div>
    """
  )
end

@lx function teamcards()
  team = get_people(CONF)
  io   = IOBuffer()

  write(io, "<br>")
  for p in team
    add_card(io, p)
    write(io, "<br>")
  end

  take!(io) |> String |> html
end

@lx function add_card(key)
  obj = get_person(CONF, key)
  io  = IOBuffer()

  add_card(io, obj)

  take!(io) |> String |> html
end
