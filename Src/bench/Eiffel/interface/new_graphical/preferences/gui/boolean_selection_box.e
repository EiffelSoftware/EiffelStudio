indexing
	description: "Box in which the user may choose %
				%whether the value is True or False."
	author: "Pascal Freund and Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	BOOLEAN_SELECTION_BOX

inherit
	SELECTION_BOX
		redefine
			make,resource,display
		end

creation
	make

feature -- Creation
	
	make (h: EV_HORIZONTAL_BOX; new_caller: PREFERENCE_WINDOW) is
			-- Creation
		local
			h1, h2: EV_HORIZONTAL_BOX
		do
			Precursor (h, new_caller)
			create h2
			frame.extend (h2)
			create h1
			h2.extend (h1)
			create yes_b.make_with_text ("True")
			h1.extend (yes_b)
			create no_b.make_with_text ("False")
			h1.extend (no_b)
			create ok_b.make_with_text_and_action ("OK",~commit)
			h2.extend (ok_b)
			h2.disable_item_expand (ok_b)
--			ok_b.disable_vertical_resize
		end

feature -- Commit

	commit is
		require
			resource_exists: resource /= Void
		do
			resource.set_actual_value (yes_b.is_selected)
			update_resource
			caller.update
		end

feature -- Display
	
	display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		do
			Precursor (new_resource)
			if resource.actual_value then
				yes_b.enable_select
			else
				no_b.enable_select
			end
		end

feature -- Implementation

	resource: BOOLEAN_RESOURCE
		-- Resource.

	yes_b, no_b: EV_RADIO_BUTTON
		-- radio Buttons

	ok_b: EV_BUTTON

end -- class BOOLEAN_SELECTION_BOX
