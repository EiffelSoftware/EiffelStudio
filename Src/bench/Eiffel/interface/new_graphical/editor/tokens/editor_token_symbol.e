indexing
	description	: "Token that describe a symbol ( [, {, ...)"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_SYMBOL

inherit
	EDITOR_TOKEN_TEXT
		redefine
			display
		end

create
	make

feature -- Miscellaneous

	display(d_x: INTEGER; d_y: INTEGER; dc: WEL_MEMORY_DC): INTEGER is
		local
			old_color: WEL_COLOR_REF
		do
				-- Change drawing style here.
			old_color := dc.text_color
			dc.set_text_color(text_color)

			Result := Precursor(d_x, d_y, dc)

			-- Restore drawing style here.
			dc.set_text_color(old_color)
		end

feature {NONE} -- Implementation
	
	text_color: WEL_COLOR_REF is
		once
			create Result.make_rgb(196,0,0)
		end

end -- class EDITOR_SYMBOL
