indexing
	description	: "[
		Default widget for viewing and editing resources represented in string
		format (i.e. STRING, INTEGER and ARRAY resources).
		]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	STRING_RESOURCE_WIDGET

inherit
	RESOURCE_WIDGET
		redefine
			set_resource,
			change_item_widget
		end

create
	make,
	make_with_resource

feature -- Access
	
	change_item_widget: EV_TEXT_FIELD
			-- Widget to change the value of this resource.

	graphical_type: STRING is
			-- Graphical type identfier
		do
			Result := "TEXT"
		end	

feature -- Status Setting
	
	set_resource (new_resource: like resource) is
			-- Set the resource.
		local
			tmpstr: STRING
		do
			Precursor (new_resource)
			check 
				change_item_widget_created: change_item_widget /= Void
			end
			
			tmpstr := new_resource.string_value
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
			-- Update the changes made in `change_item_widget' to `resource'.
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
			
			int ?= resource
			str ?= resource
			if int /= Void then
				if not widget_text.is_empty then
					if widget_text.is_integer then
						int.set_value (change_item_widget.text.to_integer)
						success := True
					end
				else
					int.set_value (0)
					success := True
				end
			elseif str /= Void then
				str.set_value (widget_text)
				success := True
			end
		end

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget			
		end

end -- class STRING_RESOURCE_WIDGET
