indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RICH_TEXT_IMP
	
inherit
	EV_RICH_TEXT_I
		undefine
			text_length
		redefine
			interface,
			next_change_of_character
		end

	EV_TEXT_IMP
		redefine
			interface,
			initialize
		end

create
	make
	
feature {NONE} -- Initialization

	initialize is
			-- Set up `Current'
		do
			create tab_positions
			tab_positions.internal_add_actions.extend (agent update_tab_positions)
			tab_positions.internal_remove_actions.extend (agent update_tab_positions)
			real_signal_connect (text_buffer, "mark_set", agent (app_implementation.gtk_marshal).text_buffer_mark_set_intermediary (object_id, ?, ?), agent (App_implementation.gtk_marshal).gtk_args_to_tuple)
			Precursor {EV_TEXT_IMP}
		end

	create_caret_move_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Create a caret move action sequence.
		do
			create Result
		end
			
	create_selection_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a selection change action sequence.
		do
			create Result
		end

	create_file_access_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Create a file access action sequence.
		do
			create Result
		end

feature {NONE} -- Implementation

	next_change_of_character (current_pos: INTEGER; a_text_length: INTEGER): INTEGER is
		local
			character_change: reference INTEGER
			range_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
		do
			character_change := 0
			range_info := internal_character_format_range_information (current_pos, a_text_length + 1, True, character_change)
			Result := character_change
		end

	initialize_for_saving is
			-- Initialize `Current' for save operations, by performing
			-- optimizations that prevent the control from slowing down due to
			-- unecessary optimizations.
		do
			-- Do nothing
		end
		
	complete_saving is
			-- Restore `Current' back to its default state before last call
			-- to `initialize_for_saving'.
		do
			-- Do nothing
		end

	initialize_for_loading is
			-- Initialize `Current' for load operations, by performing
			-- optimizations that prevent the control from slowing down due to
			-- unecessary optimizations.
		do
			-- Do nothing
		end
		
	complete_loading is
			-- Restore `Current' back to its default state before last call
			-- to `initialize_for_loading'.
		do
			-- Do nothing
		end
		
	font_char_set (a_font: EV_FONT): INTEGER is
			-- `Result' is char set of font `a_font'.
		do
			Result := 0
		end	

feature -- Status Report

	format_paragraph (start_line, end_line: INTEGER; format: EV_PARAGRAPH_FORMAT) is
			--  Apply paragraph formatting `format' to lines `start_line', `end_line' inclusive.
		local
			format_imp: EV_PARAGRAPH_FORMAT_IMP
		do
			format_imp ?= format.implementation
			modify_paragraph_internal (start_line, end_line, format_imp, format_imp.dummy_paragraph_format_range_information)
		end

	character_format_range_information (start_index, end_index: INTEGER): EV_CHARACTER_FORMAT_RANGE_INFORMATION is
			-- Formatting range information from caret position `start_index' to `end_index'.
			-- All attributes in `Result' are set to `True' if they remain consitent from `start_index' to
			--`end_index' and `False' otherwise.
			-- `Result' is a snapshot of `Current', and does not remain consistent as the contents
			-- are subsequently changed.
		do
			Result := internal_character_format_range_information (start_index, end_index, False, Void)
		end

	internal_character_format_range_information (start_index, end_index: INTEGER; abort_on_change: BOOLEAN; change_index: reference INTEGER): EV_CHARACTER_FORMAT_RANGE_INFORMATION is
			-- Formatting range information from caret position `start_index' to `end_index'.
			-- All attributes in `Result' are set to `True' if they remain consistent from `start_index' to
			--`end_index' and `False' otherwise.
			-- `Result' is a snapshot of `Current', and does not remain consistent as the contents
			-- are subsequently changed.
		local
			a_character_index: INTEGER
			a_text_iter: POINTER
			a_text_attributes: POINTER
			previous_text_attributes: POINTER
			previous_font_family, font_family: STRING
			non_contiguous_range_information: INTEGER
			font_family_contiguous: BOOLEAN
			a_change: BOOLEAN
			exit_loop: BOOLEAN
		do
			from
				font_family_contiguous := True
				a_character_index := start_index + 1
				a_text_iter := a_text_iter.memory_alloc (feature {EV_GTK_TEXT_ITER_STRUCT}.structure_size)
				feature {EV_GTK_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_text_iter.item, start_index - 1)
				previous_text_attributes := gtk_text_view_get_default_attributes (text_view)
				a_change := gtk_text_iter_get_attributes (a_text_iter.item, previous_text_attributes)
				a_text_attributes := gtk_text_view_get_default_attributes (text_view)
				create previous_font_family.make_from_c (feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_family (gtk_text_attributes_struct_font_description (previous_text_attributes)))
			until
				exit_loop or else a_character_index = end_index
			loop
				feature {EV_GTK_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_text_iter.item, a_character_index - 1)
	
				a_text_attributes := gtk_text_attributes_copy (previous_text_attributes)
				a_change := gtk_text_iter_get_attributes (a_text_iter.item, a_text_attributes)
				
				if font_family_contiguous then
					create font_family.make_from_c (feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_family (gtk_text_attributes_struct_font_description (a_text_attributes)))
					
					if not font_family.is_equal (previous_font_family) then
						non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_CHARACTER_FORMAT_CONSTANTS}.font_family)
						font_family_contiguous := False
					end
					previous_font_family := font_family	
				end
				
				if feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_style (gtk_text_attributes_struct_font_description (a_text_attributes)) /=
					feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_style (gtk_text_attributes_struct_font_description (previous_text_attributes)) then
						non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_CHARACTER_FORMAT_CONSTANTS}.font_shape)
				end

				if feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_weight (gtk_text_attributes_struct_font_description (a_text_attributes)) /=
					feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_weight (gtk_text_attributes_struct_font_description (previous_text_attributes)) then
						non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_CHARACTER_FORMAT_CONSTANTS}.font_weight)
				end

				if feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_size (gtk_text_attributes_struct_font_description (a_text_attributes)) /=
					feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_size (gtk_text_attributes_struct_font_description (previous_text_attributes)) then
						non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_CHARACTER_FORMAT_CONSTANTS}.font_height)
				end

				if feature {EV_GTK_EXTERNALS}.gdk_color_struct_red (gtk_text_appearance_struct_fg_color (gtk_text_attributes_struct_text_appearance (a_text_attributes))) /=
					feature {EV_GTK_EXTERNALS}.gdk_color_struct_red (gtk_text_appearance_struct_fg_color (gtk_text_attributes_struct_text_appearance (previous_text_attributes))) or else
					feature {EV_GTK_EXTERNALS}.gdk_color_struct_green (gtk_text_appearance_struct_fg_color (gtk_text_attributes_struct_text_appearance (a_text_attributes))) /=
					feature {EV_GTK_EXTERNALS}.gdk_color_struct_green (gtk_text_appearance_struct_fg_color (gtk_text_attributes_struct_text_appearance (previous_text_attributes))) or else
					feature {EV_GTK_EXTERNALS}.gdk_color_struct_blue (gtk_text_appearance_struct_fg_color (gtk_text_attributes_struct_text_appearance (a_text_attributes))) /=
					feature {EV_GTK_EXTERNALS}.gdk_color_struct_blue (gtk_text_appearance_struct_fg_color (gtk_text_attributes_struct_text_appearance (previous_text_attributes))) then
						non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_CHARACTER_FORMAT_CONSTANTS}.color)
				end
				
				if feature {EV_GTK_EXTERNALS}.gdk_color_struct_red (gtk_text_appearance_struct_bg_color (gtk_text_attributes_struct_text_appearance (a_text_attributes))) /=
					feature {EV_GTK_EXTERNALS}.gdk_color_struct_red (gtk_text_appearance_struct_bg_color (gtk_text_attributes_struct_text_appearance (previous_text_attributes))) or else
					feature {EV_GTK_EXTERNALS}.gdk_color_struct_green (gtk_text_appearance_struct_bg_color (gtk_text_attributes_struct_text_appearance (a_text_attributes))) /=
					feature {EV_GTK_EXTERNALS}.gdk_color_struct_green (gtk_text_appearance_struct_bg_color (gtk_text_attributes_struct_text_appearance (previous_text_attributes))) or else
					feature {EV_GTK_EXTERNALS}.gdk_color_struct_blue (gtk_text_appearance_struct_bg_color (gtk_text_attributes_struct_text_appearance (a_text_attributes))) /=
					feature {EV_GTK_EXTERNALS}.gdk_color_struct_blue (gtk_text_appearance_struct_bg_color (gtk_text_attributes_struct_text_appearance (previous_text_attributes))) then
						non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_CHARACTER_FORMAT_CONSTANTS}.background_color)
				end

				if gtk_text_appearance_struct_strikethrough (gtk_text_attributes_struct_text_appearance (a_text_attributes)) /=
					gtk_text_appearance_struct_strikethrough (gtk_text_attributes_struct_text_appearance (previous_text_attributes)) then
						non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_CHARACTER_FORMAT_CONSTANTS}.effects_striked_out)
				end

				if gtk_text_appearance_struct_underline (gtk_text_attributes_struct_text_appearance (a_text_attributes)) /=
					gtk_text_appearance_struct_underline (gtk_text_attributes_struct_text_appearance (previous_text_attributes)) then
						non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_CHARACTER_FORMAT_CONSTANTS}.effects_underlined)
				end

				if gtk_text_appearance_struct_rise (gtk_text_attributes_struct_text_appearance (a_text_attributes)) /=
					gtk_text_appearance_struct_rise (gtk_text_attributes_struct_text_appearance (a_text_attributes)) then
						non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_CHARACTER_FORMAT_CONSTANTS}.effects_vertical_offset)
				end
				
				gtk_text_attributes_free (previous_text_attributes)
				previous_text_attributes := a_text_attributes
				
				a_character_index := a_character_index + 1
				
				if abort_on_change and then non_contiguous_range_information > 0 then
					non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_CHARACTER_FORMAT_CONSTANTS}.font_family)
					exit_loop := True
				end
			end
			
			gtk_text_attributes_free (previous_text_attributes)
			
			a_text_iter.memory_free

			create Result.make_with_flags ((511).bit_xor (non_contiguous_range_information))
				-- 511 is the mask value for character format constants
	
			if change_index /= Void then
				change_index.set_item (a_character_index - 1)
					-- We take off one as the change occurs before `character_index' is incremented at end of loop
			end
		end

	paragraph_format_range_information (start_index, end_index: INTEGER): EV_PARAGRAPH_FORMAT_RANGE_INFORMATION is
			-- Formatting range information from caret position `start_index' to `end_index'.
			-- All attributes in `Result' are set to `True' if they remain consitent from `start_index' to
			--`end_index' and `False' otherwise.
			-- `Result' is a snapshot of `Current', and does not remain consistent as the contents
			-- are subsequently changed.
		local
			a_character_index: INTEGER
			a_text_iter: EV_GTK_TEXT_ITER_STRUCT
			a_text_attributes: POINTER
			previous_text_attributes: POINTER
			non_contiguous_range_information: INTEGER
			font_family_contiguous: BOOLEAN
			a_change: BOOLEAN
		do
			from
				font_family_contiguous := True
				a_character_index := start_index + 1
				create a_text_iter.make
				feature {EV_GTK_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_text_iter.item, start_index - 1)
				previous_text_attributes := gtk_text_view_get_default_attributes (text_view)
				a_change := gtk_text_iter_get_attributes (a_text_iter.item, previous_text_attributes)
			until
				a_character_index > end_index
			loop
				create a_text_iter.make
				feature {EV_GTK_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_text_iter.item, a_character_index - 2)
				a_text_attributes := gtk_text_view_get_default_attributes (text_view)
				a_change := gtk_text_iter_get_attributes (a_text_iter.item, a_text_attributes)

				if gtk_text_attributes_struct_justification (a_text_attributes) /=
					gtk_text_attributes_struct_justification (previous_text_attributes) then
						non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_PARAGRAPH_CONSTANTS}.alignment)
				end
				
				if gtk_text_attributes_struct_left_margin (a_text_attributes) /=
					gtk_text_attributes_struct_left_margin (previous_text_attributes) then
						non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_PARAGRAPH_CONSTANTS}.left_margin)
				end

				if gtk_text_attributes_struct_right_margin (a_text_attributes) /=
					gtk_text_attributes_struct_right_margin (previous_text_attributes) then
						non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_PARAGRAPH_CONSTANTS}.right_margin)
				end

				if gtk_text_attributes_struct_pixels_above_lines (a_text_attributes) /=
					gtk_text_attributes_struct_pixels_above_lines (previous_text_attributes) then
						non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_PARAGRAPH_CONSTANTS}.top_spacing)
				end

				if gtk_text_attributes_struct_pixels_below_lines (a_text_attributes) /=
					gtk_text_attributes_struct_pixels_below_lines (previous_text_attributes) then
						non_contiguous_range_information := non_contiguous_range_information.bit_or (feature {EV_PARAGRAPH_CONSTANTS}.bottom_spacing)
				end
				
				gtk_text_attributes_free (previous_text_attributes)
				previous_text_attributes := a_text_attributes
				
				a_character_index := a_character_index + 1
			end
			
			gtk_text_attributes_free (previous_text_attributes)

			create Result.make_with_flags ((31).bit_xor (non_contiguous_range_information))
				-- 31 is the mask value for paragraph format constants

		end

	paragraph_format_contiguous, internal_paragraph_format_contiguous (start_position, end_position: INTEGER): BOOLEAN is
			-- Is paragraph formatting from line `start_position' to `end_position' contiguous?
		local
			range_info: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION
		do
			range_info := paragraph_format_range_information (start_position, end_position)
			Result := range_info.alignment and then range_info.left_margin and then range_info.right_margin and then range_info.top_spacing and then range_info.bottom_spacing
		end

	character_format_contiguous (start_index, end_index: INTEGER): BOOLEAN is
			-- Is formatting from caret position `start_index' to `end_index' contiguous?
			-- Internal version which permits optimizations as caret position and selection
			-- does not need to be restored.
		do
			Result := internal_character_format_contiguous (start_index, end_index)
		end

	internal_character_format_contiguous (start_index, end_index: INTEGER): BOOLEAN is
			-- Is formatting from caret position `start_index' to `end_index' contiguous?
		local
			a_range_info: EV_CHARACTER_FORMAT_RANGE_INFORMATION
		do
			a_range_info := internal_character_format_range_information (start_index, end_index, True, Void)
			Result := a_range_info.font_family
		end

	selected_paragraph_format: EV_PARAGRAPH_FORMAT is
			-- `Result' is paragraph format of current selection.
			-- If more than one format is contained in the selection, `Result'
			-- is the first of these formats.
		do
			Result := paragraph_format (selection_start)
		end

	modify_region (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT; applicable_attributes: EV_CHARACTER_FORMAT_RANGE_INFORMATION) is
			-- Modify formatting from `start_position' to `end_position' applying all attributes of `format' that are set to
			-- `True' within `applicable_attributes', ignoring others.
		local
			a_format_imp: EV_CHARACTER_FORMAT_IMP
		do
			a_format_imp ?= format.implementation
			modify_region_internal (text_buffer, start_position, end_position, a_format_imp, applicable_attributes)
		end

	modify_paragraph (start_position, end_position: INTEGER; format: EV_PARAGRAPH_FORMAT; applicable_attributes: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION) is
			-- Modify paragraph formatting from caret positions `start_position' to `end_position' applying all attributes of `format' that are set to
			-- `True' within `applicable_attributes', ignoring others.
		local
			format_imp: EV_PARAGRAPH_FORMAT_IMP
		do
			format_imp ?= format.implementation
			modify_paragraph_internal (start_position, end_position, format_imp, applicable_attributes)
		end

	paragraph_format, internal_paragraph_format (caret_index: INTEGER): EV_PARAGRAPH_FORMAT is
			-- `Result' is paragraph_format at caret position `caret_index'.
		local
			a_text_iter: EV_GTK_TEXT_ITER_STRUCT
			a_text_attributes: POINTER
			a_justification: INTEGER
			a_change: BOOLEAN
		do
			create Result
			create a_text_iter.make
			feature {EV_GTK_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_text_iter.item, caret_index - 1)
			a_text_attributes := gtk_text_view_get_default_attributes (text_view)
			a_change := gtk_text_iter_get_attributes (a_text_iter.item, a_text_attributes)
			
			Result.set_bottom_spacing (gtk_text_attributes_struct_pixels_below_lines (a_text_attributes))
			Result.set_top_spacing (gtk_text_attributes_struct_pixels_above_lines (a_text_attributes))
			Result.set_left_margin (gtk_text_attributes_struct_left_margin (a_text_attributes))
			Result.set_right_margin (gtk_text_attributes_struct_right_margin (a_text_attributes))
			
			a_justification :=  gtk_text_attributes_struct_justification (a_text_attributes)
			if a_justification = feature {EV_GTK_EXTERNALS}.gtk_justify_left_enum then
				Result.enable_left_alignment
			elseif a_justification = feature {EV_GTK_EXTERNALS}.gtk_justify_center_enum then
				Result.enable_center_alignment
			elseif a_justification = feature {EV_GTK_EXTERNALS}.gtk_justify_right_enum then
				Result.enable_right_alignment
			elseif a_justification = feature {EV_GTK_EXTERNALS}.gtk_justify_fill_enum then
				Result.enable_justification
			end
			gtk_text_attributes_free (a_text_attributes)
		end

	selected_character_format: EV_CHARACTER_FORMAT is
			-- Format of the character which starts the selection
		do
			Result := character_format (selection_start)
		end

	index_from_position (an_x_position, a_y_position: INTEGER): INTEGER is
			-- Index of character closest to position `x_position', `y_position'.
		local
			a_buf_x, a_buf_y: INTEGER
			a_text_iter: EV_GTK_TEXT_ITER_STRUCT
			text_count: INTEGER
		do
			gtk_text_view_window_to_buffer_coords (text_view, an_x_position, a_y_position, $a_buf_x, $a_buf_y)
			create a_text_iter.make
			gtk_text_view_get_iter_at_location (text_view, a_text_iter.item, a_buf_x, a_buf_y)
			text_count := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_char_count (text_buffer)

			Result := feature {EV_GTK_EXTERNALS}.gtk_text_iter_get_offset (a_text_iter.item) + 1
			Result := Result.min (text_count).max (1)
		end
		
	position_from_index (an_index: INTEGER): EV_COORDINATE is
			-- Position of character at index `an_index'.
		local
			a_text_iter: EV_GTK_TEXT_ITER_STRUCT
			a_x, a_y, a_x2, a_y2: INTEGER
			a_rectangle: MANAGED_POINTER
		do
			create a_text_iter.make
			create a_rectangle.make (feature {EV_GTK_EXTERNALS}.c_gdk_rectangle_struct_size)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_text_iter.item, an_index - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_view_get_iter_location (text_view, a_text_iter.item, a_rectangle.item)
			a_x := feature {EV_GTK_EXTERNALS}.gdk_rectangle_struct_x (a_rectangle.item)
			a_y := feature {EV_GTK_EXTERNALS}.gdk_rectangle_struct_y (a_rectangle.item)
			gtk_text_view_buffer_to_window_coords (text_view, a_x, a_y, $a_x2, $a_y2)
			create Result.set (a_x2, a_y2)
		end
		
	character_displayed (an_index: INTEGER): BOOLEAN is
			-- Is character `an_index' currently visible in `Current'?
		local
			a_text_iter: EV_GTK_TEXT_ITER_STRUCT
			a_x, a_y, a_char_x, a_char_y, a_char_width, a_char_height: INTEGER
			a_rectangle: MANAGED_POINTER
		do
			create a_text_iter.make
			create a_rectangle.make (feature {EV_GTK_EXTERNALS}.c_gdk_rectangle_struct_size)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_text_iter.item, an_index - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_view_get_iter_location (text_view, a_text_iter.item, a_rectangle.item)
			a_x := feature {EV_GTK_EXTERNALS}.gdk_rectangle_struct_x (a_rectangle.item)
			a_y := feature {EV_GTK_EXTERNALS}.gdk_rectangle_struct_y (a_rectangle.item)
			a_char_width := feature {EV_GTK_EXTERNALS}.gdk_rectangle_struct_width (a_rectangle.item)
			a_char_height := feature {EV_GTK_EXTERNALS}.gdk_rectangle_struct_height (a_rectangle.item)
			gtk_text_view_buffer_to_window_coords (text_view, a_x, a_y, $a_char_x, $a_char_y)
			Result := (a_char_x >= 0 and a_char_x < width) and then (a_char_y >= 0 and a_char_y < height)
		end
	
feature -- Status report

	character_format (pos: INTEGER): EV_CHARACTER_FORMAT is
			-- `Result' is character format at position `pos'. On some platforms
			-- this may be optimized to take the selected character format and therefore
			-- should only be used by `next_change_of_character'.
		do
			Result := internal_character_format (pos).interface
		end

	internal_character_format (character_index: INTEGER): EV_CHARACTER_FORMAT_IMP is
			-- `Result' is character format of character `character_index'.
		local
			a_text_iter: EV_GTK_TEXT_ITER_STRUCT
			a_text_attributes, a_text_appearance: POINTER
			a_font_description: POINTER
			a_color: POINTER
			font_size, font_weight, font_style: INTEGER
			a_family: STRING--EV_GTK_C_STRING
			a_change: BOOLEAN
		do
			Result ?= (create {EV_CHARACTER_FORMAT}).implementation
			create a_text_iter.make
			feature {EV_GTK_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_text_iter.item, character_index - 2)
			a_text_attributes := gtk_text_view_get_default_attributes (text_view)
			a_change := gtk_text_iter_get_attributes (a_text_iter.item, a_text_attributes)
			
			a_text_appearance := gtk_text_attributes_struct_text_appearance (a_text_attributes)

			a_font_description := gtk_text_attributes_struct_font_description (a_text_attributes)
			create a_family.make_from_c (feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_family (a_font_description))
			font_style := feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_style (a_font_description)
			font_weight := feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_weight (a_font_description)
			
			if font_weight <= feature {EV_FONT_IMP}.pango_weight_ultra_light then
				font_weight := feature {EV_FONT_CONSTANTS}.weight_thin
			elseif font_weight <= feature {EV_FONT_IMP}.pango_weight_normal then
				font_weight := feature {EV_FONT_CONSTANTS}.weight_regular
			elseif font_weight <= feature {EV_FONT_IMP}.pango_weight_bold then
				font_weight := feature {EV_FONT_CONSTANTS}.weight_bold
			else
				font_weight := feature {EV_FONT_CONSTANTS}.weight_black
			end
			font_size := feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_size (a_font_description) // feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_scale

			if feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_get_style (a_font_description) > 0 then
				font_style := feature {EV_FONT_CONSTANTS}.shape_italic
			else
				font_style := feature {EV_FONT_CONSTANTS}.shape_regular
			end

			Result.set_font_attributes (a_family, feature {EV_FONT_CONSTANTS}.family_sans, font_size, font_weight, font_style, 0)
			
			a_color := gtk_text_appearance_struct_fg_color (a_text_appearance)
			Result.set_fcolor (
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_red (a_color) // 256,
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_green (a_color) // 256,
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_blue (a_color) // 256			
			)
			
			a_color := gtk_text_appearance_struct_bg_color (a_text_appearance)
			Result.set_bcolor (
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_red (a_color) // 256,
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_green (a_color) // 256,
				feature {EV_GTK_EXTERNALS}.gdk_color_struct_blue (a_color) // 256			
			)
			
			Result.set_effects_internal (gtk_text_appearance_struct_underline (a_text_appearance).to_boolean, gtk_text_appearance_struct_strikethrough (a_text_appearance).to_boolean, gtk_text_appearance_struct_rise (a_text_appearance))
	
			gtk_text_attributes_free (a_text_attributes)
		end

feature -- Status setting

	set_current_format (format: EV_CHARACTER_FORMAT) is
			-- apply `format' to current caret position, applicable
			-- to next typed characters.
		do
		end
		
	format_region (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply `format' to all characters between the caret positions `start_position' and `end_position'.
			-- Formatting is applied immediately. May or may not change the cursor position.
		local
			a_format_imp: EV_CHARACTER_FORMAT_IMP
		do
			a_format_imp ?= format.implementation
			modify_region_internal (text_buffer, start_position, end_position, a_format_imp, a_format_imp.dummy_character_format_range_information)
		end

	buffered_format (start_position, end_position: INTEGER; format: EV_CHARACTER_FORMAT) is
			-- Apply a character format `format' from caret positions `start_position' to `end_position' to
			-- format buffer. Call `flush_format_buffer' to apply buffered contents to `Current'.
		do
			if not buffer_locked_in_format_mode then
				buffer_locked_in_format_mode := True
					-- Temporarily remove text buffer to avoid redraw and event firing
				feature {EV_GTK_DEPENDENT_EXTERNALS}.object_ref (text_buffer)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_view_set_buffer (text_view, feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_new (default_pointer))
			end
			format_region (start_position, end_position, format)
		end
		
	buffered_append (a_text: STRING; format: EV_CHARACTER_FORMAT) is
			-- Apply `a_text' with format `format' to append buffer.
			-- To apply buffer contents to `Current', call `flush_append_buffer' or
			-- `flush_append_buffer_to'.
		local
			text_tag_table: POINTER
			buffer_length: INTEGER
			a_format_imp: EV_CHARACTER_FORMAT_IMP
		do
			if not buffer_locked_in_append_mode then
				text_tag_table := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_tag_table (text_buffer)
				append_buffer := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_new (text_tag_table)
				buffer_locked_in_append_mode := True
			end
			a_format_imp ?= format.implementation
			buffer_length := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_char_count (append_buffer) + 1
			append_text_internal (append_buffer, a_text)
			modify_region_internal (append_buffer, buffer_length, feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_char_count (append_buffer) + 1, a_format_imp, a_format_imp.dummy_character_format_range_information)
		end
		
	flush_buffer is
			-- Flush contents of buffer.
			-- If `buffer_locked_for_append' then replace contents of `Current' with buffer contents.
			-- If `buffer_locked_for_format' then apply buffered formatting to contents of `Current'.
		local
			text_buffer_iter, append_buffer_start_iter, append_buffer_end_iter: EV_GTK_TEXT_ITER_STRUCT
		do
			if buffer_locked_in_format_mode then
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_view_set_buffer (text_view, text_buffer)
				buffer_locked_in_format_mode := False
			elseif buffer_locked_in_append_mode then
				set_text ("")
				create text_buffer_iter.make
				create append_buffer_start_iter.make
				create append_buffer_end_iter.make
				
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_start_iter (append_buffer, append_buffer_start_iter.item)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_end_iter (append_buffer, append_buffer_end_iter.item)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_end_iter (text_buffer, text_buffer_iter.item)
				
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_insert_range (text_buffer, text_buffer_iter.item, append_buffer_start_iter.item, append_buffer_end_iter.item)
				dispose_append_buffer
				buffer_locked_in_append_mode := False
			end
			
		end
		
	flush_buffer_to (start_position, end_position: INTEGER) is
			-- Replace contents of current from caret position `start_position' to `end_position' with
			-- contents of buffer, since it was last flushed. If `start_position' and `end_position'
			-- are equal, insert the contents of the buffer at caret position `start_position'.
		local
			text_buffer_start_iter, text_buffer_end_iter, append_buffer_start_iter, append_buffer_end_iter: EV_GTK_TEXT_ITER_STRUCT
		do
			create text_buffer_start_iter.make
			create text_buffer_end_iter.make
			create append_buffer_start_iter.make
			create append_buffer_end_iter.make
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, text_buffer_start_iter.item, start_position - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, text_buffer_end_iter.item, end_position - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_start_iter (append_buffer, append_buffer_start_iter.item)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_end_iter (append_buffer, append_buffer_end_iter.item)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_delete (text_buffer, text_buffer_start_iter.item, text_buffer_end_iter.item)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_insert_range (text_buffer, text_buffer_start_iter.item, append_buffer_start_iter.item, append_buffer_end_iter.item)
			
			dispose_append_buffer
			buffer_locked_in_append_mode := False
		end
		
	set_tab_width (a_width: INTEGER) is
			-- Assign `a_width' to `tab_width'.
		do
		end

	tab_width: INTEGER is
			-- Default width in pixels of each tab in `Current'.
		do
			Result := 40
		end

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation

	on_text_mark_changed (a_text_iter, a_text_mark: POINTER) is
			-- Called when a text mark within `text_buffer' has been set.
		local
			a_caret_position: INTEGER
			a_selection_start, a_selection_end: INTEGER
		do
			if not (a_text_mark = feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_insert (text_buffer)) then
				a_selection_start := selection_start_internal
				a_selection_end := selection_end_internal
				if selection_change_actions_internal /= Void and then (previous_selection_start /= a_selection_start or else previous_selection_end /= a_selection_end) then
				--	selection_change_actions_internal.call (Void)
				end
				previous_selection_start := a_selection_start
				previous_selection_end := a_selection_end
			else
				a_caret_position := caret_position
				if a_caret_position /= previous_caret_position and then caret_move_actions_internal /= Void then
					caret_move_actions_internal.call ([a_caret_position])
				end
				previous_caret_position := a_caret_position
			end
		end

feature {NONE} -- Implementation

	previous_caret_position, previous_selection_start, previous_selection_end: INTEGER
		-- Values used for determining whether either the selection or caret_position has changed inorder to fire appropriate event

feature {NONE} -- Implementation

	gtk_text_view_set_tabs (a_text_view, a_pango_tab_array: POINTER) is
			external
				"C signature (GtkTextView*, PangoTabArray*) use <gtk/gtk.h>"
			end

	pango_tab_array_new (initial_size: INTEGER; dimension_in_pixels: BOOLEAN): POINTER is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"pango_tab_array_new ((gint) $initial_size, (gboolean) $dimension_in_pixels)"
			end

	gtk_text_attributes_struct_font_description (a_text_attributes: POINTER): POINTER is
			external
				"C struct GtkTextAttributes access font use <gtk/gtk.h>"
			end

	gtk_text_attributes_struct_text_appearance (a_text_attributes: POINTER): POINTER is
			external
				"C struct GtkTextAttributes access &appearance use <gtk/gtk.h>"
			end

	gtk_text_attributes_struct_justification (a_text_attributes: POINTER): INTEGER is
			external
				"C struct GtkTextAttributes access justification use <gtk/gtk.h>"
			end

	gtk_text_attributes_struct_left_margin (a_text_attributes: POINTER): INTEGER is
			external
				"C struct GtkTextAttributes access left_margin use <gtk/gtk.h>"
			end

	gtk_text_attributes_struct_right_margin (a_text_attributes: POINTER): INTEGER is
			external
				"C struct GtkTextAttributes access right_margin use <gtk/gtk.h>"
			end

	gtk_text_attributes_struct_pixels_above_lines (a_text_attributes: POINTER): INTEGER is
			external
				"C struct GtkTextAttributes access pixels_above_lines use <gtk/gtk.h>"
			end

	gtk_text_attributes_struct_pixels_below_lines (a_text_attributes: POINTER): INTEGER is
			external
				"C struct GtkTextAttributes access pixels_below_lines use <gtk/gtk.h>"
			end

	gtk_text_appearance_struct_rise (a_text_appearance: POINTER): INTEGER is
			external
				"C struct GtkTextAppearance access rise use <gtk/gtk.h>"
			end

	gtk_text_appearance_struct_bg_color (a_text_appearance: POINTER): POINTER is
			external
				"C struct GtkTextAppearance access &bg_color use <gtk/gtk.h>"
			end
			
	gtk_text_appearance_struct_underline (a_text_appearance: POINTER): INTEGER is
			external
				"C struct GtkTextAppearance access underline use <gtk/gtk.h>"
			end

	gtk_text_appearance_struct_strikethrough (a_text_appearance: POINTER): INTEGER is
			external
				"C struct GtkTextAppearance access strikethrough use <gtk/gtk.h>"
			end

	gtk_text_appearance_struct_fg_color (a_text_appearance: POINTER): POINTER is
			external
				"C struct GtkTextAppearance access &fg_color use <gtk/gtk.h>"
			end

	gtk_text_iter_get_attributes (a_text_iter: POINTER; a_text_values: POINTER): BOOLEAN is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"gtk_text_iter_get_attributes ((GtkTextIter*) $a_text_iter, (GtkTextAttributes*) $a_text_values )"
			end
			
	gtk_text_view_get_default_attributes (a_text_view: POINTER): POINTER is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"gtk_text_view_get_default_attributes ((GtkTextView*) $a_text_view)"
			end
			
	gtk_text_attributes_free (a_text_attributes: POINTER) is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"free ((GtkTextAttributes*) $a_text_attributes)"
			end

	gtk_text_attributes_copy_values (a_text_attributes_src, a_text_attributes_dest: POINTER) is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"gtk_text_attributes_copy_values ((GtkTextAttributes*) $a_text_attributes_src, (GtkTextAttributes*) $a_text_attributes_dest)"
			end
	
	gtk_text_attributes_copy (a_text_attributes_src: POINTER): POINTER is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"gtk_text_attributes_copy ((GtkTextAttributes*) $a_text_attributes_src)"
			end

	gtk_text_view_get_iter_at_location (a_text_view,  a_text_iter: POINTER; buffer_x, buffer_y: INTEGER) is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"gtk_text_view_get_iter_at_location ((GtkTextView*) $a_text_view, (GtkTextIter*) $a_text_iter, (gint) $buffer_x, (gint) $buffer_y)"
			end

	gtk_text_view_window_to_buffer_coords (a_text_view: POINTER; window_x, window_y: INTEGER; buffer_x, buffer_y: POINTER) is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"gtk_text_view_window_to_buffer_coords ((GtkTextView*) $a_text_view, GTK_TEXT_WINDOW_TEXT, (gint) $window_x, (gint) $window_y, (gint *) $buffer_x, (gint *) $buffer_y)"
			end
		
	gtk_text_view_buffer_to_window_coords (a_text_view: POINTER; buffer_x, buffer_y: INTEGER; window_x, window_y: POINTER) is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"gtk_text_view_buffer_to_window_coords ((GtkTextView*) $a_text_view, GTK_TEXT_WINDOW_TEXT, (gint) $buffer_x, (gint) $buffer_y, (gint *) $window_x, (gint *) $window_y)"
			end

	modify_region_internal (a_text_buffer: POINTER; start_position, end_position: INTEGER; format_imp: EV_CHARACTER_FORMAT_IMP; applicable_attributes: EV_CHARACTER_FORMAT_RANGE_INFORMATION) is
			-- Apply `format' to all characters between the caret positions `start_position' and `end_position'.
			-- Formatting is applied immediately. May or may not change the cursor position.
		local
			a_start_iter, a_end_iter: EV_GTK_TEXT_ITER_STRUCT
			a_tag_table, text_tag: POINTER
		do
			create a_start_iter.make
			create a_end_iter.make
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (a_text_buffer, a_start_iter.item, start_position - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (a_text_buffer, a_end_iter.item, end_position - 1)
		
			text_tag := format_imp.new_text_tag_from_applicable_attributes (applicable_attributes)
			a_tag_table := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_tag_table (a_text_buffer)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_tag_table_add (a_tag_table, text_tag)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_apply_tag (a_text_buffer, text_tag, a_start_iter.item, a_end_iter.item)
		end

	modify_paragraph_internal (start_position, end_position: INTEGER; format_imp: EV_PARAGRAPH_FORMAT_IMP; applicable_attributes: EV_PARAGRAPH_FORMAT_RANGE_INFORMATION) is
			-- Apply paragraph formatting `format' from position `start_position' to `end_position' based on `applicable_attributes'
		local
			a_start_position, a_end_position: INTEGER
			a_start_iter, a_end_iter: EV_GTK_TEXT_ITER_STRUCT
			a_tag_table, text_tag: POINTER
			a_start_line: INTEGER
		do
			a_start_position := start_position
			a_end_position := end_position
			
			create a_start_iter.make
			create a_end_iter.make

			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_start_iter.item, a_start_position - 1)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_iter_at_offset (text_buffer, a_end_iter.item, a_end_position - 1)
			
			a_start_line := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_iter_get_line (a_start_iter.item)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_iter_set_line (a_start_iter.item, a_start_line)
			
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_iter_forward_to_line_end (a_end_iter.item)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_iter_forward_char (a_end_iter.item)

			text_tag := format_imp.new_paragraph_tag_from_applicable_attributes (applicable_attributes)
			a_tag_table := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_get_tag_table (text_buffer)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_tag_table_add (a_tag_table, text_tag)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_text_buffer_apply_tag (text_buffer, text_tag, a_start_iter.item, a_end_iter.item)

		end

	update_tab_positions (value: INTEGER) is
			-- Update tab widths based on contents of `tab_positions'.
		do
		end

	dispose_append_buffer is
			-- Clean up `append_buffer'.
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.object_unref (append_buffer)
			append_buffer := default_pointer
		end

	append_buffer: POINTER
		-- Pointer to the GtkTextBuffer used for append buffering.	

feature {EV_ANY_I} -- Implementation
	
	interface: EV_RICH_TEXT

end -- class EV_RICH_TEXT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

