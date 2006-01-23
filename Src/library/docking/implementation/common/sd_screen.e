indexing
	description: "Copy from EV_STUDIO_SCREEN."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SCREEN

inherit
	EV_SCREEN

feature -- Status report

	virtual_width: INTEGER is
			-- Virtual width of screen
		do
			Result := implementation.virtual_width
		end

	virtual_height: INTEGER is
			-- Virtual height of screen
		do
			Result := implementation.virtual_height
		end

	virtual_x: INTEGER is
			-- X position of virtual screen in main display coordinates
		do
			Result := implementation.virtual_x
		end

	virtual_y: INTEGER is
			-- Y position of virtual screen in main display coordinates
		do
			Result := implementation.virtual_y
		end

	virtual_left: INTEGER is
			-- Left position of virtual screen in main display coordinates
		do
			Result := virtual_x
		end

	virtual_top: INTEGER is
			-- Top position of virtual screen in main display coordinates
		do
			Result := virtual_y
		end

	virtual_right: INTEGER is
			-- Right position of virtual screen in main display coordinates
		do
			Result := virtual_x + virtual_width
		end

	virtual_bottom: INTEGER is
			-- Bottom position of virtual screen in main display coordinates
		do
			Result := virtual_y + virtual_height
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
