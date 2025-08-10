
function prep_items(toml)
  items = [toml[k] for k in keys(toml)]

  sort(items, by=(e -> e["date"]), rev=true)
end

@lx function showcase(ref; byyear=false)

  file = joinpath(ROOT, "_assets", "items", ref)

  items = TOML.parsefile(file) |> prep_items

  isempty(items) && return ""

  io      = IOBuffer()
  curyear = year(1e16)

  write(
    io, 
    """
    <div class="showcase">
      <ul>
    """
  )

  for item in items
    if byyear && year(item["date"]) < curyear
      curyear = year(item["date"])
      write(
        io,
        """
        </ul>
        <div class="year-heading">
          <h2>$(curyear)</h2>
        </div>
        <ul>
        """ 
      )
    end

    title   = item["title"]
    date    = item["date"]
    authors = haskey(item, "authors") ? item["authors"] : ""
    journal = haskey(item, "journal") ? item["journal"] : ""
    venue   = haskey(item, "venue") ? item["venue"] : ""

    if haskey(item, "url")
      write(
        io,
        """
        <li>
          <div class="showcase-title">
            <a href="$(item["url"])">$(title)</a>
          </div>
        """
      )
    else
      write(
        io,
        """
        <li>
          <div class="showcase-title">
            $(title)
          </div>
        """
      )
    end

    write(
      io,
      """
        <div class="showcase-body">
          $(authors)
          <br>
          <i>
            $(venue)
            $(journal)
          </i>
        </div>
      </li>
      """
    )
  end

  write(
    io, 
    """
      </ul>
    </div>
    """
  )

  take!(io) |> String |> html
end