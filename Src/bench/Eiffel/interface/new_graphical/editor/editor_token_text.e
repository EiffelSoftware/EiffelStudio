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
			text_valid: text /= Void and then text.count > 0
		do
			image := text
			length := text.count
		ensure
			image_not_void: image /= Void
			length_positive: length > 0
		end

feature -- Miscellaneous

	display(d_x: INTEGER; d_y: INTEGER; dc: WEL_DC): INTEGER is
		do
			dc.text_out (d_x, d_y, image)
			Result := d_x + dc.string_width(image)
		end

end -- class EDITOR_TOKEN
