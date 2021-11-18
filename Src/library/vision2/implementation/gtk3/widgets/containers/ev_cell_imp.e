note
	description:
		"Eiffel Vision cell, GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CELL_IMP

inherit
	EV_CELL_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			replace,
			make
		end

	EV_DOCKABLE_TARGET_IMP
		redefine
			interface
		end

create
	make

feature -- initialization

	old_make (an_interface: attached like interface)
			-- Connect interface and initialize `c_object'.
		do
			assign_interface (an_interface)
		end

	make
		do
			if c_object = default_pointer then
					-- Only set c_object if not already set by a descendent.
				set_c_object ({GTK}.gtk_event_box_new)
			end
			Precursor
		end

feature -- Access

	has (v: like item): BOOLEAN
			-- Does `Current' include `v'?
		do
			Result := not is_destroyed and (v /= Void and then item = v)
		end

	item: detachable EV_WIDGET
			-- Current item.

	count: INTEGER_32
			-- Number of elements in `Current'.
		do
			if item /= Void then
				Result := 1
			end
		end

feature -- Element change

	replace (v: like item)
			-- Replace `item' with `v'.
		do
			Precursor {EV_CONTAINER_IMP} (v)
			item := v
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_CELL note option: stable attribute end;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EV_CELL_IMP
