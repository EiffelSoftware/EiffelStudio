note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CARBON_WIDGET_IMP

inherit
	EV_ANY_IMP

	HIVIEW_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	HIGEOMETRY_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CONTROLS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

feature -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN)
			-- Used for key event actions sequences, redefined by descendants
		do
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	is_parentable: BOOLEAN
			-- May Current be parented?
		do
		end

feature {NONE} -- Implementation

	initialize
			-- Initialize `c_object'
		do
			set_is_initialized (True)
		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	screen_x: INTEGER
			-- Horizontal position of the client area on screen,
		local
			err : INTEGER
			rect : CGRECT_STRUCT
			point : CGPOINT_STRUCT
		do
			-- Get the relative coordinates in the parent view and call HIPointConvert to get screen coordinates
			create rect.make_new_unshared
			err := hiview_get_frame_external ( c_object, rect.item )
			create point.make_shared (rect.origin)
			hipoint_convert_external (point.item, 4, c_object, 2, null)
			Result := point.x.rounded
		end

	screen_y: INTEGER
			-- Vertical position of the client area on screen,
		local
			err : INTEGER
			rect : CGRECT_STRUCT
			point : CGPOINT_STRUCT
		do
			-- Get the relative coordinates in the parent view and call HIPointConvert to get screen coordinates
			create rect.make_new_unshared
			err := hiview_get_frame_external ( c_object, rect.item )
			create point.make_shared (rect.origin)
			hipoint_convert_external (point.item, 4, c_object, 2, null)
			Result := point.y.rounded
		end

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position'.
			-- Unit of measurement: screen pixels.
		local
			err : INTEGER
			rect : CGRECT_STRUCT
			origin : CGPOINT_STRUCT
		do
			create rect.make_new_unshared
			create origin.make_shared ( rect.origin )
			err := hiview_get_frame_external ( c_object, rect.item )
			Result := origin.x.rounded
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position'.
			-- Unit of measurement: screen pixels.
		local
			err : INTEGER
			rect : CGRECT_STRUCT
			origin : CGPOINT_STRUCT
		do
			create rect.make_new_unshared
			create origin.make_shared ( rect.origin )
			err := hiview_get_frame_external ( c_object, rect.item )
			Result := origin.y.rounded
		end

	minimum_width, real_minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		local
			minimum_size : CGSIZE_STRUCT
			maximum_size : CGSIZE_STRUCT
			rect : RECT_STRUCT
			y : INTEGER
			err : INTEGER
		do
			create maximum_size.make_new_unshared
			create minimum_size.make_new_unshared
			err := hiview_get_size_constraints_external ( c_object, minimum_size.item, maximum_size.item )
			Result := minimum_size.width.rounded.max (1)
		end

	minimum_height, real_minimum_height: INTEGER
			-- Minimum width that the widget may occupy.
		local
			minimum_size : CGSIZE_STRUCT
			maximum_size : CGSIZE_STRUCT
			rect : RECT_STRUCT
			y : INTEGER
			err : INTEGER
		do
			create maximum_size.make_new_unshared
			create minimum_size.make_new_unshared
			err := hiview_get_size_constraints_external ( c_object, minimum_size.item, maximum_size.item )
			Result := minimum_size.height.rounded.max(1)
		end


feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	widget_imp_at_pointer_position: EV_WIDGET_IMP
			-- Widget implementation at current mouse pointer position (if any)
		do
		end

	set_pointer_style (a_cursor: EV_POINTER_STYLE)
			-- Assign `a_cursor' to `pointer_style'.
		do
		end

	set_focus
			-- Grab keyboard focus.
		local
			window : POINTER
			err : INTEGER
		do
			-- This needs to be redefined for every widget, because the focus part has to be selected,
			-- which is different for every widget

			--window := hiview_get_window_external ( c_object )
			--err := set_keyboard_focus_external ( window, c_object, {CONTROLS_ANON_ENUMS}.kcontrolentirecontrol )
		end

	internal_set_pointer_style (a_cursor: EV_POINTER_STYLE)
			-- Assign `a_cursor' to `pointer_style', used for PND
		do
		end

	pointer_style: EV_POINTER_STYLE
			-- Cursor displayed when the pointer is over this widget.
			-- Position retrieval.

	has_focus: BOOLEAN
			-- Does widget have the keyboard focus?
		do
		end

	width: INTEGER
			-- Horizontal size measured in pixels.
		local
			a_rect : CGRECT_STRUCT
			a_size : CGSIZE_STRUCT
			err : INTEGER
		do
			create a_rect.make_new_unshared
			err := hiview_get_frame_external ( c_object, a_rect.item )
			create a_size.make_shared ( a_rect.size )
			Result := a_size.width.rounded

			Result := Result.max( minimum_width )
		end

	height: INTEGER
			-- Vertical size measured in pixels.
		local
			a_rect : CGRECT_STRUCT
			a_size : CGSIZE_STRUCT
			err : INTEGER
		do
			create a_rect.make_new_unshared
			err := hiview_get_frame_external ( c_object, a_rect.item )
			create a_size.make_shared ( a_rect.size )
			Result := a_size.height.rounded

			Result := Result.max (minimum_height)
		end

	show
			-- Request that `Current' be displayed when its parent is.
		do
		end

feature --{EV_BOX_IMP} --Box specific

	expandable : BOOLEAN

	set_expandable ( value : BOOLEAN )
			-- set expandable
		do
			expandable := value
		end

feature -- Helper features

	get_control_data_boolean (incontrol: POINTER; inpart: INTEGER; intagname: INTEGER): BOOLEAN
			-- get a boolean value with get_control_data
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
				 	Boolean temp = false;
					GetControlData( $incontrol, $inpart, $intagname, sizeof(temp), &temp, NULL );
					return temp;
				}
			]"
		end

		set_control_data_boolean (incontrol: POINTER; inpart: INTEGER; intagname: INTEGER;  value : BOOLEAN): INTEGER
			-- set a boolean value with set_control_data
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
				 	Boolean temp = $value;
					return SetControlData( $incontrol, $inpart, $intagname, sizeof(temp), &temp );
				}
			]"
		end

feature -- Status report

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
		do
				Result := hiview_is_latently_visible_external ( c_object ).to_boolean
		end

note
	copyright:	"Copyright (c) 2007, The Eiffel.Mac Team"
end
