indexing
	description	: "Class which allows entering a value corresponding to a data."
	author		: "Pascal Freund and Christophe Bonnard"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	SELECTION_BOX

inherit
	RESOURCE_OBSERVATION_MANAGER

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

	Layout_constants: EV_LAYOUT_CONSTANTS is
			-- Constants for designing graphical interfaces.
		do
			create Result
		end

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

end -- class SELECTION_BOX
