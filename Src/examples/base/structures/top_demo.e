note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	TOP_DEMO

inherit
	STORABLE
	STD_FILES

create
	make

feature {NONE} -- Creation

	make
			-- Initialize a new demo.
		do
			create driver.make
		end

feature -- Access

	driver: DEMO_DRIVER
			-- A driver to read user input.

feature -- Basic operations

	fill_menu
			-- Initialize menu.
		do
		end

	execute (new_command: INTEGER)
			-- Execute command corresponding to user's request.
		do
		end

	cycle
			-- Run a demo cycle.
		do
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
