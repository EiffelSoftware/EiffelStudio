indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DRAWING_AREA_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end

creation
	make

feature -- Initialization

	make(par: EV_CONTAINER) is
			-- Create the tab and initalise the objects.
		local
			l1: EV_LABEL			
		do
			{ANY_TAB} Precursor (Void)
				-- Creates the objects and their commands.
			create l1.make_with_text(Current,"EV_DRAWING_AREA has no new features which are%N interactive in this demo.")
			set_child_position (l1, 0, 0, 1, 1)
			set_parent (par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab.
		do
			Result:="Drawing Area"
		ensure then
			result_exists: Result /= Void
		end

	current_widget: EV_LIST
		-- The current demo.

end -- class DRAWING_AREA_TAB
 


