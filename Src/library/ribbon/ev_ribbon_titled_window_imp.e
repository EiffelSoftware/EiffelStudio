note
	description: "Summary description for EV_RIBBON_TITLED_WINDOW_IMP."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_TITLED_WINDOW_IMP

inherit
	EV_TITLED_WINDOW_IMP
		redefine
			client_y,
			on_paint
		end

create
	make

feature {NONE} -- Implementation

	client_y: INTEGER
			-- <Precursor>
		do
			Result := Precursor {EV_TITLED_WINDOW_IMP}
			Result := Result + ribbon_height
		end

	ribbon_height: INTEGER
			-- Height of ribbon tool bar
		local
			l_height: INTEGER
		do
			{EV_RIBBON}.get_height ($l_height)
			Result := l_height
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- <Precursor>
		do
			on_size ({WEL_WINDOW_CONSTANTS}.Size_restored, width, height)
			Precursor {EV_TITLED_WINDOW_IMP}(paint_dc, invalid_rect)
		end
end
