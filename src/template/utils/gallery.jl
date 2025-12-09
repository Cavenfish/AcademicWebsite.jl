struct GalleryItem{S<:String}
  alt::S
  name::S
  image::S
  description::S
end

function add_gallery_item(io, obj::GalleryItem)
  write(
    io,
    """
    <div class="gallery">
      <div class="gallery-img">
        <img src="$(obj.image)" alt="$(obj.alt)">
      </div>
      <div class="gallery-info">
        <h2>$(obj.name)</h2>
        <p>$(obj.description)</p>
      </div>
    </div>
    """
  )
end

function parse_gallery_item(item)


  obj
end

@lx function makeGallery(img_dir)
  io  = IOBuffer()

  write(io, """<div class="gallery-wrapper">""")

  for img in readdir(img_dir)
    dir = if img_dir[1] == '_'
      '/' * img_dir[2:end]
    else
      img_dir
    end

    write(
      io,
      """
      <div class="gallery">
        <div class="gallery-img">
          <img src="$(dir)/$(img)">
        </div>
      </div>
      """
    )
  end

  write(io, "</div>")

  take!(io) |> String |> html
end
