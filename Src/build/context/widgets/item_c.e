indexing
	description: "Context that represents an abstract item (EV_ITEM)."
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
			add_pnd_callbacks
		end

	remove_gui_callbacks is
			-- Remove callbacks.
			-- (Need to only remove callbacks part of a list
			-- since set_action will overwrite previous callbacks).
		do
			remove_pnd_callbacks
		end

feature {NONE} -- Pick and drop

	add_pnd_callbacks is
		do
		end

	remove_pnd_callbacks is
		do
		end

feature -- Implementation

	gui_object: EV_ITEM

end -- class ITEM_C

