note

	description:
			"Constraint widget that tiles its children vertically."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_PANED_WINDOW

inherit

	MEL_PANED_WINDOW_RESOURCES
		export
			{NONE} all
		end;

	MEL_MANAGER
		redefine
			is_paned_window
		end

create 
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN)
			-- Create a motif paned window widget.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent
			widget_name := a_name.to_c
			screen_object := xm_create_paned_window (a_parent.screen_object, $widget_name, default_pointer, 0)
			Mel_widgets.add (Current)
			set_default
			if do_manage then
				manage
			end			
		ensure
			exists: not is_destroyed;
			parent_set: parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature -- Access

	is_paned_window: BOOLEAN = True
			-- Is Current a paned window?

feature -- Status report

	margin_height: INTEGER
			-- Spacing between the top or the bottom of Current's children
			-- and Current's shadow
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginHeight)
		ensure
			margin_height_large_enough: Result >= 0
		end;

	margin_width: INTEGER
			-- Spacing between the left or right of Current's children
			-- and Current's shadow
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginWidth)
		ensure
			margin_width_large_enough: Result >= 0
		end;

	is_refigure_mode: BOOLEAN
			-- Are the children set to their appropriate position after
			-- a change in Current?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNrefigureMode)
		end;

	sash_height: INTEGER
			-- Height of the sash
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNsashHeight)
		ensure
			sash_heighth_large_enough: Result >= 0
		end;

	sash_width: INTEGER
			-- Width of the sash
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNsashWidth)
		ensure
			sash_width_large_enough: Result >= 0
		end;

	sash_indent: INTEGER
			-- Horizontal position of the sash along each pane
		require
			exists: not is_destroyed
		do
			Result := get_xt_position (screen_object, XmNsashIndent)
		end;

	sash_shadow_thickness: INTEGER
			-- The thickness of the shadow drawn on each sash
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNsashShadowThickness)
		ensure
			sash_shadow_thickness_large_enough: Result >= 0
		end;

	is_separator_on: BOOLEAN
			-- Is a separator (gadget) placed between each pane
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNseparatorOn)
		end;

	spacing: INTEGER
			-- The distance between each pane child
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNspacing)
		ensure
			spacing_large_enough: Result >= 0
		end;

feature -- Status setting

	set_margin_height (a_height: INTEGER)
			-- Set `margin_height' to `a_height'.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNmarginHeight, a_height)
		ensure
			margin_height_set: margin_height = a_height
		end;

	set_margin_width (a_width: INTEGER)
			-- Set `margin_width' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNmarginWidth, a_width)
		ensure
			margin_width_set: margin_width = a_width
		end;

	enable_refigure_mode
			-- Set `is_refigure_mode' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNrefigureMode, True)
		ensure
			refigure_mode_enabled: is_refigure_mode 
		end;

	disable_refigure_mode
			-- Set `is_refigure_mode' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNrefigureMode, False)
		ensure
			refigure_mode_disabled: not is_refigure_mode 
		end;

	set_sash_height (a_height: INTEGER)
			-- Set `sash_height' to `a_height'.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNsashHeight, a_height)
		ensure
			sash_height_set: sash_height = a_height
		end;

	set_sash_width (a_width: INTEGER)
			-- Set `sash_width' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNsashWidth, a_width)
		ensure
			sash_width_set: sash_width = a_width
		end;

	set_sash_indent (a_position: INTEGER)
			-- Set `sash_indent' to `a_position'.
		require
			exists: not is_destroyed
		do
			set_xt_position (screen_object, XmNsashIndent, a_position)
		ensure
			sash_indent_set: sash_indent = a_position
		end;

	set_sash_shadow_thickness (a_thickness: INTEGER)
			-- Set `sash_shadow_thickness' to `a_thickness'.
		require
			exists: not is_destroyed;
			a_thickness_large_enough: a_thickness >= 0
		do
			set_xt_dimension (screen_object, XmNsashShadowThickness, a_thickness)
		ensure
			sash_shadow_thickness_set: sash_shadow_thickness = a_thickness
		end;

	enable_separator
			-- Set `is_separator_on' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNseparatorOn, True)
		ensure
			separator_enabled: is_separator_on 
		end;

	disable_separator
			-- Set `is_separator_on' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNseparatorOn, False)
		ensure
			separator_disabled: not is_separator_on 
		end;

	set_spacing (a_distance: INTEGER)
			-- Set `spacing' to `a_distance'.
		require
			exists: not is_destroyed;
			a_distance_large_enough: a_distance >= 0 
		do
			set_xt_dimension (screen_object, XmNspacing, a_distance)
		ensure
			spacing_set: spacing = a_distance
		end;

	set_vertical
		do
			set_xt_unsigned_char (screen_object,XmNorientation, XmVertical)
		end

	set_horizontal
		do
			set_xt_unsigned_char (screen_object,XmNorientation, XmHorizontal)
		end

feature {NONE} -- Implementation

	xm_create_paned_window (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/PanedW.h>"
		alias
			"XmCreatePanedWindow"
		end;

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




end -- class MEL_PANED_WINDOW


