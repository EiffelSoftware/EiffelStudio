indexing
	description	: "Default widget for viewing and editing boolean resources.  A combo box with two values ('True' and 'False')"
	date		: "$Date$"
	revision	: "$Revision$"

class
	BOOLEAN_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			resource,
			set_resource
		end

create
	make

feature -- Status Setting
	
	set_resource (new_resource: like resource) is
			-- Set the resource.
		do
			Precursor (new_resource)
			check 
				change_item_widget_created: change_item_widget /= Void
			end
			
			if resource.value then
				yes_item.enable_select
			else
				no_item.enable_select
			end
		end

feature -- Access

	graphical_type: STRING is
			-- Graphical type identifier.
		do
			Result := "BOOLEAN"
		end	

feature {NONE} -- Implementation

	update_changes is
			-- Update the changes made in `change_item_widget' to `resource'.
		do			
		end
		
	update_resource is
			-- 
		do
			resource.set_value (yes_item.is_selected)
		end		

	reset is
			-- 
		do
			if resource.has_default_value then
				resource.reset
			end	
			if resource.value then				
				yes_item.enable_select	
			else
				no_item.enable_select
			end
		end		


	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create combobox
			combobox.set_minimum_width (50)
			combobox.disable_edit
			create yes_item.make_with_text ("True")
			create no_item.make_with_text ("False")
			combobox.extend (yes_item)
			combobox.extend (no_item)
			change_item_widget := combobox
		end

	resource: BOOLEAN_PREFERENCE
			-- Actual resource.
	
	combobox: EV_COMBO_BOX			

	yes_item: EV_LIST_ITEM
			-- "True" item in the combo box.

	no_item: EV_LIST_ITEM
			-- "False" item in the combo box.
	
	last_selected_value: BOOLEAN
	
end -- class BOOLEAN_PREFERENCE_WIDGET
