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
			change_item_widget,
			update_changes,
			reset
		end

create
	make,
	make_with_resource

feature -- Access
	
	change_item_widget: EV_GRID_EDITABLE_ITEM
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
		end

	show is
			-- Show the widget in its editable state
		do			
			activate
		end

feature {NONE} -- Command

	update_changes is
			-- Update the changes made in `change_item_widget' to `resource'.
		do
			resource.set_value_from_string (change_item_widget.text)
			Precursor {PREFERENCE_WIDGET}
		end

	update_resource is
			-- Updates resource.
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
			-- Reset
		do
			Precursor {PREFERENCE_WIDGET}
			change_item_widget.set_text (resource.default_value)
		end		

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget						
			change_item_widget.deactivate_actions.extend (agent update_changes)
			change_item_widget.set_text (resource.string_value)			
			change_item_widget.pointer_button_press_actions.force_extend (agent activate)
		end
		
	activate is
			-- Activate the text
		do
			change_item_widget.activate
			change_item_widget.set_text_validation_agent (agent validate_preference_text)
			if not change_item_widget.text_field.text.is_empty then					
				change_item_widget.text_field.select_all
			end
		end		

    validate_preference_text (a_text: STRING): BOOLEAN is
            -- Validate `a_text'.  Disallow input if text is not an integer and the preference
            -- is an INTEGER_PREFERENCE.
        local
            int: INTEGER_PREFERENCE
        do
            Result := True
            int ?= resource
            if int /= Void and then not a_text.is_integer then
                Result := False
            end
        end

end -- class STRING_PREFERENCE_WIDGET
