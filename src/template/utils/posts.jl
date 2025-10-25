function prep_ref(file)
  if occursin(".md", file)
    return split(file, '.')[1]
  end

  file
end

@lx function post(title, blurb, file)
  ref = prep_ref(file)
  
  """
  <a href="$(ref)" class="post-link">
    <div class="post">
      <div class="title">
        <h1>$(title)</h1>
      </div>
      <div class="blurb">
        <p>$(blurb)</p>
      </div>
    </div>
  </a>
  """ |> html
end