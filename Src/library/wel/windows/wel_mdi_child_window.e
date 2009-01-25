note
	description: "MDI child window to insert into a MDI client window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MDI_CHILD_WINDOW

inherit
	WEL_FRAME_WINDOW
		rename
			make_child as make
		redefine
			class_name,
			class_background,
			internal_window_make,
			call_default_window_procedure,
			destroy,
			parent,
			move_and_resize,
			make,
			set_parent
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_MDI_FRAME_WINDOW; a_name: STRING_GENERAL)
			-- Make window as child of `a_parent' and `a_name' as title.
		do
			parent := a_parent
			register_class
			internal_window_make (a_parent, a_name,
				default_style,
				default_x, default_y,
				default_width, default_height,
				default_id, default_pointer)
		end

feature -- Access

	parent: ?WEL_MDI_FRAME_WINDOW
			-- Parent window

feature -- Basic operations

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN)
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		do
			move_and_resize_internal (a_x, a_y, a_width, a_height, repaint, 0)
		end

	destroy
			-- Destroy the window.
		local
			l_parent: like parent
		do
			l_parent := parent
			if l_parent /= Void then
				l_parent.client_window.destroy_window (Current)
			end
		end

feature -- Element change

	set_parent (a_parent: ?WEL_WINDOW)
			-- Change parent of current window if possible.
		local
			l_prev_parent: POINTER
		do
				-- We do the object test because `parent' has been redefined to a WEL_MDI_FRAME_WINDOW.
			if {l_parent: like parent} a_parent then
				parent := l_parent
				l_prev_parent := {WEL_API}.set_parent (item, l_parent.item)
			end
		end

feature {NONE} -- Implementation

	internal_window_make (a_parent: ?WEL_MDI_FRAME_WINDOW; a_name: ?STRING_GENERAL;
			a_style, a_x, a_y, a_w, a_h, an_id: INTEGER;
			data: POINTER)
			-- Create the window
		local
			mdi_cs: WEL_MDI_CREATE_STRUCT
		do
			parent := a_parent
				-- It only makes sense to create a child window if there is a parent specified.
			if a_parent /= Void then
				if a_name /= Void then
					create mdi_cs.make (class_name, a_name)
				else
					create mdi_cs.make (class_name, "")
				end
				mdi_cs.set_style (default_style)
				item := {WEL_API}.send_message_result (a_parent.client_window.item, Wm_mdicreate, to_wparam (0), mdi_cs.item)
				if item /= default_pointer then
					register_current_window
					set_default_window_procedure
				end
			end
		end

	call_default_window_procedure (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
		do
			Result := cwin_def_mdi_child_proc (hwnd, msg,
				 wparam, lparam)
		end

	class_background: WEL_BRUSH
			-- Standard window background color
		once
			create Result.make_by_sys_color (Color_window + 1)
		end

	class_name: STRING_32
			-- Window class name to create
		once
			Result := "WELMDIChildWindowClass"
		end

feature {NONE} -- Externals

	cwin_def_mdi_child_proc (hwnd: POINTER; msg: INTEGER; wparam, lparam: POINTER): POINTER
			-- SDK DefMDIChildProc
		external
			"C [macro <wel.h>] (HWND, UINT, WPARAM, %
				%LPARAM): LRESULT"
		alias
			"DefMDIChildProc"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_MDI_CHILD_WINDOW

