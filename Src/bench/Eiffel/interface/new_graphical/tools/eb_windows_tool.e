indexing
	description	: "Tool to view all opened windows"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_WINDOWS_TOOL

inherit
	EB_TOOL
		redefine
			menu_name,
			pixmap,
			widget
		end

	EB_SHARED_WINDOW_MANAGER

creation
	make

feature {NONE} -- Initialization

	build_interface is
			-- Build all the tool's widgets.
		do
			widget := window_manager.new_widget
		end

	build_explorer_bar is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		do
			create explorer_bar_item.make (explorer_bar, widget, title, True)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar.add (explorer_bar_item)
			explorer_bar.repack_widgets
		end

feature -- Access

	widget: EB_WINDOW_MANAGER_LIST
			-- Widget representing Current

	title: STRING is
			-- Title of the tool
		do
			Result := Interface_names.t_Windows_tool
		end

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := Interface_names.m_Windows_tool
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap as it may appear in toolbars and menus.
		do
			Result := Pixmaps.Icon_windows
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			explorer_bar_item.recycle
			widget.recycle
			widget := Void
			manager := Void
		end

end -- class EB_WINDOWS_TOOL
