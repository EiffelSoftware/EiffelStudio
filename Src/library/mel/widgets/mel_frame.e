note

	description:
			"Manager widget that places a border around a single child."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FRAME

inherit

	MEL_FRAME_RESOURCES
		export
			{NONE} all
		end;

	MEL_MANAGER
		redefine
			is_frame
		end

create 
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN)
			-- Create a motif frame widget.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_frame (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			parent_set: parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature -- Access

	is_frame: BOOLEAN = True
			-- Is Current a frame?

feature -- Status report

	margin_height: INTEGER
			-- Spacing between the top or the bottom of a child
			-- and the shadow of Current
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginHeight)
		ensure
			margin_height_large_enough: Result >= 0
		end;

	margin_width: INTEGER
			-- Spacing between the left or right side of a child
			-- and the shadow of Current
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginWidth)
		ensure
			margin_width_large_enough: Result >= 0
		end;

	is_shadow_in: BOOLEAN
			-- Is Current widget appear inset?
		require
			exists: not is_destroyed
		do
			Result := (get_xt_unsigned_char 
					(screen_object, XmNshadowType) = XmSHADOW_IN) 
		end;

	is_shadow_out: BOOLEAN
			-- Is Current widget appear raised?
		require
			exists: not is_destroyed
		do
			Result := (get_xt_unsigned_char 
					(screen_object, XmNshadowType) = XmSHADOW_OUT)
		end;

	is_shadow_etched_in: BOOLEAN
			-- Does Current appear with a double line shadow inset?
		require
			exists: not is_destroyed
		do
			Result := (get_xt_unsigned_char 
						(screen_object, XmNshadowType) = XmSHADOW_ETCHED_IN) 
		end;

	is_shadow_etched_out: BOOLEAN
			-- Does Current appear with a double line shadow raised?
		require
			exists: not is_destroyed
		do
			Result := (get_xt_unsigned_char 
						(screen_object, XmNshadowType) = XmSHADOW_ETCHED_OUT)
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

	set_shadow_in
			-- Set `is_shadow_in' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_IN)
		ensure
			is_shadow_in: is_shadow_in 
		end;

	set_shadow_out
			-- Set `is_shadow_in' to False.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_OUT)
		ensure
			is_shadow_out: is_shadow_out 
		end;

	set_shadow_etched_in
			-- Set `is_shadow_etched_in' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_ETCHED_IN)
		ensure
			is_shadow_etched_in: is_shadow_etched_in
		end;

	set_shadow_etched_out
			-- Set `is_shadow_etched_out' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNshadowType, XmSHADOW_ETCHED_OUT)
		ensure
			is_shadow_etched_out: is_shadow_etched_out
		end;

feature {NONE} -- Implementation

	xm_create_frame (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/Frame.h>"
		alias
			"XmCreateFrame"
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




end -- class MEL_FRAME


