indexing
	description: "Text Selection Box."
	author: "Pascal Freund and Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_SELECTION_BOX

inherit
	SELECTION_BOX
		redefine
			make, display
		end

creation
	make

feature -- Initialization

	make (h: EV_HORIZONTAL_BOX; new_caller: PREFERENCE_WINDOW) is
			-- Creation
		local
			h1: EV_HORIZONTAL_BOX
		do
			Precursor (h, new_caller)
			create h1
			frame.extend (h1)
			create text_f
			h1.extend (text_f)
			text_f.return_actions.extend (~commit)
		end

feature -- Display
	
	display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		local
			tmpstr: STRING
		do
			Precursor (new_resource)
			tmpstr := new_resource.value
			if tmpstr /= Void and then not tmpstr.is_empty then
				text_f.set_text (tmpstr)
			else
				text_f.remove_text
			end
			text_f.set_focus
		end

feature -- Command

	commit is
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
					int.set_value (text_f.text)
					success := True
				end
			elseif str /= Void then
				str.set_value (text_f.text)
				success := True
			end
			if success then
				update_resource
				caller.update
			else
				check
					Error: False
				end
			end
		end

feature -- Implementation
		
	text_f: EV_TEXT_FIELD
		-- Text where we change the value.

invariant
	text_f_exists: text_f /= Void

end -- class TEXT_SELECTION_BOX
