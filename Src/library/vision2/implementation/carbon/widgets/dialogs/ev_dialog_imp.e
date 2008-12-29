note
	description: "Eiffel Vision dialog. Carbon implementation."

class
	EV_DIALOG_IMP

inherit
	EV_DIALOG_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			dialog_key_press_action,
			lock_update,
			unlock_update
		redefine
			interface
		end

	EV_TITLED_WINDOW_IMP
		redefine
			make,
			interface,
			call_close_request_actions,
			initialize,
			client_area
		end

create
	make

feature {NONE} -- Initialization

--	make (an_interface: like interface) is
--			-- Create empty dialog box.
--	local
--			window_attributes: INTEGER
--			rect: RECT_STRUCT
--			res: INTEGER
--			ptr: POINTER
--			root_control_ptr : POINTER
--			target: POINTER
--			h_ret: POINTER
--		do
--			base_make (an_interface)
--			create rect.make_new_shared

--			rect.set_bottom (450)
--			rect.set_left (45)
--			rect.set_right (400)
--			rect.set_top (45)
--			window_attributes := ({MACWINDOWS_ANON_ENUMS}.kwindowstandarddocumentattributes).bit_or({MACWINDOWS_ANON_ENUMS}.kwindowstandardfloatingattributes).bit_or({MACWINDOWS_ANON_ENUMS}.kwindowstandardhandlerattribute).bit_or({MACWINDOWS_ANON_ENUMS}.kWindowCompositingAttribute)

--			res := create_new_window_external({MACWINDOWS_ANON_ENUMS}.kdocumentwindowclass, window_attributes, rect.item, $ptr)
--			res := create_root_control_external( ptr, $root_control_ptr )
--			set_c_object (ptr)

--			event_id := app_implementation.get_id (current)  --getting an id from the application
--			target := get_window_event_target_external(ptr)
--			h_ret := app_implementation.install_event_handler (event_id, target, {CARBONEVENTS_ANON_ENUMS}.kEventClassWindow, {CARBONEVENTS_ANON_ENUMS}.kEventWindowClose)
--		end

--	initialize is
--			-- Create the vertical box `vbox' and horizontal box `hbox'
--			-- to put in the window.
--			-- The `vbox' will be able to contain the menu bar, the `hbox'
--			-- and the status bar.
--			-- The `hbox' will contain the child of the window.
--		local
--			l_c_object: POINTER
--		do
--			set_is_initialized (False)
--			l_c_object := c_object
--			create upper_bar
--			create lower_bar

--			maximum_width := interface.maximum_dimension
--			maximum_height := interface.maximum_dimension

--			app_implementation.windows.extend (interface)

--			initialize_client_area

--			--default_height := -1
--			--default_width := -1

--			--Precursor {EV_CONTAINER_IMP}

--			--internal_is_border_enabled := True
--			--user_can_resize := True
--			set_is_initialized (True)
--		end

	make (an_interface: like interface)
--			-- Create empty dialog box.
		do
			Precursor {EV_TITLED_WINDOW_IMP}(an_interface)
		end

	initialize
--			-- Initialize 'Current'
		do
			Precursor {EV_TITLED_WINDOW_IMP}
		end

feature -- Status Report

	is_closeable: BOOLEAN
			-- Is the window closeable by the user?
		do
		end

	is_relative: BOOLEAN
			-- Is `Current' shown relative to another window?
		do
		end

feature -- Status Setting

	enable_closeable
			-- Set the window to be closeable by the user
		do
		end

	disable_closeable
			-- Set the window not to be closeable by the user
		do
		end

feature {NONE} -- Implementation

	client_area: POINTER
			-- Pointer to the widget that is treated as the main holder of the client area within the window.
		do
		end

	dialog_key_press_action (a_key: EV_KEY)
		do
		end

	set_closeable (new_status: BOOLEAN)
			-- Set `is_closeable' to `new_status'
		do
		end

	call_close_request_actions
			-- Call the cancel actions if dialog is closeable.
		do
			Precursor
		end

	interface: EV_DIALOG
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

	is_dialog_closeable: BOOLEAN;
			-- Temporary flag whose only use is to enable functions
			-- `is_closeable', `enable_closeable' and `disable_closeable'
			-- to be executed without raising zillions of assertion violations.
			--| FIXME implement cited function, then remove me.

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_DIALOG_IMP

