indexing
	description	: "Text Selection Box."
	author		: "Pascal Freund and Christophe Bonnard"
	date		: "$Date$"
	revision	: "$Revision$"

class
	TEXT_SELECTION_BOX

inherit
	SELECTION_BOX
		redefine
			display,
			change_item_widget
		end

create
	make

feature -- Display
	
	display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		local
			tmpstr: STRING
		do
			Precursor (new_resource)
			tmpstr := new_resource.value
			if tmpstr /= Void and then not tmpstr.is_empty then
				change_item_widget.set_text (tmpstr)
			else
				change_item_widget.remove_text
			end
			change_item_widget.set_focus
		end

feature {NONE} -- Command

	commit is
			-- Commit the changes.
		local
			int: INTEGER_RESOURCE
			str: STRING_RESOURCE
			success: BOOLEAN
		do
			check
				resource_exists: resource /= Void
			end

			int ?= resource
			str ?= resource
			if int /= Void then
				if change_item_widget.text.is_integer then
					int.set_value (change_item_widget.text)
					success := True
				end
			elseif str /= Void then
				str.set_value (change_item_widget.text)
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

feature {NONE} -- Implementation

	change_item_widget: EV_TEXT_FIELD

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.return_actions.extend (~commit)
		end

end -- class TEXT_SELECTION_BOX
