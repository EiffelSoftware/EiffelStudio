note
	description: "[
					EiffelVision web browser. Mswindows implementation.
																				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "application, accelerator, event loop"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEB_BROWSER_IMP

inherit
	EV_WEB_BROWSER_I
		redefine
			interface
		end

	EV_WIDGET_IMP
		undefine
			is_tabable_from,
			destroy
		redefine
			interface,
			default_process_message,
			on_size,
			make
		end

	EV_SIZEABLE_PRIMITIVE_IMP
		redefine
			interface,
			make
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			default_process_message,
			on_size,
			destroy,
			make
		end

	WEL_WINDOW
		rename
			parent as wel_parent,
			enabled as is_sensitive,
			move as wel_move,
			resize as wel_resize,
			shown as is_displayed,
			destroy as wel_destroy,
			set_parent as wel_set_parent,
			has_capture as wel_has_capture,
			move_and_resize as wel_move_and_resize,
			width as wel_width,
			height as wel_height,
			item as wel_item
		undefine
			on_left_button_up,
			on_left_button_down,
			on_left_button_double_click,
			on_middle_button_up,
			on_middle_button_down,
			on_middle_button_double_click,
			on_right_button_up,
			on_right_button_down,
			on_right_button_double_click,
			on_mouse_move,
			on_mouse_wheel,
			on_wm_dropfiles,
			on_key_up,
			on_key_down,
			on_sys_key_up,
			on_sys_key_down,
			set_width,
			set_height,
			on_set_focus,
			on_kill_focus,
			on_set_cursor,
			on_size,
			on_char,
			on_desactivate,
			on_getdlgcode,
			show,
			hide,
			default_process_message
		end

	WEL_CS_CONSTANTS

	WEL_COLOR_CONSTANTS

	WEL_IDC_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make
			-- Create `Current' with interface `an_interface'
		do
			Precursor
			register_class
			internal_window_make (default_parent, "", default_style, 0, 0, 0, 0, 0, default_pointer)
			initialize
		end

	old_make (an_interface: like interface)
			-- Create underlying native toolkit objects.
			-- Every descendant should exactly one a creation procedure `make'.
			-- Must call `base_make'.
		do
			check never_used: False end -- Just because {EV_ANY_I} has it as deferred feature
		end

feature {EV_WEB_BROWSER} -- Initialization

	initialize
			-- Initialize `Current'
		local
			l_ole_ie_hwnd: POINTER
		do
			-- We must create a HWND for OLE IE object and can't share with current `wel_item', otherwise `window_process_message' will not be called
			create ole_ie_window.make (Current, "IE OLE")
			l_ole_ie_hwnd := ole_ie_window.item

			create ole_ie
			-- FIXME: how to check if OLE already initialized? And when to un-initialize?
			ole_ie.ole_initialize

			ole_ie_window.set_parent (Current)
			ole_ie.embed_ie (l_ole_ie_hwnd)
		end

feature {NONE} -- Window class register

	register_class
			-- Register the window class if
			-- the class is not already registered.
			-- The routines `class_style', `class_window_procedure',
			-- `class_icon', `class_cursor', `class_background', and
			-- `class_menu_name' are called before the registration
			-- to set all the window class information.
			-- FIXME: copy from {WEL_FRAME_WINDOW} merge?
		do
			create wnd_class.make (class_name)
			if not wnd_class.registered then
				wnd_class.set_style (class_style)
				wnd_class.set_window_procedure (class_window_procedure)
				--	if class_requires_icon then
				--		wnd_class.set_icon (class_icon)
				--	end
				wnd_class.set_cursor (class_cursor)
				if
					background_brush = Void and then
					class_background /= Void
				then
						--| If class_background attribute is not
						--| Void, we do not use the class_background
						--| once function.
					wnd_class.set_background (class_background)
				end
				wnd_class.set_menu_name (class_menu_name)
				wnd_class.register
			end
		end

	wnd_class: WEL_WND_CLASS;
		-- Associated windows class of current window.	

	class_style: INTEGER
			-- Standard style used to create the window class.
			-- Can be redefined to return a user-defined style.
		once
			Result := Cs_dblclks
		end

	class_window_procedure: POINTER
			-- Standard window procedure
		once
			Result := cwel_window_procedure_address
		ensure
			result_not_null: Result /= default_pointer
		end

	class_requires_icon: BOOLEAN
			-- Does `Current' require an icon to be registered?
			-- If `True' `register_class' assigns a class icon, otherwise
			-- no icon is assigned.
		do
			Result := False
		end

	class_cursor: WEL_CURSOR
			-- Standard arrow cursor used to create the window
			-- class.
			-- Can be redefined to return a user-defined cursor.
		once
			create Result.make_by_predefined_id (Idc_arrow)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	class_background: WEL_BRUSH
			-- Standard window background color used to create the
			-- window class.
			-- Can be redefined to return a user-defined brush.
		require
			background_brush_not_set: background_brush = Void
		once
			create Result.make_by_sys_color (Color_window + 1)
		ensure
			result_not_void: Result /= Void
		end

	class_menu_name: STRING_32
			-- Window's menu used to create the window class.
			-- Can be redefined to return a user-defined menu.
			-- (None by default).
		once
			create Result.make (0)
		ensure
			result_not_void: Result /= Void
		end

feature -- Command

	load_uri (a_uri: STRING_GENERAL)
			-- <Precursor>
		do
			ole_ie.display_web_page (a_uri)
		end

	back
			-- <Precursor>
		do
			ole_ie.do_page_action ({EV_OLE_IE_PAGE_ACTIONS}.move_back)
		end

	forth
			-- <Precursor>
		do
			ole_ie.do_page_action ({EV_OLE_IE_PAGE_ACTIONS}.move_forward)
		end

	home
			-- <Precursor>
		do
			ole_ie.do_page_action ({EV_OLE_IE_PAGE_ACTIONS}.move_to_home)
		end

	search
			-- <Precursor>
		do
			ole_ie.do_page_action ({EV_OLE_IE_PAGE_ACTIONS}.search)
		end

	refresh
			-- <Precursor>
		do
			ole_ie.do_page_action ({EV_OLE_IE_PAGE_ACTIONS}.refresh)
		end

	stop
			-- <Precursor>
		do
			ole_ie.do_page_action ({EV_OLE_IE_PAGE_ACTIONS}.stop)
		end

	destroy
			-- <Precursor>
		do
			Precursor {EV_PRIMITIVE_IMP}
			ole_ie.unembed_ie (ole_ie_window.item)
		end

feature {NONE} -- Implementation

	ole_ie: EV_OLE_IE
			-- ActiveX ole Internet Explorer object

	ole_ie_window: WEL_CONTROL_WINDOW
		-- WEL window for containing OLE IE

	interface: EV_WEB_BROWSER
			-- Vision2 widget interface

	on_size (size_type, a_width, a_height: INTEGER_32)
			-- Handle OLE IE resize actions
		do
			Precursor {EV_PRIMITIVE_IMP}(size_type, a_width, a_height)
			if is_displayed and then ole_ie_window /= Void then

				-- We must resize both `ole_ie_window' and `ole_ie_window.item'
				ole_ie_window.resize (a_width, a_height)
				ole_ie.resize_browser (a_width, a_height)
			end
		end

	class_name: STRING_32
			-- <Precursor>
		once
			Result := generator
		end

	default_style: INTEGER
			-- <Precursor>
		do
			Result := ws_visible | ws_child | ws_group | ws_tabstop | Ws_clipchildren | Ws_clipsiblings
		end

	cwin_get_next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER
			-- <Precursor>
		external
			"C [macro <wel.h>] (HWND, HWND, BOOL): HWND"
		alias
			"GetNextDlgTabItem"
		end

	default_process_message (msg: INTEGER_32; wparam, lparam: POINTER)
			-- <Precursor>
		local
			l_width, l_height: INTEGER
		do
			Precursor {EV_WIDGET_IMP}(msg, wparam, lparam)
			if msg = wm_size then
				l_width := cwin_lo_word (lparam)
				l_height := cwin_hi_word (lparam)
			end
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_WEB_BROWSER_IMP
