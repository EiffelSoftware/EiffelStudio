indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_CHARACTER

inherit
	EDITOR_TOKEN_TEXT
		redefine
			display
		end

create
	make

feature -- Miscellaneous

	display(d_x: INTEGER; d_y: INTEGER; dc: WEL_DC): INTEGER is
		local
			old_text_color: WEL_COLOR_REF
			old_background_color: WEL_COLOR_REF
		do
				-- Change drawing style here.
			old_text_color := dc.text_color
			old_background_color := dc.background_color
			dc.set_text_color(text_color)
			dc.set_background_color(background_color)

			Result := Precursor(d_x, d_y, dc)

			-- Restore drawing style here.
			dc.set_text_color(old_text_color)
			dc.set_background_color(old_background_color)
		end

feature {NONE} -- Implementation
	
	text_color: WEL_COLOR_REF is
		once
			create Result.make_rgb(0,128,0)
		end

	background_color: WEL_COLOR_REF is
		once
			create Result.make_rgb(196,0,196)
		end

end -- class EDITOR_TOKEN_CHARACTER
