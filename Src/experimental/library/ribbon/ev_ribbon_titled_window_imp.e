note
	description: "[
					EV_RIBBON_TITLED_WINDOW's windows implementation
																									]"
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


note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
