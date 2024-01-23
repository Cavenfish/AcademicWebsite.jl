using TOML, FranklinUtils

const ROOT = Franklin.FOLDER_PATH[]

@lx function br(; n=1)
    repeat("<br>", n)  |> html
end

@lx function coverButton(; ref="", txt="")
    html("""<a href="$(ref)" class="cover-button">$(txt)</a>""")
end

@env function coverBody(md; class="")
    html("""
    <div class="cover-body">""") * md * html("""
    </div>
    """)
end

@lx function coverLinks(; id="")
    io = IOBuffer()
    links = globvar("links")

    write(io, "<ul>")
    for link in links
        write(io, """
        <li>
        <a href="$(link[1])" target=_blank>
          <i class="$(link[2]) fa-2x" aria-hidden="true"></i>
        </a></li>
        """)
    end
    write(io, "</ul>")

    take!(io) |> String |> html
end