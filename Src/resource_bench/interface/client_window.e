indexing
	description: "Client Window of the Resource Bench's main window"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	CLIENT_WINDOW

inherit
	WEL_CONTROL_WINDOW
		redefine
			class_background,
			class_name,
			default_ex_style,
			on_notify
		end

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVN_CONSTANTS
		export
			{NONE} all
		end

	TABLE_OF_SYMBOLS

creation
	make

feature -- Access

	properties_window: RESOURCE_PROPERTIES_WINDOW
			-- Link to the properties window.

	properties_dialog: DIALOG_PROPERTIES
			-- Dialog which contains informations about what must be generated.

	current_resource: TDS_RESOURCE
			-- The current selected resource in the tree view control.

feature -- Behavior

	on_notify (a_control_id: INTEGER; info: WEL_NMHDR) is
		local
			tt2: WEL_NM_TREE_VIEW
		do
			if info.code = Tvn_selchanged then
				!! tt2.make_by_nmhdr (info)
				-- A new item has been selected (tt2.item_new).
				new_resource := tds.access_tree_view_item (tt2.new_item.h_item)
				change_and_display
			end
		end

feature -- Element Change

	set_properties_window (a_window: RESOURCE_PROPERTIES_WINDOW) is
			-- Set `properties_window' to `a_window'.
		require
			a_window_not_void: a_window /= void
		do
			properties_window := a_window
		ensure
			properties_window_set: properties_window = a_window
		end

	set_current_resource (a_resource: TDS_RESOURCE) is
			-- Set `current_resource' to `a_resource'.
		do
			current_resource := a_resource
		ensure
			current_resource_set: current_resource = a_resource
		end

	set_last_change is
			-- Set last changes to the tds after a graphical modification.
		require
			properties_window_exists: properties_window.exists
		local
			dialog: TDS_DIALOG
		do
			dialog ?= current_resource
			if (dialog /= Void) then
				properties_dialog.set_dialog_properties (dialog)
			end
		end

feature {NONE} -- Implementation

	default_ex_style: INTEGER is 768
			-- Default_style.

	class_name: STRING is
		once
			!! result.make (20)
			result := "Client window"
		end

	class_background: WEL_NULL_BRUSH is
		once
			!! Result.make
		end

	new_resource: TDS_RESOURCE
			-- The new selected resource in the tree view control.

	change_and_display is
			-- Take all informations and put the new ones.
		require
			properties_window_exists: properties_window.exists
		local
			dialog: TDS_DIALOG
			bitmap: TDS_BITMAP
		do
			dialog ?= current_resource
			if (dialog /= Void) then
				properties_dialog.set_dialog_properties (dialog)
				properties_dialog.destroy
			end

			dialog ?= new_resource
			if dialog /= Void then
				!! properties_dialog.make (properties_window, dialog)
				properties_dialog.activate
			end

			current_resource := new_resource
			new_resource := Void

			properties_window.set_current_resource (current_resource)
			properties_window.invalidate
		end

end -- class CLIENT_WINDOW
