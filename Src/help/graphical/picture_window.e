indexing
	description: "Window for displaying pictures."
	author: "Vincent Brendel"

class
	PICTURE_WINDOW

inherit
	EV_WINDOW

creation
	make_empty

feature -- Initialization

	make_empty(par:EV_WINDOW) is
			-- Initialize
		local
			v: EV_VERTICAL_BOX
		do
			make(par)
			create v.make(Current)
			create img_area.make(v)
			create caption_area.make(v)
			set_size(200,200)
			set_title("Picture")
			show
		end

	set_picture(name, caption:STRING) is
		do
			create pixmap.make_from_file(name)
			img_area.set_pixmap(pixmap)
			caption_area.set_text(caption)
		end

	caption_area: EV_LABEL

	img_area: EV_DRAWING_AREA

	pixmap: EV_PIXMAP

end -- class PICTURE_WINDOW
