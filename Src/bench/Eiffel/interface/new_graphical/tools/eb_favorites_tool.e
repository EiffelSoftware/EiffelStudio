indexing
	description	: "Tool to view the favorites"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FAVORITES_TOOL

inherit
	EB_TOOL
		rename
			make as tool_make
		redefine
			menu_name,
			pixmap
		end

creation
	make

feature {NONE} -- Initialization

	make (a_manager: EB_TOOL_MANAGER; an_explorer_bar: like explorer_bar; a_favorites_manager: EB_FAVORITES_MANAGER) is
			-- Make a new favorites tool.
		require
			a_manager_exists: a_manager /= Void
			an_explorer_bar_exists: an_explorer_bar /= Void
			a_favorites_manager_exists: a_favorites_manager /= Void
		do
			favorites_manager := a_favorites_manager
			tool_make (a_manager, an_explorer_bar)
		end

	build_interface is
			-- Build all the tool's widgets.
		do
			-- The widget has already been created, so do nothing.
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

	widget: EV_WIDGET is
			-- Widget representing Current
		do
			Result := favorites_manager.widget
		end

	title: STRING is 
			-- Title of the tool
		do
			Result := Interface_names.t_Favorites_tool
		end

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := Interface_names.m_Favorites_tool
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap as it may appear in toolbars and menus.
		do
			Result := Pixmaps.Icon_favorites
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			explorer_bar_item.recycle
			favorites_manager.recycle
			favorites_manager := Void
			explorer_bar_item := Void
		end

feature {NONE} -- Implementation

	favorites_manager: EB_FAVORITES_MANAGER
			-- Associated favorites manager.

end -- class EB_FAVORITES_TOOL
