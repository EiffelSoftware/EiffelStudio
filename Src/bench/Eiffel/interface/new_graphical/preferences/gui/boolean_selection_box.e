indexing
	description	: "Box in which the user may choose whether the value is True or False."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

feature -- Display
	
	display (new_resource: like resource) is
			-- Display Current with title 'txt' and content 'new_value'.
		do
			Precursor (new_resource)
			check 
				change_item_widget_created: change_item_widget /= Void
			end
			
			if resource.actual_value then
				yes_item.enable_select
			else
				no_item.enable_select
			end
		end

feature {NONE} -- Implementation

	update_changes is
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
				caller.update (resource)
			end
		end

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		local
			combobox: EV_COMBO_BOX
		do
			create combobox
			combobox.set_minimum_width (Layout_constants.Dialog_unit_to_pixels(50))
			combobox.disable_edit
			create yes_item.make_with_text ("True")
			create no_item.make_with_text ("False")
			combobox.extend (yes_item)
			combobox.extend (no_item)
			combobox.select_actions.extend (agent update_changes)

			change_item_widget := combobox
		end

	resource: BOOLEAN_RESOURCE
			-- Resource.

	yes_item: EV_LIST_ITEM
			-- "True" item in the combo box.

	no_item: EV_LIST_ITEM;
			-- "False" item in the combo box.
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class BOOLEAN_SELECTION_BOX
