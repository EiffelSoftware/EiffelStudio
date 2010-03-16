note

	description: 
		"Motif Label Gadget."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_LABEL_GADGET

inherit

	MEL_LABEL_GADGET_RESOURCES
		export
			{NONE} all
		end;

	MEL_FONTABLE;

	MEL_GADGET

create 
	make, 
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN)
			-- Create a motif label gadget.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_label_gadget (a_parent.screen_object, $widget_name, default_pointer, 0);
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

feature -- Status report

	label_as_string: STRING
			-- Text of current label
		require
			exists: not is_destroyed
		local
			temp: MEL_STRING
		do 
			temp := get_xm_string (screen_object, XmNlabelString);
			Result := temp.to_eiffel_string;
			temp.destroy
		ensure
			text_not_void: Result /= Void
		end;

	label_string: MEL_STRING
			-- Text of current label
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNlabelString)
		ensure
			label_not_void: Result /= Void
		end;

	accelerator: STRING
			-- Accelerator of label
		require
			exists: not is_destroyed;	
		do
			Result := get_xt_string (screen_object, XmNaccelerator)
		ensure
			accelerator_not_void: Result /= Void
		end;

	accelerator_text: MEL_STRING
			-- Accelerator text of label
		require
			exists: not is_destroyed;	
		do
			Result := get_xm_string (screen_object, XmNacceleratorText)
		ensure
			accelerator_text_not_void: Result /= Void
		end;

	beginning_alignment: BOOLEAN
			-- Is the text alignment to beginning?
		require
			exists: not is_destroyed
		do
			Result := alignment = XmALIGNMENT_BEGINNING
		end;

	center_alignment: BOOLEAN
			-- Is the text alignment to center?
		require
			exists: not is_destroyed
		do
			Result := alignment = XmALIGNMENT_CENTER
		end;

	end_alignment: BOOLEAN
			-- Is the text alignment to end?
		require
			exists: not is_destroyed
		do
			Result := alignment = XmALIGNMENT_END
		end;

	is_recomputing_size_allowed: BOOLEAN
			-- Is the label allowed to recompute its size?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNrecomputeSize)
		end

	insensitive_pixmap: MEL_PIXMAP
			-- Insensitive pixmap of label
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNlabelInsensitivePixmap)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	pixmap: MEL_PIXMAP
			-- Pixmap of the label
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNlabelPixmap)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	is_type_string: BOOLEAN
			-- Is the type of the label a String?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNlabelType) = XmSTRING
		end;

	is_type_pixmap: BOOLEAN
			-- Is the type of the label a Pixmap?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNlabelType) = XmPIXMAP
		end;

	margin_bottom: INTEGER
			-- Amount of space between the bottom side of the text and
			-- the nearest margin
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginBottom)
		ensure
			margin_bottom_large_enough: Result >= 0
		end;

	margin_top: INTEGER
			-- Amount of space between the top side of the text and
			-- the nearest margin
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginTop)
		ensure
			margin_top_large_enough: Result >= 0
		end;

	margin_left: INTEGER
			-- Amount of space between the left side of the text and
			-- the nearest margin
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginLeft)
		ensure
			margin_left_large_enough: Result >= 0
		end;
 
	margin_right: INTEGER
			-- Amount of space between the right side of the text and
			-- the nearest margin
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginRight)
		ensure
			margin_right_large_enough: Result >= 0
		end;

	margin_height: INTEGER
			-- Spacing between one side of the label and the
			-- nearest edge of a shadow
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginHeight)
		ensure
			margin_height_large_enough: Result >= 0
		end;
 
	margin_width: INTEGER
			-- Spacing between one side of the label and the
			-- nearest edge of a shadow
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginWidth)
		ensure
			margin_width_large_enough: Result >= 0
		end;

	mnemonic_char_set: STRING
			-- Character set for the label's mnemonic
		require
			exists: not is_destroyed
		do
			Result := get_xt_string (screen_object, XmNmnemonicCharSet)
		end;

	mnemonic: CHARACTER
			-- Keysym of the key to press in order to post the pulldown
			-- menu associated with an option menu
		require
			exists: not is_destroyed
		do
			Result := get_xt_keysym (screen_object, XmNmnemonic)
		end;

	is_string_direction_l_to_r: BOOLEAN
			-- Is the string directory in which to draw the string left to right?		
		require
			exists: not is_destroyed
		do
			Result := get_xm_string_direction (screen_object, XmNstringDirection) = XmSTRING_DIRECTION_L_TO_R
		end;

feature -- Status setting

	set_label_as_string (a_text: STRING)
			-- Set `label_as_string' to `a_text'.
			--| Interpret `%N' in `a_text'.
		require
			exists: not is_destroyed;
			not_a_text_void: a_text /= Void
		local
			compound_string: MEL_STRING
		do
			create compound_string.make_default_l_to_r (a_text);
			set_xm_string (screen_object, XmNlabelString, compound_string);
			compound_string.destroy
		ensure
			text_set: label_as_string.is_equal (a_text)
		end;

	set_label_string (a_compound_string: MEL_STRING)
			-- Set `a_compound_string' to `a_text'.
		require
			exists: not is_destroyed;
			a_compound_string_exists: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNlabelString, a_compound_string);
		ensure
			label_set: label_string.is_equal (a_compound_string)
		end;

	set_accelerator (a_text: STRING)
			-- Set `accelerator' to `a_text'.
		require
			exists: not is_destroyed;	
			not_a_text_void: a_text /= Void
		do
			set_xt_string (screen_object, XmNaccelerator, a_text)
		ensure
			accelerator_set: accelerator.is_equal (a_text)
		end;

	set_accelerator_text (a_compound_string: MEL_STRING)
			-- Set `accelerator_text' to `a_text'.
		require
			exists: not is_destroyed;	
			a_compound_string_exists: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNacceleratorText, a_compound_string)
		ensure
			accelerator_text_set: accelerator_text.is_equal (a_compound_string)
		end;

	allow_recompute_size
			-- Set `is_recomputing_size_allowed' to `True'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNrecomputeSize, True)
		ensure
			recompute_size_allowed: is_recomputing_size_allowed
		end;

	forbid_recompute_size
			-- Set `is_recomputing_size_allowed' to `False'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNrecomputeSize, False)
		ensure
			recompute_size_not_allowed: not is_recomputing_size_allowed
		end;

	set_beginning_alignment
			-- Set text alignment to beginning.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNalignment, XmALIGNMENT_BEGINNING)
		ensure
			beginning_alignment_set: beginning_alignment
		end;

	set_center_alignment
			-- Set text alignment to center.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNalignment, XmALIGNMENT_CENTER)
		ensure
			center_alignment_set: center_alignment
		end;

	set_end_alignment
			-- Set text alignment to end.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNalignment, XmALIGNMENT_END)
		ensure
			end_alignment_set: end_alignment
		end;

	set_insensitive_pixmap (a_pixmap: MEL_PIXMAP)
			-- Set `insensitive_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			same_depth: parent.depth = a_pixmap.depth;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNlabelInsensitivePixmap, a_pixmap)
		ensure
			insensitive_pixmap_set: insensitive_pixmap.is_equal (a_pixmap)
		end;

	set_pixmap (a_pixmap: MEL_PIXMAP)
			-- Set `pixmap' to a `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			same_depth: parent.depth = a_pixmap.depth;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNlabelPixmap, a_pixmap)
		ensure
			pixmap_set: pixmap.is_equal (a_pixmap)
		end;

	set_type_string
			-- Set the type of the label to a String.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNlabelType, XmSTRING)
		ensure
			type_set: is_type_string
		end;

	set_type_pixmap
			-- Set the type of the label to Pixmap.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNlabelType, XmPIXMAP)
		ensure
			type_set: is_type_pixmap
		end;

	set_margin_bottom (a_value: INTEGER)
			-- Set `margin_bottom' to `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value >= 0
		do
			set_xt_dimension (screen_object, XmNmarginBottom, a_value)
		ensure
			value_set: margin_bottom = a_value
		end;

	set_margin_top (a_value: INTEGER)
			-- Set `margin_top' to `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value >= 0
		do
			set_xt_dimension (screen_object, XmNmarginTop, a_value)
		ensure
			value_set: margin_top = a_value
		end;

	set_margin_left (a_value: INTEGER)
			-- Set `margin_left' to `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value >= 0
		do
			set_xt_dimension (screen_object, XmNmarginLeft, a_value)
		ensure
			value_set: margin_left = a_value
		end;

	set_margin_right (a_value: INTEGER)
			-- Set `margin_right' to `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value >= 0
		do
			set_xt_dimension (screen_object, XmNmarginRight, a_value)
		ensure
			value_set: margin_right = a_value
		end;

	set_margin_height (a_value: INTEGER)
			-- Set `margin_height' to `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value >= 0
		do
			set_xt_dimension (screen_object, XmNmarginHeight, a_value)
		ensure
			value_set: margin_height = a_value
		end;

	set_margin_width (a_value: INTEGER)
			-- Set `margin_right' to `a_value'.
		require
			exists: not is_destroyed;
			a_value_large_enough: a_value >= 0
		do
			set_xt_dimension (screen_object, XmNmarginWidth, a_value)
		ensure
			value_set: margin_right = a_value
		end;

	set_string_direction_l_to_r
			-- Set the direction in which to draw the string to left to right.
		require
			exists: not is_destroyed
		do
			set_xm_string_direction (screen_object, XmNstringDirection, XmSTRING_DIRECTION_L_TO_R)
		ensure
			string_direction_set: is_string_direction_l_to_r
		end;

	set_string_direction_r_to_l
			-- Set the direction in which to draw the string to right to left.
		require
			exists: not is_destroyed
		do
			set_xm_string_direction (screen_object, XmNstringDirection, XmSTRING_DIRECTION_R_TO_L)
		ensure
			string_direction_set: not is_string_direction_l_to_r
		end;

	set_mnemonic (a_character: CHARACTER)
			-- Set `mnemonic'.
		require
			exists: not is_destroyed
		do
			set_xt_keysym (screen_object, XmNmnemonic, a_character)
		ensure
			set: mnemonic = a_character
		end;

	set_mnemonic_char_set (a_string: STRING)
			-- Set `mnemonic_char_set'.
		require
			exists: not is_destroyed
		do
			set_xt_string (screen_object, XmNmnemonicCharSet, a_string)
		ensure
			set: mnemonic_char_set.is_equal (a_string)
		end;

feature {NONE} -- Implementation

	alignment: INTEGER
			-- Current alignment of the label
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNalignment)
		end;

	xm_create_label_gadget (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/LabelG.h>"
		alias
			"XmCreateLabelGadget"
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




end -- class MEL_LABEL_GADGET


