note
	description: "Summary description for EV_RIBBON_TITLED_WINDOW_IMP."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_TITLED_WINDOW_IMP

inherit
	EV_TITLED_WINDOW_IMP
		export
			{EV_RIBBON} on_size
		redefine
			client_y,
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
