indexing
	description: "[
		Objects that set the default text for EiffelVision2 rich text example.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	DEFAULT_TEXT_INITIALIZER
	
create
	default_create

feature -- Status setting

	set_default_text (rich_text: EV_RICH_TEXT) is
			-- Assign the default introductory text to `rich_text'.
		require
			rich_text_not_void: rich_text /= Void
		local
			character_format, character_format_bold,
			temp_format, character_format_large: EV_CHARACTER_FORMAT
			font, bold_font, large_font: EV_FONT
			effects: EV_CHARACTER_FORMAT_EFFECTS
			counter: INTEGER
			word_array: ARRAY [STRING]
			offset_array: ARRAY [INTEGER]
			all_fonts: ARRAYED_LIST [STRING]
			paragraph_format: EV_PARAGRAPH_FORMAT
			paragraph_start_index: INTEGER
		do
			create font.make_with_values (feature {EV_FONT_CONSTANTS}.family_roman,
				feature {EV_FONT_CONSTANTS}.weight_regular,
				feature {EV_FONT_CONSTANTS}.shape_regular,
				12)
			bold_font := font.twin
			bold_font.set_weight (feature {EV_FONT_CONSTANTS}.weight_bold)
			large_font := font.twin
			large_font.set_height (20)
			large_font.set_weight (feature {EV_FONT_CONSTANTS}.weight_bold)
			create character_format.make_with_font (font)
			create character_format_bold.make_with_font (bold_font)
			create character_format_large.make_with_font (large_font)
			rich_text.buffered_append ("Welcome to the EiffelVision2 Rich text example%N%N", character_format_large)
			rich_text.buffered_append (intro_text_1, character_format)
			rich_text.buffered_append ("Usage%N", character_format_large)
			rich_text.buffered_append (intro_text_2, character_format)
			rich_text.buffered_append ("%TCharacter Toolbar", character_format_bold)
			rich_text.buffered_append (intro_text_3, character_format)
			rich_text.buffered_append ("%TParagraph Toolbar", character_format_bold)
			rich_text.buffered_append (intro_text_4, character_format)
			rich_text.buffered_append ("%TTab Toolbar", character_format_bold)
			rich_text.buffered_append (intro_text_5, character_format)
			rich_text.buffered_append (intro_text_6, character_format)
			rich_text.buffered_append ("Character Formatting%N%N", character_format_large)
			rich_text.buffered_append ("Font Family", character_format_bold)
			rich_text.buffered_append ("%NMultiple font families may be set on a character by character basis, the following are some of those currently available:%N", character_format)
			
				-- Retrieve the available font faimilies from EV_ENVIRONMENT and display some of the first.
			all_fonts ?= (create {EV_ENVIRONMENT}).font_families
			from
				all_fonts.start
			until
				all_fonts.index = 20
			loop
				font := character_format.font.twin
				font.preferred_families.wipe_out
				font.preferred_families.extend (all_fonts.item)
				create temp_format.make_with_font (font)
				rich_text.buffered_append (all_fonts.item + " ", temp_format)
				all_fonts.forth
			end
			
			rich_text.buffered_append ("%N%NFont Height%N", character_format_bold)
				-- Now add a number of different sized fonts.
			from
				counter := 6
			until
				counter > 30
			loop
				font := character_format.font.twin
				font.set_height (counter)
				create temp_format.make_with_font (font)
				rich_text.buffered_append (counter.out + " ", temp_format)
				counter := counter + 1
			end
			
			rich_text.buffered_append ("%N%NColor%N%N", character_format_bold)
				-- Apply a number of colors to the text.
			from
				counter := 1
			until
				counter > 10
			loop
				font := character_format.font.twin
				create temp_format.make_with_font (font)
				temp_format.set_color (colors.i_th (counter))
				rich_text.buffered_append ("Color ", temp_format)
				counter := counter + 1
			end
			
			rich_text.buffered_append ("%N%NBackground Color%N%N", character_format_bold)
				-- Apply a number of background colors to the text.
			from
				counter := 1
			until
				counter > 10
			loop
				font := character_format.font.twin
				create temp_format.make_with_font (font)
				temp_format.set_background_color (colors.i_th (counter))
				rich_text.buffered_append ("Background Color ", temp_format)
				counter := counter + 1
			end
			
			rich_text.buffered_append ("%N%NFont Effects%N%N", character_format_bold)
				-- Now display bold, italic and both bold and italic formatting.
			font := character_format.font.twin
			font.set_weight (feature {EV_FONT_CONSTANTS}.weight_bold)
			create temp_format.make_with_font (font)
			rich_text.buffered_append ("Font bold", temp_format)
			
			font := character_format.font.twin
			font.set_shape (feature {EV_FONT_CONSTANTS}.shape_italic)
			create temp_format.make_with_font (font)
			rich_text.buffered_append ("     ", character_format)
			rich_text.buffered_append ("Font italic", temp_format)
			
			font := character_format.font.twin
			font.set_weight (feature {EV_FONT_CONSTANTS}.weight_bold)
			font.set_shape (feature {EV_FONT_CONSTANTS}.shape_italic)
			create temp_format.make_with_font (font)
			rich_text.buffered_append ("     ", character_format)
			rich_text.buffered_append ("Font bold and italic", temp_format)
			
			
			rich_text.buffered_append ("%N%NCharacter Effects%N%N", character_format_bold)
				-- Apply striked out, underlined and then both formats simultaneously.
			create temp_format.make_with_font (character_format.font.twin)
			create effects
			effects.enable_striked_out
			temp_format.set_effects (effects)
			rich_text.buffered_append ("Effects striked out", temp_format)
			effects := temp_format.effects
			effects.disable_striked_out
			effects.enable_underlined
			temp_format.set_effects (effects)
			rich_text.buffered_append ("     ", character_format)
			rich_text.buffered_append ("Effects underlined", temp_format)
			effects := temp_format.effects
			effects.enable_striked_out
			temp_format.set_effects (effects)
			rich_text.buffered_append ("     ", character_format)
			rich_text.buffered_append ("Effects striked out and underlined", temp_format)
			
			rich_text.buffered_append ("%N%NVertical Offset%N%N", character_format_bold)
			rich_text.buffered_append ("This part of the line rests on the baseline,", character_format)
				-- Create arrays for each word and offset.
			word_array := <<" while", " this", " part", " has", " varying", " vertical", " offsets", " for", " each", " word.">>
			offset_array := <<8, -8, 3, 15, 5, -3, -1, 2, -2, 0>>
				-- Now loop through the arrays and apply each word and offset.
			from
				counter := 1
			until
				counter > word_array.count
			loop
				create temp_format.make_with_font (character_format.font.twin)
				create effects
				effects.set_vertical_offset (offset_array.item (counter))
				temp_format.set_effects (effects)
				rich_text.buffered_append (word_array.item (counter), temp_format)
				counter := counter + 1
			end
			rich_text.buffered_append ("%N%NParagraph Formatting%N%N", character_format_large)
			rich_text.buffered_append (intro_text_7, character_format)
			rich_text.buffered_append ("%NAlignment%N%N", character_format_bold)
			rich_text.buffered_append (build_paragraph_text ("Left aligned paragraph. "), character_format)
			rich_text.buffered_append (build_paragraph_text ("Center aligned paragraph. "), character_format)
			rich_text.buffered_append (build_paragraph_text ("Right aligned paragraph. "), character_format)
			rich_text.buffered_append (build_paragraph_text ("Justified paragraph. "), character_format)
			rich_text.buffered_append ("%NSpacing and Margins%N%N", character_format_bold)
			rich_text.buffered_append (build_paragraph_text ("Left margin and justified. "), character_format)
			rich_text.buffered_append (build_paragraph_text ("Right margin and justified. "), character_format)
			rich_text.buffered_append (build_paragraph_text ("Top spaced paragraph and justified. "), character_format)
			rich_text.buffered_append (build_paragraph_text ("Bottom spaced paragraph and justified. "), character_format)
			rich_text.buffered_append ("%NAll available fonts%N", character_format_bold)
			rich_text.buffered_append ("%NThe following fonts are those available on the current machine:%N%N%N", character_format)
			
				-- The buffer is now flushed to write all of the buffered text into the control.
			rich_text.flush_buffer
			
				-- Now handle paragraph formatting as this may not be buffered.
				-- The lines for formatting are hard coded from the character offsets of the text. As the actual character offset
				-- may change due to the dynamic display of fonts, we search for the location of "Spacing and Margins" as it represents
				-- the start of the paragraphs to be formattted, and then apply a character offset from that point.
				
			paragraph_start_index := rich_text.text.substring_index ("Spacing and Margins", 3800)	
				
			create paragraph_format
			paragraph_format.enable_center_alignment
			rich_text.format_paragraph (3177, 3177, paragraph_format)

			paragraph_format.enable_right_alignment
			rich_text.format_paragraph (3673, 3673, paragraph_format)

			paragraph_format.enable_justification
			rich_text.format_paragraph (4150, 4150, paragraph_format)
		
			create paragraph_format
			paragraph_format.enable_justification
			paragraph_format.set_left_margin (200)
			rich_text.format_paragraph (paragraph_start_index + 21, paragraph_start_index + 21, paragraph_format)
			
			create paragraph_format
			paragraph_format.enable_justification
			paragraph_format.set_right_margin (200)
			rich_text.format_paragraph (paragraph_start_index + 536, paragraph_start_index + 536, paragraph_format)
			
			create paragraph_format
			paragraph_format.enable_justification
			paragraph_format.set_top_spacing (100)
			rich_text.format_paragraph (paragraph_start_index + 1090, paragraph_start_index + 1090, paragraph_format)
			
			create paragraph_format
			paragraph_format.enable_justification
			paragraph_format.set_top_spacing (0)
			paragraph_format.set_bottom_spacing (100)
			rich_text.format_paragraph (paragraph_start_index + 1756, paragraph_start_index + 1756, paragraph_format)			
			
			create font.make_with_values (feature {EV_FONT_CONSTANTS}.family_roman,
				feature {EV_FONT_CONSTANTS}.weight_regular,
				feature {EV_FONT_CONSTANTS}.shape_regular,
				12)
--			from
--				counter := 1
--			until
--				counter > 100
--			loop
--				create character_format.make_with_font (font)
--				character_format.set_color (colors.i_th (1))
--				rich_text.buffered_format (counter * 4, counter * 4 + 2, character_format)
--				create character_format.make_with_font (font)
--				character_format.set_background_color (colors.i_th (3))
--				rich_text.buffered_format (counter * 4 + 2, counter * 4 + 4, character_format)
--				counter := counter + 1
--			end
--			rich_text.flush_buffer
		end
	
feature {NONE} -- Implementation

	colors: ARRAYED_LIST [EV_COLOR] is
			-- Default colors for example.
		once
			create Result.make (10)
			Result.extend ((create {EV_STOCK_COLORS}).red) 	
			Result.extend ((create {EV_STOCK_COLORS}).grey)
			Result.extend ((create {EV_STOCK_COLORS}).dark_yellow)
			Result.extend ((create {EV_STOCK_COLORS}).blue)
			Result.extend ((create {EV_STOCK_COLORS}).cyan)
			Result.extend ((create {EV_STOCK_COLORS}).dark_magenta) 	
			Result.extend ((create {EV_STOCK_COLORS}).green)
			Result.extend ((create {EV_STOCK_COLORS}).dark_red)
			Result.extend ((create {EV_STOCK_COLORS}).yellow) 	
			Result.extend ((create {EV_STOCK_COLORS}).dark_green) 	
		end
	
	build_paragraph_text (a_text: STRING): STRING is
			-- Create `Result' as a set of multiple instances of `a_text'.
		local
			counter: INTEGER
		do
			create Result.make (a_text.count * 19 + 2)
			from
				counter := 1
			until
				counter = 20
			loop
				Result.append (a_text)
				counter := counter + 1
			end
			Result.append ("%N%N")
		end
		
	intro_text_1: STRING is "This example uses a rich text as an advanced text editor, permitting modification of %
	%fonts, paragraph formatting and effects. The class MAIN_WINDOW of this example is generated by EiffelBuild, %
	%and if you have a version of EiffelBuild, you may load and manipulate the project contained in the file %"build_project.bpr%" %
	%located in the root directory of this example.%N%N"
	
	intro_text_2: STRING is "%NThe example has three tool bars:- character, paragraph and tab, with the character and %
	%paragraph toolbars shown by default.%N%N"
	
	intro_text_3: STRING is ":- Contains options for character formatting, including %
	%Font family, shape, weight and height. A background and foreground color may be applied to characters, and a %
	%number of effects are applicable. The %"Offset%" option permits an offset in pixels to be set from the baseline.%N"

	intro_text_4: STRING is ":- Contains left, center, right and justified options. Margins and spacing are also applicable and may be set %
	%through the displayed options. Note that for paragraph formatting, it applies to actual lines only so will be applied not only %
	%on the selected line displayed, but on any line as distinguished by new line characters.%N"
	
	intro_text_5: STRING is ":- Permits manipulation of the tab positions %
	%on an individual basis. Simply drag one of the displayed tab handles to adjust that paticular tab width.%N%N"
	
	intro_text_6: STRING is "Word wrapping may be enabled or disabled via the 'Options', 'Word Wrapping' menu item. %N%NLets now examine %
	%a number of the different formatting options applicable:%N%N"
	
	intro_text_7: STRING is "%NParagraph formatting is performed on actual lines, being the text between two subsequent new line %
	%characters. The arguments for the formatting take displayed lines, and apply to the complete actual lines referenced%N"

end -- class DEFAULT_TEXT_INITIALIZER
