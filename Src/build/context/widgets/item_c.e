indexing
	description: "Context that represents an item (EV_ITEM)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ITEM_C

inherit
	CONTEXT
		redefine
			gui_object
		end

feature {NONE} 

	copy_attributes (other_context: like Current) is
			-- Copy the attributes of Current to `other_context'.
		do
		end

feature {NONE} -- Callbacks

	add_gui_callbacks is
			-- Define the general behavior of the GUI object.
		do
		end

	initialize_transport is
			-- Initialize the mechanism through which
			-- the current context may be dragged and
			-- dropped.
		do
		end

	remove_gui_callbacks is
			-- Remove callbacks.
			-- (Need to only remove callbacks part of a list
			-- since set_action will overwrite previous callbacks).
		do
		end

feature -- Status report

feature -- Status setting

feature -- Implementation

	gui_object: EV_ITEM

end -- class ITEM_C

