indexing
	description: "Tool bar button can show a narrow shape even it's wrap."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_NARROW_BUTTON

inherit
	SD_TOOL_BAR_BUTTON
		redefine
			rectangle
		end
create
	make

feature -- Redefine

	rectangle: EV_RECTANGLE is
			-- Redefine
		do
			Result := Precursor {SD_TOOL_BAR_BUTTON}
			if is_wrap then
				Result.set_height (pixmap.height + tool_bar.padding_width * 2)
				Result.set_width (pixmap.width + tool_bar.padding_width * 2)
			end
		end

end
