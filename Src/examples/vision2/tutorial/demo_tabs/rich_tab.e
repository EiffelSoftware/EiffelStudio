indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RICH_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects.
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
			h1: EV_HORIZONTAL_SEPARATOR
		once
			{ANY_TAB} Precursor (Void)

			create cmd1.make (~set_font_style)
			create cmd2.make (~get_font_style)
			create c1.make (Current, 0, 0, "Font Style", cmd1, cmd2)
			create normal.make_with_text (c1.combo, "Normal")
			create bold.make_with_text (c1.combo, "Bold")
			create italic.make_with_text (c1.combo, "Italic")



			create cmd1.make (~set_font_color)
			create cmd2.make (~get_font_color)
			create c2.make (Current, 1, 0, "Font Color", cmd1, cmd2)
			create red.make_with_text (c2.combo, "Red")
			create green.make_with_text (c2.combo, "Green")
			create blue.make_with_text (c2.combo, "Blue")


			create cmd1.make (~set_font)
			create cmd2.make (~get_font)
			create c3.make (Current, 2, 0, "Type Face", cmd1, cmd2)
			create font1.make_with_text (c3.combo, "Times New Roman")
			create font2.make_with_text (c3.combo, "Arial")
			create font3.make_with_text (c3.combo, "Wingdings")

			create cmd1.make (~set_font_size)
			create cmd2.make (~get_font_size)
			create f1.make (Current, 3, 0, "Font Size", cmd1, cmd2)

			create cmd1.make (~set_line_number)
			create cmd2.make (~get_line_number)
			create f2.make (Current, 4, 0, "Line Number", cmd1, cmd2)
			
			create cmd1.make (~remove_text)
			create b1.make_with_text (Current, "Remove Selected Text")
			b1.add_click_command(cmd1, Void)
			set_child_position (b1, 7, 1, 8, 2)
			b1.set_vertical_resize(False)

	--		create h1.make (Current)
	--		set_child_position (h1, 8, 0, 9, 3)
			set_parent(par)
		end

	name:STRING is
			-- Returns the name of the tab.
		do
			Result:="Rich Text"
		end


feature -- Access

	
	set_font_style (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the font style of the selected font.
		local
			new_format: EV_CHARACTER_FORMAT
		do
			if current_widget.has_selection then
			create new_format.make
				if c1.combo.selected_item = Bold then
					new_format.set_bold (True)
					new_format.set_italic (False)
				elseif c1.combo.selected_item = Italic then
					new_format.set_italic (True)
					new_format.set_bold (False)
				else
					new_format.set_italic (False)
					new_format.set_bold (False)					
				end
				current_widget.set_character_format(new_format)
			end
		end

	get_font_style (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the font style of current selected text.
		do
			if current_widget.has_selection then
				if current_widget.character_format.is_bold then
					bold.set_selected (True)
				elseif current_widget.character_format.is_italic then
					italic.set_selected (True)
				else
					normal.set_selected (True)
				end
			end
		end

	set_font_color (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the color of the selected text.
		local
			new_format: EV_CHARACTER_FORMAT
			color: EV_COLOR
		do
			if current_widget.has_selection then
				create new_format.make
				create color.make
				if c2.combo.selected_item = red then
					color.set_rgb (255,0,0)
				elseif c2.combo.selected_item = green then
					color.set_rgb (0,255,0)
				elseif c2.combo.selected_item = blue then
					color.set_rgb (0,0,255)		
				end
				new_format.set_color (color)
				current_widget.set_character_format(new_format)	
			end		
		end

	get_font_color (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the color of the selected text.
		do
		end

	set_font (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the font of the selected text.
		local
			new_format: EV_CHARACTER_FORMAT
			font: EV_FONT
		do
			if current_widget.has_selection then
				create new_format.make
				create font.make
				if c3.combo.selected_item = font1 then
					font.set_name("Times New Roman")
					font.set_height(current_widget.character_format.font.height)
				elseif c3.combo.selected_item = font2 then
					font.set_name("Arial")
					font.set_height(current_widget.character_format.font.height)
				elseif c3.combo.selected_item = font3 then
					 font.set_name("Wingdings")
				end
				new_format.set_font (font)
				current_widget.set_character_format(new_format)
			end
		end

	get_font (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Displays the font name of the selected text.
		do
		end

	set_font_size (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the font size of the selected text.
		local
			new_format: EV_CHARACTER_FORMAT
			font: EV_FONT
		do
			if current_widget.has_selection and f1.get_text.is_integer then
				create new_format.make
				font ?= current_widget.character_format.font
				font.set_height(f1.get_text.to_integer)
				new_format.set_font(font)
				current_widget.set_character_format(new_format)	
			end	
		end

	get_font_size (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Displays the font size of the selected text.
		do
		end

	set_line_number (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		-- Sets the line number in the rich edit primitive.
		do
		end

	get_line_number (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the current line number on which the cursor is set to.
		do
		end

	remove_text (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Removes selected text
		do
			if current_widget.has_selection then
				current_widget.remove_text(current_widget.selection_start, current_widget.selection_end)
			end
		end

	current_widget: EV_RICH_TEXT

	f1, f2, f3: TEXT_FEATURE_MODIFIER
		-- text box for feature modification
   
	c1, c2, c3: COMBO_FEATURE_MODIFIER
		-- combo box selector for feature modification

	bold, italic, normal: EV_LIST_ITEM
		-- combo box option for font style
	red, green, blue: EV_LIST_ITEM
		-- combo box option for font color
	font1, font2, font3: EV_LIST_ITEM
		-- combo box option for font

	b1: EV_BUTTON
end -- class RICH_TAB

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

