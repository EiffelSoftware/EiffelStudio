indexing
	description	: "Box in which the user may choose whether the value is True or False."
	author		: "Pascal Freund and Christophe Bonnard"
	date		: "$Date$"
	revision	: "$Revision$"

class
	BOOLEAN_SELECTION_BOX

inherit
	SELECTION_BOX
		redefine
			resource,
			display
		end

create
	make

feature -- Commit

	commit is
			-- Commit the resource.
		local
			new_value: BOOLEAN
		do
			check
				resource_exists: resource /= Void
			end
			new_value := yes_item.is_selected
			if resource.actual_value /= new_value then
				resource.set_actual_value (new_value)
				update_resource
				caller.update
			end
		end

feature -- Display
	
	display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		do
			Precursor (new_resource)
			if resource.actual_value then
				yes_item.enable_select
			else
				no_item.enable_select
			end
		end

feature {NONE} -- Implementation

	resource: BOOLEAN_RESOURCE
			-- Resource.

	yes_item: EV_LIST_ITEM
			-- "True" item in the combo box.

	no_item: EV_LIST_ITEM
			-- "False" item in the combo box.

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		local
			combobox: EV_COMBO_BOX
			hbox: EV_HORIZONTAL_BOX
		do
			create combobox
			combobox.set_minimum_width (Layout_constants.Dialog_unit_to_pixels(50))
			combobox.disable_edit
			create yes_item.make_with_text ("True")
			create no_item.make_with_text ("False")
			combobox.extend (yes_item)
			combobox.extend (no_item)
			combobox.select_actions.extend (~commit)

			create hbox
			hbox.extend (combobox)
			hbox.disable_item_expand (combobox)
			hbox.extend (create {EV_CELL})			

			change_item_widget := hbox
		end

end -- class BOOLEAN_SELECTION_BOX
