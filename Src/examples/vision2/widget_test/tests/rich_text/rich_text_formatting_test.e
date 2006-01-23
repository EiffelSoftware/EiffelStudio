indexing
	description: "Objects that show basic character formatting of EV_RICH_TEXT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RICH_TEXT_FORMATTING_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			font_families: LINEAR [STRING]
			environment: EV_ENVIRONMENT
			list_item: EV_LIST_ITEM
		do
			create rich_text
			create vertical_box
			vertical_box.extend (rich_text)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			vertical_box.disable_item_expand (horizontal_box)
			create font_selection
			font_selection.select_actions.extend (agent font_selected)
			create bold_button.make_with_text_and_action ("Bold", agent modify_bold)
			create italic_button.make_with_text_and_action ("Italic", agent modify_italic)
			horizontal_box.extend (font_selection)
			horizontal_box.extend (bold_button)
			horizontal_box.disable_item_expand (bold_button)
			horizontal_box.extend (italic_button)
			horizontal_box.disable_item_expand (italic_button)
			
			
			rich_text.set_minimum_size (300, 300)
			rich_text.set_text ("Select some of this text, and use the two buttons to enable/disable bold and italic formatting.")
			rich_text.selection_change_actions.extend (agent selection_changed)
			rich_text.caret_move_actions.extend (agent caret_moved)
			rich_text.set_font (default_font)
			rich_text.set_current_format (create {EV_CHARACTER_FORMAT}.make_with_font (default_font))
			
					-- Now load all available fonts into `font_selection' combo box.
			create environment
			font_families := environment.font_families
			create font_names.make (50)
			from
				font_families.start
			until
				font_families.off
			loop
				create list_item.make_with_text (font_families.item)
				font_selection.extend (list_item)
				font_names.put (font_selection.count, font_families.item)
				font_families.forth
			end
			
			widget := vertical_box
		end
		
feature {NONE} -- Implementation
		
	selection_changed is
			-- Update control buttons based on current selection in `rich_text'.
		local
			formatting: EV_CHARACTER_FORMAT_RANGE_INFORMATION
			character_format: EV_CHARACTER_FORMAT
		do
			if rich_text.has_selection then
				block_events
					-- Check for having a selection, as `selection_change_actions' are
					-- also fired when going from having a slection to no selection.
				character_format := rich_text.selected_character_format
				formatting := rich_text.character_format_range_information (rich_text.selection_start, rich_text.selection_end + 1)
				if formatting.font_family then
					font_selection.i_th (font_names.item (character_format.font.name.out)).enable_select
				else
						-- Font family is not consistent throughout complete selection so hide family.
					font_selection.remove_text
					font_selection.remove_selection
				end
				if character_format.font.weight = {EV_FONT_CONSTANTS}.weight_bold and formatting.font_weight then
					bold_button.enable_select
				else
					bold_button.disable_select
				end
				if character_format.font.shape = {EV_FONT_CONSTANTS}.shape_italic and formatting.font_shape then
					italic_button.enable_select
				else
					italic_button.disable_select
				end
				resume_events
			end
		end
		
	caret_moved (new_position: INTEGER) is
			-- Update control buttons based on `new_position' of caret.
		local
			character_format: EV_CHARACTER_FORMAT
			font: EV_FONT
		do
			character_format := rich_text.character_format (rich_text.caret_position)
			font := character_format.font
			block_events
			
			if character_format.font.weight = {EV_FONT_CONSTANTS}.weight_regular then
				bold_button.disable_select
			else
				bold_button.enable_select
			end
			if character_format.font.shape = {EV_FONT_CONSTANTS}.shape_regular then
				italic_button.disable_select
			else
				italic_button.enable_select
			end
			if font_names /= Void then
				font_selection.i_th (font_names.item (character_format.font.name.out)).enable_select
			end
			resume_events
		end

	font_selected is
			-- Update current font based on selected item in `font_selection'.
		local
			character_format: EV_CHARACTER_FORMAT
			format_range: EV_CHARACTER_FORMAT_RANGE_INFORMATION
			font: EV_FONT
		do
			if rich_text.has_selection then
				character_format := rich_text.character_format (rich_text.selection_start)
			else
				character_format := rich_text.character_format (rich_text.caret_position)
			end
			
			font := character_format.font
			font.preferred_families.wipe_out
			font.preferred_families.extend (font_selection.selected_item.text)
			character_format.set_font (font)
			
			if rich_text.has_selection then
				create format_range.make_with_flags ({EV_CHARACTER_FORMAT_CONSTANTS}.font_family)
				rich_text.modify_region (rich_text.selection_start, rich_text.selection_end + 1, character_format, format_range)
			else
				rich_text.set_current_format (character_format)
			end
			if rich_text.is_displayed then
				rich_text.set_focus
			end
		end

	modify_bold is
			-- Update current bold formatting based on state of `bold_button'.
		local
			character_format: EV_CHARACTER_FORMAT
			format_range: EV_CHARACTER_FORMAT_RANGE_INFORMATION
			font: EV_FONT
		do
			if rich_text.has_selection then
				character_format := rich_text.character_format (rich_text.selection_start)
			else
				character_format := rich_text.character_format (rich_text.caret_position)
			end
			
			font := character_format.font
			if bold_button.is_selected then
				font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
			else
				font.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
			end
			character_format.set_font (font)
			
			if rich_text.has_selection then
				create format_range.make_with_flags ({EV_CHARACTER_FORMAT_CONSTANTS}.font_weight)
				rich_text.modify_region (rich_text.selection_start, rich_text.selection_end + 1, character_format, format_range)
			else
				rich_text.set_current_format (character_format)
			end
			rich_text.set_focus
		end
		
	modify_italic is
			-- Update current italic formatting based on state of `italic_button'.
		local
			character_format: EV_CHARACTER_FORMAT
			format_range: EV_CHARACTER_FORMAT_RANGE_INFORMATION
			font: EV_FONT
		do
			if rich_text.has_selection then
				character_format := rich_text.character_format (rich_text.selection_start)
			else
				character_format := rich_text.character_format (rich_text.caret_position)
			end
			
			font := character_format.font
			if italic_button.is_selected then
				font.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
			else
				font.set_shape ({EV_FONT_CONSTANTS}.shape_regular)
			end
			character_format.set_font (font)
			
			if rich_text.has_selection then
				create format_range.make_with_flags ({EV_CHARACTER_FORMAT_CONSTANTS}.font_shape)
				rich_text.modify_region (rich_text.selection_start, rich_text.selection_end + 1, character_format, format_range)
			else
				rich_text.set_current_format (character_format)
			end
			rich_text.set_focus
		end
		
	block_events is
			-- Block events for control widgets.
		do
			bold_button.select_actions.block
			italic_button.select_actions.block
			font_selection.select_actions.block
		end
		
	resume_events is
			-- Resume events for control widgets.
		do
			bold_button.select_actions.resume
			italic_button.select_actions.resume
			font_selection.select_actions.resume
		end

	default_font: EV_FONT is
			-- Default font used.
		local
			environment: EV_ENVIRONMENT
		once
			create environment
			create Result
				-- Now add three common font faces to `preferred_families'.
				-- The first found on the current platform is used.
			Result.preferred_families.extend ("Times New Roman")
			Result.preferred_families.extend ("Courier New")
			Result.preferred_families.extend ("Arial")
			Result.set_height (24)
		end

	rich_text: EV_RICH_TEXT
		-- Widget that test is to be performed on.
		
	bold_button: EV_TOGGLE_BUTTON
		-- Button to control bold status of text.
		
	italic_button: EV_TOGGLE_BUTTON
		-- Button to control italic status of text.
		
	font_selection: EV_COMBO_BOX
		-- Combo box to select current font.
		
	font_names: HASH_TABLE [INTEGER, STRING];
		-- Quick look up to retrieve font index in `font_selection'.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class RICH_TEXT_FORMATTING_TEST
