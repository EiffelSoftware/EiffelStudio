indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
			dc.set_text_color(symbol_color)

			Result := Precursor(d_x, d_y, dc)

			-- Restore drawing style here.
			dc.set_text_color(old_color)
		end

feature {NONE} -- Implementation
	
	symbol_color: WEL_COLOR_REF is
		once
			create Result.make_rgb(196,0,0)
		end

end -- class EDITOR_SYMBOL
