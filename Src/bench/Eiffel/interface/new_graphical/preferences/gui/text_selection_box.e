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

feature -- Access
	
	change_item_widget: EV_TEXT_FIELD
			-- Widget to change the value of this resource

feature -- Display
	
	display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		local
			tmpstr: STRING
		do
			Precursor (new_resource)
			check 
				change_item_widget_created: change_item_widget /= Void
			end
			
			tmpstr := new_resource.value
			change_item_widget.change_actions.block
			if tmpstr /= Void and then not tmpstr.is_empty then
				change_item_widget.set_text (tmpstr)
			else
				change_item_widget.remove_text
			end
			change_item_widget.change_actions.resume
		end

feature {NONE} -- Command

	update_changes is
			-- Commit the changes.
		local
			int: INTEGER_RESOURCE
			str: STRING_RESOURCE
			success: BOOLEAN
			widget_text: STRING
		do
			check
				resource_exists: resource /= Void
				change_item_widget_created: change_item_widget /= Void
			end
			
			widget_text := change_item_widget.text
			if widget_text = Void then
				widget_text := ""
			end
			
			int ?= resource
			str ?= resource
			if int /= Void then
				if not widget_text.is_empty then
					if widget_text.is_integer then
						int.set_value (change_item_widget.text)
						success := True
					end
				else
					int.set_value ("0")
					success := True
				end
			elseif str /= Void then
				str.set_value (widget_text)
				success := True
			end
			if success then
				update_resource
				caller.update_selected (resource)
			end
		end

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.change_actions.extend (agent update_changes)
		end

end -- class TEXT_SELECTION_BOX
