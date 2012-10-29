def full_title(name)
  base_title = "Rails Adventure"
  if name.empty?
  	base_title
  else
  	"#{base_title} | #{name}"
  end
end