indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_TEXT

inherit
	EDITOR_TOKEN

create
	make

feature -- Initialisation

	make(text: STRING) is
		require
			text_not_void: text /= Void
		do
			image := text
		ensure
			image_not_void: image /= Void
		end

feature -- Miscellaneous

	display(d_x: INTEGER; d_y: INTEGER; dc: WEL_DC): INTEGER is
		do
			dc.text_out (d_x, d_y, image)
			Result := d_x + dc.string_width(image)
		end

end -- class EDITOR_TOKEN
