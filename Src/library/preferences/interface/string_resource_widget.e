indexing
	description	: "[
		Default widget for viewing and editing resources represented in string
		format (i.e. STRING, INTEGER and ARRAY resources).
		]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	STRING_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
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
		do
		end

	update_resource is
			-- 
		local
			int: INTEGER_PREFERENCE
			str: STRING_PREFERENCE
			list: ARRAY_PREFERENCE
		do
			int ?= resource
			str ?= resource
			list ?= resource
			if int /= Void then
				if not change_item_widget.text.is_empty and then change_item_widget.text.is_integer then
						int.set_value (change_item_widget.text.to_integer)
				else
					int.set_value (0)
				end
			elseif str /= Void then
				str.set_value (change_item_widget.text)
			elseif list /= Void then
				list.set_value_from_string (change_item_widget.text)
			end		
		end		

	reset is
			-- 
		do
			if resource.has_default_value then
				resource.reset
			end	
			change_item_widget.set_text (resource.default_value)
		end		

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget			
		end

end -- class STRING_PREFERENCE_WIDGET
