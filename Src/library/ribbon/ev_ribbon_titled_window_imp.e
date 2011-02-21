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
			on_paint,
			interface
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
		do
			if attached ribbon as l_ribbon and then l_ribbon.exists then
				Result := l_ribbon.height
			end
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- <Precursor>
		do
			on_size ({WEL_WINDOW_CONSTANTS}.Size_restored, width, height)
			Precursor {EV_TITLED_WINDOW_IMP}(paint_dc, invalid_rect)
		end

feature -- Access

	ribbon: detachable EV_RIBBON
			-- Ribbon if any.
		do
			if attached interface as l_interface then
				Result := l_interface.ribbon
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_RIBBON_TITLED_WINDOW note option: stable attribute end


end
