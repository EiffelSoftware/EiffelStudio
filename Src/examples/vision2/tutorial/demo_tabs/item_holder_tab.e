indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ITEM_HOLDER_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end

create
	make

feature -- Initialization

	make(par: EV_CONTAINER) is
			-- Create the tab and initalise the objects.
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
				-- Commands used by the tab.
			h1: EV_HORIZONTAL_SEPARATOR
		do
			Precursor {ANY_TAB} (Void)
			create cmd2.make (agent count)
			create f1.make (Current, 0, 0, "Count", Void, cmd2)


			set_parent (par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab.
		do
			Result:="Item Holder"
		ensure then
			result_exists: Result /= Void
		end

	current_widget: EV_LIST
		-- The current demo.

	f1: TEXT_FEATURE_MODIFIER
		--  A feature modifier for the action window.

feature -- Execution Feature

	count (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Display `Count' objects held.
		do
			f1.set_text (current_widget.count.out)
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


end -- class ITEM_HOLDER_TAB

