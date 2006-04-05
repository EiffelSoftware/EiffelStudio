indexing
	description	: "Class which allows entering a value corresponding to a data."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Pascal Freund and Christophe Bonnard"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	SELECTION_BOX

inherit
	RESOURCE_OBSERVATION_MANAGER

	EB_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (new_caller: PREFERENCE_WINDOW) is
			-- Create a new selection box associated with `new_caller'
		require
			caller_exists: new_caller /= Void
		do
			caller := new_caller

			build_change_item_widget
		end

feature -- Basic operations

	display (new_resource: like resource) is
			-- Display Current with content 'new_resource'.
		do
			resource := new_resource
			
			if change_item_widget = Void then
				build_change_item_widget
			end
		end

	change_dialog: EV_DIALOG is
			-- Dialog to change the value.
		do
			if internal_change_dialog = Void then
				create internal_change_dialog
				internal_change_dialog.disable_user_resize
				if change_item_widget = Void then
					build_change_item_widget
				end
				internal_change_dialog.extend (change_item_widget)
			end
			Result := internal_change_dialog
		end
			
	destroy is
			-- Destroy all graphical objects.
		do
			if internal_change_dialog /= Void then
				internal_change_dialog.wipe_out
			end
			if change_item_widget /= Void then
				change_item_widget.destroy
			end
			if internal_change_dialog /= Void then
				internal_change_dialog.destroy
			end
		end
		
feature {NONE} -- Implementation

	internal_change_dialog: EV_UNTITLED_DIALOG
			-- Dialog to change the value.
			
	change_item_widget: EV_WIDGET
			-- Widget to change the item
			
	resource: RESOURCE
			-- Resource.

	caller: PREFERENCE_WINDOW
			-- Caller

	update_resource is
			-- Update resource
		do
			if observer_manager.get_data_observer (resource) /= Void then
				observer_manager.update_observer (resource)
			end
		end

	build_change_item_widget is
				-- Create and setup `change_item_widget'.
		deferred
		ensure
			widget_created: change_item_widget /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class SELECTION_BOX
