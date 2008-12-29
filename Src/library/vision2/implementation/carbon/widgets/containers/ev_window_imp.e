note
	description: "Eiffel Vision window. Carbon implementation."

class
	EV_WINDOW_IMP

inherit
	EV_WINDOW_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			x_position,
			y_position,
			screen_x,
			screen_y,
			width,
			height,
			is_parentable,
			show,
			hide
		redefine
			interface,
			initialize,
			is_sensitive,
			make,
			on_key_event,
			hide,
			internal_set_minimum_size,
			on_widget_mapped,
			destroy,
			has_focus,
			on_focus_changed,
			on_event,
			child_has_resized,
			layout,
			calculate_minimum_sizes
		end

	EV_CARBON_WINDOW_IMP
		undefine
			initialize,
			destroy,
			parent_imp,
			minimum_width,
			minimum_height
		redefine
			interface,
			on_key_event,
			has_focus,
			show,
			set_size,
			hide
		end

	EV_WINDOW_ACTION_SEQUENCES_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create the window.
		local
			window_attributes: INTEGER
			rect: RECT_STRUCT
			res: INTEGER
			ptr: POINTER
			root_control_ptr : POINTER
			target: POINTER
			h_ret: POINTER
		do
			base_make (an_interface)
			create rect.make_new_shared

			rect.set_bottom (200)
			rect.set_left (45)
			rect.set_right (600)
			rect.set_top (45)
			window_attributes := ({MACWINDOWS_ANON_ENUMS}.kWindowLiveResizeAttribute).bit_or(
									{MACWINDOWS_ANON_ENUMS}.kWindowStandardDocumentAttributes).bit_or(
									{MACWINDOWS_ANON_ENUMS}.kWindowStandardFloatingAttributes).bit_or(
									{MACWINDOWS_ANON_ENUMS}.kWindowStandardHandlerAttribute).bit_or(
									{MACWINDOWS_ANON_ENUMS}.kWindowInWindowMenuAttribute).bit_or(
									{MACWINDOWS_ANON_ENUMS}.kWindowCompositingAttribute)

			res := create_new_window_external({MACWINDOWS_ANON_ENUMS}.kdocumentwindowclass, window_attributes, rect.item, $ptr)
			res := create_root_control_external( ptr, $root_control_ptr )
			set_c_object (ptr)
			allow_resize

			event_id := app_implementation.get_id (current)  --getting an id from the application
			target := get_window_event_target_external(ptr)
			h_ret := app_implementation.install_event_handler (event_id, target, {CARBONEVENTS_ANON_ENUMS}.kEventClassWindow, {CARBONEVENTS_ANON_ENUMS}.kEventWindowClose)
		end

	initialize
			-- Create the vertical box `vbox' and horizontal box `hbox'
			-- to put in the window.
			-- The `vbox' will be able to contain the menu bar, the `hbox'
			-- and the status bar.
			-- The `hbox' will contain the child of the window.
		local
			l_c_object: POINTER
		do
			set_is_initialized (False)
			l_c_object := c_object
			create upper_bar
			create lower_bar

			maximum_width := interface.maximum_dimension
			maximum_height := interface.maximum_dimension

			app_implementation.windows.extend (interface)

			initialize_client_area

			default_height := -1
			default_width := -1

			Precursor {EV_CONTAINER_IMP}

			internal_is_border_enabled := True
			user_can_resize := True
			create title.make_empty
			set_is_initialized (True)
		end

feature  -- Access

	is_sensitive: BOOLEAN
			--
		do
			Result := True
		end


	has_focus: BOOLEAN
			-- Does `Current' have the keyboard focus?
		do
			Result := is_window_active_external (c_object) /= 0
		end

	item: EV_WIDGET
			-- Current item.

 	maximum_width: INTEGER
			-- Maximum width that application wishes widget
			-- instance to have.

	maximum_height: INTEGER
			-- Maximum height that application wishes widget
			-- instance to have.

	title: STRING_32
			-- Application name to be displayed by
			-- the window manager.

	menu_bar: EV_MENU_BAR
			-- Horizontal bar at top of client area that contains menu's.

feature -- Status setting

	disconnect_accelerator (an_accel: EV_ACCELERATOR)
			-- Disconnect key combination `an_accel' from this window.
		do
		end

	connect_accelerator (an_accel: EV_ACCELERATOR)
			-- Disconnect key combination `an_accel' from this window.
		do
		end

	internal_disable_border
			-- Ensure no border is displayed around `Current'.
		do
		end

	internal_enable_border
			-- Ensure a border is displayed around `Current'.
		do
		end

	block
			-- Wait until window is closed by the user.
		local
			app: EV_APPLICATION_IMP
		do
			from
				app := app_implementation
			until
				is_destroyed or else not is_displayed
			loop
				app.process_events
			end
		end

	allow_resize
			do
				enable_user_resize
			end


	enable_user_resize
			-- Allow the resize of the window.
		local
			res: INTEGER
		do
			res := change_window_attributes_external (c_object, {MACWINDOWS_ANON_ENUMS}.kwindowresizableattribute, {MACWINDOWS_ANON_ENUMS}.kwindownoattributes)
			internal_enable_border
		end


	disable_user_resize
			-- disable the resize of the window.
		local
			res: INTEGER
		do
			res := change_window_attributes_external (c_object, {MACWINDOWS_ANON_ENUMS}.kwindownoattributes, {MACWINDOWS_ANON_ENUMS}.kwindowresizableattribute)
			internal_disable_border
		end


	show
			-- Map the Window to the screen.
		do
			if not is_show_requested then
				call_show_actions := True
				is_positioned := True
			end
			if blocking_window /= Void then
				set_blocking_window (Void)
			end
			internal_set_minimum_size (minimum_width, minimum_height) -- Make sure the window is at least as big as the minimum of all controls in it requires
			show_window_external (c_object)
		end

	is_positioned: BOOLEAN
		-- Has the Window been previously positioned on screen?

	call_show_actions: BOOLEAN
		-- Should the show actions be called?

	hide
			-- Unmap the Window from the screen.
		do
		end

feature -- Element change

	on_attach: ACTION_SEQUENCE [TUPLE]

	replace (v: like item)
			-- Replace `item' with `v'.
		local
			w_imp: EV_WIDGET_IMP
			root_control_ptr : POINTER
			err : INTEGER
		do
			-- Remove current item, if any
			if item /= Void then
				w_imp ?= item.implementation
				check
					item_has_implementation: w_imp /= Void
				end
				on_removed_item ( w_imp )
			--	dispose_control_external ( w_imp.c_object ) why should we do this?
			end
			-- Insert new item, if any
			if v /= Void then
				w_imp ?= v.implementation
				check
					v_has_implementation: v /= Void
				end
				err := get_root_control_external ( c_object, $root_control_ptr )
				err := hiview_add_subview_external ( root_control_ptr, w_imp.c_object )

				setup_window_binding( w_imp.c_object )
				on_new_item ( w_imp )
			end
			item := v
		end

	child_has_resized (a_widget_imp: EV_WIDGET_IMP; a_height, a_width: INTEGER)
			--
		do

				setup_layout

		end


	layout
				-- Sets the child control's size to the container site minus some spacing
		local
			ret: INTEGER
			a_widget : EV_WIDGET_IMP
		do
				a_widget := temp_item
				if a_widget = void and then item /= void then
					a_widget ?= item.implementation
				end
					check
						no_imp: a_widget /= void
					end

			--	set_size (a_widget.minimum_width + child_offset_left + child_offset_right, a_widget.minimum_height + child_offset_bottom + child_offset_top)
				calculate_minimum_sizes
			temp_item := void
		end

		calculate_minimum_sizes
		do
			if temp_item /= void then
				buffered_minimum_width := (temp_item.minimum_width + child_offset_left + child_offset_right).max(internal_minimum_width)
				buffered_minimum_height := (temp_item.minimum_height + child_offset_top + child_offset_bottom).max(internal_minimum_height)
			elseif item /= void then
					buffered_minimum_width := (item.minimum_width + child_offset_left + child_offset_right).max(internal_minimum_width)
					buffered_minimum_height := (item.minimum_height + child_offset_top + child_offset_bottom).max(internal_minimum_height)
			else
					buffered_minimum_width := internal_minimum_width.max (child_offset_left + child_offset_right)
					buffered_minimum_height := internal_minimum_height.max (child_offset_top + child_offset_bottom)
			end
		end

	setup_window_binding (a_control : POINTER)
			-- Align the main_container to the window size
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					HILayoutInfo LayoutInfo;
					LayoutInfo.version = kHILayoutInfoVersionZero;
					HIViewGetLayoutInfo( $a_control, &LayoutInfo );
					
					LayoutInfo.scale.x.toView = NULL;
					LayoutInfo.scale.x.kind = kHILayoutScaleAbsolute;
					LayoutInfo.scale.x.ratio = 1.0;
					
					LayoutInfo.scale.y.toView = NULL;
					LayoutInfo.scale.y.kind = kHILayoutScaleAbsolute;
					LayoutInfo.scale.y.ratio = 1.0;
					
					LayoutInfo.position.x.toView = NULL;
					LayoutInfo.position.x.kind = kHILayoutPositionLeft;
					LayoutInfo.position.x.offset = 0.0;
					
					LayoutInfo.position.y.toView = NULL;
					LayoutInfo.position.y.kind = kHILayoutPositionTop;
					LayoutInfo.position.y.offset = 0.0;
					
					HIViewSetLayoutInfo( $a_control, &LayoutInfo );
					HIViewApplyLayout( $a_control );
				}
			]"
		end

	set_maximum_width (max_width: INTEGER)
			-- Set `maximum_width' to `max_width'.
		do
			maximum_width := max_width
		end

	set_maximum_height (max_height: INTEGER)
			-- Set `maximum_height' to `max_height'.
		do
			maximum_height := max_height
		end

		set_size (a_width, a_height: INTEGER)
			-- Set the horizontal size to `a_width'.
			-- Set the vertical size to `a_height'.
		do
			set_width (a_width)
			set_height (a_height)
		end

	set_title (new_title: STRING_GENERAL)
			-- Set `title' to `new_title'.
		local
			res: INTEGER
			cfstring: EV_CARBON_CF_STRING
		do
			create cfstring.make_unshared_with_eiffel_string (new_title)
			res := set_window_title_with_cfstring_external (c_object, cfstring.item)
			title := new_title
		end

	set_menu_bar (a_menu_bar: EV_MENU_BAR)
			-- Set `menu_bar' to `a_menu_bar'.
		local
			mb_imp: EV_MENU_BAR_IMP
		do
			menu_bar := a_menu_bar
			mb_imp ?= menu_bar.implementation
			mb_imp.set_parent_window_imp (Current)
			-- TODO attach the menubar to the current window / application in carbon
		end

	remove_menu_bar
			-- Set `menu_bar' to `Void'.
		local
			mb_imp: EV_MENU_BAR_IMP
		do
			if menu_bar /= Void then
				mb_imp ?= menu_bar.implementation
				mb_imp.remove_parent_window
				-- TODO: remove the menubar in carbon
			end
			menu_bar := Void
		end

feature {EV_ANY_IMP} -- Implementation

	destroy
			-- Destroy `Current'
			-- 19.6.2006 Ueli
		do
			disable_capture
			hide
			Precursor {EV_CONTAINER_IMP}
		end

feature {NONE} -- Implementation

	on_widget_mapped
			-- `Current' has been mapped to the screen.
			-- 19.6.06 Ueli
		do
			if show_actions_internal /= Void and call_show_actions then
				show_actions_internal.call (Void)
			end
			call_show_actions := False
		end

	internal_set_minimum_size (a_minimum_width, a_minimum_height: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width'.
			-- Set the minimum vertical size to `a_minimum_height'.
		local
			hisize: CGSIZE_STRUCT
			ret: INTEGER
		do
			Precursor {EV_CONTAINER_IMP} (a_minimum_width, a_minimum_height)
			create hisize.make_new_unshared
			hisize.set_width (a_minimum_width.to_real)
			hisize.set_height (a_minimum_height.to_real)
			ret := set_window_resize_limits_external (c_object, hisize.item, null)
			if width < a_minimum_width then
				set_width (a_minimum_width)
			end
			if height < a_minimum_height then
				set_height (a_minimum_height)
			end
		end

	set_focused_widget (a_widget: EV_WIDGET_IMP)
			-- Set currently focused widget to `a_widget'.
		do
		end

	on_focus_changed (a_has_focus: BOOLEAN)
			-- Called from focus intermediary agents when focus for `Current' has changed.
			-- if `a_has_focus' then `Current' has just received focus.
		do
			if a_has_focus then
				on_set_focus_event (get_user_focus_window_external)
			else
				on_set_focus_event (default_pointer)
			end
			Precursor {EV_CONTAINER_IMP} (a_has_focus)
		end

	previous_x_position, previous_y_position: INTEGER
		-- Positions of previously set x and y coordinates of `Current'.

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN)
			-- Used for key event actions sequences.
		do
		end

	client_area: POINTER
			-- Pointer to the widget that is treated as the main holder of the client area within the window.
		do
		end

	initialize_client_area
			-- Initialize the client area of 'Current'.
		do
			-- TODO: init vbox/hbox?
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_set_focus_event (a_widget_ptr: POINTER)
			-- The focus of a widget has changed within `Current'.
		do
		end

	on_event (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER
			-- Feature that is called if an event occurs
		local
			event_class, event_kind : INTEGER
		do
				event_class := get_event_class_external (a_inevent)
				event_kind := get_event_kind_external (a_inevent)

				if event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassWindow and event_kind = {CARBONEVENTS_ANON_ENUMS}.kEventWindowClose then
					close_request_actions.call (void)
					Result := noErr -- event handled
				else
					Result := {CARBON_EVENTS_CORE_ANON_ENUMS}.eventnothandlederr
				end
		end


feature {EV_INTERMEDIARY_ROUTINES}

	call_close_request_actions
			-- Call the close request actions.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_WINDOW;
		-- Interface object of `Current'

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_WINDOW_IMP

