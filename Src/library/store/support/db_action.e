note
	description: "Objects that redefine ACTION to store Eiffel objects converted %
		% from database in a list."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class
	DB_ACTION [G -> ANY create default_create end]

inherit
	ACTION
		redefine
			execute
		end

create
	make

feature -- Creation

	make (a_selection: like selection; an_item: G)
			-- Initialize.
		require
			not_void: a_selection /= Void
		do
			selection := a_selection
			create list.make (50)
		ensure
			set: selection = a_selection
		end

feature -- Actions

	execute
			-- Update item with current
			-- selected item in the container.
		do
			selection.cursor_to_object
			if attached {G} selection.object as l_object then
				list.extend (l_object)
			end
			selection.object_convert (create {G})
		end

feature -- Access

	selection: DB_SELECTION
			-- Current selection.

	list: ARRAYED_LIST [G];
			-- Result list.

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class DB_ACTION
