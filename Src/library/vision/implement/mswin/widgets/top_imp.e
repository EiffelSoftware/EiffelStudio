indexing
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	TOP_IMP

inherit
	WM_SHELL_IMP
		rename
			application_main_window as wm_shell_application_main_window
		redefine
			class_icon,
			closeable,
			default_style,
			destroy,
			on_size,
			realize,
			realize_current,
			class_name
		end

	TOP_I

	MAIN_WINDOW_MANAGER_WINDOWS
		rename
			accelerators as wel_accelerators,
			make as main_window_manager_make
		end

feature -- Status setting

   	destroy (wid_list: LINKED_LIST [WIDGET]) is
    			-- Destroy screen widget implementation and all
    			-- screen widget implementations of its children
    			-- contained in wid_list
		local
			ww: WIDGET_IMP
 		do
			remove_main_window (Current)
			if exists then
				if application_main_window = Current then
					cwin_post_quit_message (0)
				else
					cwin_destroy_window (wel_item)
				end
			end
			from
				wid_list.start
			until
				wid_list.after
			loop
				ww ?= wid_list.item.implementation
				actions_manager_list.deregister (ww)
				wid_list.forth
			end
		end

	realize is
			-- Realize current widget
		do
			if not realized then
				realize_current
				add_main_window (Current)
				if main_window = Current then
					set_main_window
				end
				realizing_children := True
				shown := True
				realize_children
				realizing_children := False
				set_enclosing_size
				resize_shell_children (width, height)
				show
			end
		end

	realize_current is
			-- Realize current widget.
		local
			call_configure_action: BOOLEAN
		do
			call_configure_action := x /= default_x or else y /= default_y or else
				width /= default_width or else height /= default_height
			if title /= Void then
				if width = 0 then
					if height = 0 then
						make_top_with_coordinates (title, x, y, default_width, default_height)
					else
						make_top_with_coordinates (title, x, y, default_width, height+shell_height)
					end
				else
					if height = 0 then
						make_top_with_coordinates (title, x, y, width+shell_width, default_height)
					else
						make_top_with_coordinates (title, x, y, width+shell_width, height+shell_height)
					end
				end
			else
				make_top_with_coordinates ("", x, y, width+shell_width, height+shell_height)
			end
			if call_configure_action then
				shown := True
				resize_actions.execute (Current, Void)
				shown := False
			end
		end

	set_iconic_state is
			-- Set start state of the application to be iconic.
		do
			private_iconic_state := true
			if exists then
				minimize
			end
		end

	set_icon_name (a_name: STRING) is
			-- Set `icon_name' to `a_name'.
		do
			icon_name := clone (a_name)
			if exists then
				if minimized then
					set_title (a_name)
				end
			end
		end

	set_normal_state is
			-- Set start state of the application to be normal.
		do
			private_iconic_state := false
			if exists then
				restore
			end
		end

	set_maximized_state is
			-- Set start state if the application to be maximized.
		do
			private_iconic_state := false
			private_maximized_state := True
			if exists then
				maximize
			end
		end

feature -- Status report

	closeable: BOOLEAN is
			-- Can the user close the window?
			-- Performs user action
		do
			Result := false
			delete_window_action
		end

	icon_name: STRING
			-- Short form of application name to be displayed
			-- by the window manager when application is iconified

	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		do
			if exists then
				Result := minimized
			else
				Result := private_iconic_state
			end
		end

	is_maximized_state: BOOLEAN is
			-- Does application start in maximized state?
		do
			if exists then
				Result := maximized
			else
				Result := private_maximized_state
			end
		end

feature {NONE} -- Implementation

	realizing_children: BOOLEAN
			-- Are the children currently being realized?

	title_before_iconise: STRING
			-- Storage for title before an iconise action
			--| it will be changed to icon_name

	on_size (size_type: INTEGER; a_width, a_height: INTEGER) is
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		local
			resize_data: RESIZE_CONTEXT_DATA
		do
			if not children_resizing then
				if size_type = size_minimized then
					if icon_name /= Void then
						title_before_iconise := title
						set_title (icon_name)
					end
				else
					if title_before_iconise /= Void then
						set_title (title_before_iconise)
						title_before_iconise := Void
					end
					resize_shell_children (a_width, a_height)
				end
				if size_type = Size_minimized then
					shown := False
					unmap_actions.execute (Current,  Void)
				elseif size_type = Size_restored or else size_type = Size_maximized then
					shown := True
					map_actions.execute (Current, Void)
					!! resize_data.make (owner, a_width, a_height, size_type)
					resize_actions.execute (Current, resize_data)
				end
			end
		end

	private_iconic_state: BOOLEAN
			-- Implementation of iconic state

	private_maximized_state: BOOLEAN
			-- Implementation of maximized state

	class_icon: WEL_ICON;
			-- Icon for top window

	default_style: INTEGER is
			-- Default style used to create the window
		do
			Result := Ws_overlappedwindow
			if private_iconic_state then
				Result := Result + ws_minimize
			end

			if private_maximized_state then
				Result := Result + ws_maximize
			end
		end

	null_class_icon: WEL_NULL_ICON is
			-- Icon for drawing icon
		once
			!! Result
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionTop"
		end

end -- class TOP_IMP
 

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

