indexing
	description: "Box in which the user may choose %
				%whether the value is TRUE or FALSE."
	author: "pascalf"
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
	
	make(h: EV_HORIZONTAL_BOX; new_caller: PREFERENCE_WINDOW) is
			-- Creation
		local
			h0,h1,h2: EV_HORIZONTAL_BOX
			com: EV_ROUTINE_COMMAND
		do
			precursor(h,new_caller)
			!! h2.make(frame)
			!! h1.make(h2)
			!! yes_b.make_with_text(h1,"TRUE")
			!! no_b.make_with_text(h1,"FALSE")
			!! ok_b.make_with_text(h2,"OK")
			h2.set_child_expandable(ok_b,FALSE)
			ok_b.set_vertical_resize(FALSE)
			!! com.make(~commit)
			ok_b.add_click_command(com, Void)
		end

feature -- Commit

	Commit (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			resource_exists: resource /= Void
		do
			resource.set_actual_value(yes_b.state)
			caller.update
		end

feature -- Display
	
	Display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		do
			precursor(new_resource)
			if resource.actual_value then
				yes_b.set_state (True)
			else
				no_b.set_state (True)
			end
		end

feature -- Implementation

	resource: BOOLEAN_RESOURCE
		-- Resource.

	yes_b, no_b: EV_RADIO_BUTTON
		-- radio Buttons

	ok_b: EV_BUTTON

end -- class BOOLEAN_SELECTION_BOX
