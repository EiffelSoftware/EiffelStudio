indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	
PRIMITIVE_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end


creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects
		local
			f1: EV_LABEL
		do
			{ANY_TAB} Precursor (Void)
		
				-- Creates the objects and their commands
			
			create f1.make_with_text(Current,"EV_PRIMITIVE is a deferred class and therefore, there has no features that can be modified.")

	
			set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Primitive"
		end

	current_widget: EV_PRIMITIVE
			-- Current widget we are working on.

end -- class BOX_TAB

