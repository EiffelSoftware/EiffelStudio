indexing
	description: "Main window class of the WEL example : Tree_view."
	status: "See notice at end of class."
	date: ""
	revision: ""

class
	PRECOMP_MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_background,
			default_style,
			on_get_min_max_info
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
		do
			make_top (Title)
			resize (185, 245)
			-- Create the output
			create list.make (Current, 0, 0, client_rect.width, 20, 1)
			list.set_font(gui_font)
			create label.make (Current, "What happens?", 0, 20, client_rect.width, 20, 0)
			label.set_font(gui_font)
			-- Create the tree view.
			create tree_view.make (Current, 10, 50, 150, 150, -1)
			tree_view.set_item_output (label)
			tree_view.set_mess_output (list)
		end

feature -- Access

	list: WEL_SINGLE_SELECTION_LIST_BOX

	label: WEL_STATIC

	tree_view: TREEVIEW

feature {NONE} -- Implementation

	Title: STRING is "WEL Tree View"
			-- Window's title

	gui_font: WEL_DEFAULT_GUI_FONT is
			-- Default font used to draw dialogs.
		once
			create Result.make
		end

	class_background: WEL_BRUSH is
			-- background color
		once
			create Result.make_by_sys_color (Color_background)
		end

	default_style: INTEGER is
			-- The window do not redraw the children.
		once
			Result := {WEL_FRAME_WINDOW} Precursor
				+ Ws_clipchildren + Ws_clipsiblings
		end

	
   	on_get_min_max_info (min_max_info: WEL_MIN_MAX_INFO) is
   			-- Wm_getminmaxinfo message.
   			-- The size or position of the window is about to
   			-- change. An application can change `min_max_info' to
   			-- override the window's default maximized size and
   			-- position, or its default minimum or maximum tracking
   			-- size.
		local
			pt: WEL_POINT
   		do
			if shown then
				create pt.make (width, height)
				min_max_info.set_min_track_size (pt)
				min_max_info.set_max_track_size (pt)
			end
 		end

end -- class PRECOMP_MAIN_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
