indexing
	description: "Text Selection Box."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_SELECTION_BOX

inherit
	SELECTION_BOX
		redefine
			make,display
		end

creation
	make

feature -- Initialization

	make(h: EV_HORIZONTAL_BOX; new_caller: PREFERENCE_WINDOW) is
			-- Creation
		local
			h1: EV_HORIZONTAL_BOX
			com: EV_ROUTINE_COMMAND
		do
			precursor(h,new_caller)
			!! h1.make(frame)
			!! text_f.make(h1)
			!! com.make(~commit)
			text_f.add_return_command(com, Void)
		end

feature -- Display
	
	Display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		do
			precursor(new_resource)
			text_f.set_text(new_resource.value)
			text_f.set_focus
		end

feature -- Command

	commit (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Commit the changes.
		require
			resource_exists: resource /= Void
		local
			int: INTEGER_RESOURCE
			str: STRING_RESOURCE
			success: BOOLEAN
		do
			int ?= resource
			str ?= resource
			if int /= Void then
				if text_f.text.is_integer then
					int.set_value(text_f.text)
					success := TRUE
				end
			elseif str /= Void then
				str.set_value(text_f.text)
				success := TRUE
			end
			if success then
				update_resource
				caller.update
			else
				-- error
			end
		end

feature -- Implementation
		
	text_f: EV_TEXT_FIELD
		-- Text where we change the value.

invariant
	text_f_exists: text_f /= Void
end -- class TEXT_SELECTION_BOX
