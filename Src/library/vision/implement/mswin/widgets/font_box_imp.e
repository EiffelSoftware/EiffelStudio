indexing
	description: "This class represents a MS_IMPfont box";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	FONT_BOX_IMP

inherit
	WEL_FONT_FAMILY_ENUMERATOR
		rename
			make as get_fonts
		redefine
			dispose
		end

	TERMINAL_IMP
		redefine
			build,
			make,
			notify,
			class_name,
			realize_children,
			set_height,
			set_size,
			set_width,
			set_form_width,
			set_form_height,
			dispose
		end

	FONT_BOX_I

	WEL_LBN_CONSTANTS

creation
	make

feature -- Initialization

	make (a_font_box: FONT_BOX; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a font box
		do
			parent ?= oui_parent.implementation
			managed := man
			!! fonts.make
			!! private_attributes
		end

	build is
			-- Build the box.
		do
			if parent.realized and managed then
				realize
			end
		end

	realize_children is
			-- Realize the children.
		local
			dc: WEL_CLIENT_DC
		do
			!! example_text.make (Current, "AbCdEfGhIjKlMnOpQrStUvWxYz1234567890?.,!@#$&", 5, 110, 40, 40, 4)
			!! font_names.make (Current, 5, 5, 10, 100, 1)
			!! font_styles.make (Current, 15, 5, 10, 100, 2)
			!! font_sizes.make (Current, 25, 5, 10, 100, 3)
			!! ok.make (Current, "Ok", 0, 160, 20, 20, 5);
			!! cancel.make (Current, "Cancel", 20, 160, 20, 20, 6)
			!! apply.make (Current, "Apply", 40, 160, 20, 20, 7)
			adjust_controls_width
			adjust_controls_height
			if apply_button_hidden then
				hide_apply_button
			end
			if cancel_button_hidden then
				hide_cancel_button
			end
			if ok_button_hidden then
				hide_ok_button
			end
			!! dc.make (example_text)
			dc.get
			get_fonts (dc, Void)
			dc.release
			fill
		end

feature -- Access

	font_names: WEL_SINGLE_SELECTION_LIST_BOX
			-- List box for font names

	font_styles: WEL_SINGLE_SELECTION_LIST_BOX
			-- List box for font styles

	font_sizes: WEL_SINGLE_SELECTION_LIST_BOX
			-- List box for font sizes

	example_text: WEL_STATIC
			-- Example text for font

	ok: WEL_PUSH_BUTTON
			-- Push button for ok actions

	cancel: WEL_PUSH_BUTTON
			-- Push button for cancel actions

	apply: WEL_PUSH_BUTTON
			-- Push button for apply actions

	apply_button_hidden: BOOLEAN
			-- Is the apply button hidden?

	ok_button_hidden: BOOLEAN
			-- Is the ok button hidden?

	cancel_button_hidden: BOOLEAN
			-- Is the cancel button hidden?

feature -- Status report

	font: FONT 
			-- Font currently selected by the user

feature -- Status setting

	set_font (a_font: FONT) is
			-- Edit `a_font'.
		do
			font := a_font
		end

	set_form_height (a_height: INTEGER) is
			-- Set height to `new_height'.
		do
			if form_height /= a_height then
				private_attributes.set_height (a_height)
				if exists then
					wel_set_height (a_height)
					adjust_controls_height
				end;
			end
		end

	set_form_width (a_width: INTEGER) is
			-- Set the width for form.
		do
			if form_width /= a_width then
				private_attributes.set_width (a_width)
				if exists then
					wel_set_width (a_width)
					adjust_controls_width
				end
			end
		end

	set_height (a_height: INTEGER) is
			-- Set height to `new_height'.
		do
			if private_attributes.height /= a_height then
				private_attributes.set_height (a_height)
				if exists then
					wel_set_height (a_height)
					adjust_controls_height
				end;
				if parent /= Void then
					parent.child_has_resized
				end
			end
		end

	set_size (new_width, new_height: INTEGER) is
			-- Set the height to new_height,
			-- width to `new_width'.
		do
			if private_attributes.height /= new_height
			or else private_attributes.width /= new_width then
				private_attributes.set_width (new_width)
				private_attributes.set_height (new_height)
				if exists then
					resize (new_width, new_height)
					adjust_controls_width
					adjust_controls_height
				end
				if parent /= Void then
					parent.child_has_resized
				end
			end
		end

	set_width (new_width: INTEGER) is
			-- Set width to `new_width'.
		do
			if private_attributes.width /= new_width then
				private_attributes.set_width (new_width)
				if exists then
					wel_set_width (new_width)
					adjust_controls_width
				end;
				if parent /= Void then
					parent.child_has_resized
				end
			end
		end

feature -- Element change

	add_ok_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		do
			ok_actions.add (Current, a_command, arg)
		end

	add_cancel_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		do
			cancel_actions.add (Current, a_command, arg)
		end

	add_apply_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- apply button is activated.
		do
			apply_actions.add (Current, a_command, arg)
		end

	hide_apply_button is
			-- Hide the apply button
		do
			apply_button_hidden := true
			if apply /= Void and then apply.exists then 
				apply.hide
			end
		end

	hide_cancel_button is	
			-- Show the cancel button
		do
			cancel_button_hidden := true
			if cancel /= Void and then cancel.exists then
				cancel.hide
			end
		end

	hide_ok_button is
			-- Hide the ok button
		do
			ok_button_hidden := true
			if ok /= Void and then ok.exists then
				ok.hide
			end
		end

	show_apply_button is 
			-- Show the apply button
		do
			apply_button_hidden := false
			if apply /= Void and then apply.exists then
				apply.show
			end
		end

	show_cancel_button is
			-- Show the cancel button
		do
			cancel_button_hidden := false
			if cancel /= Void and then cancel.exists then	
				cancel.show
			end
		end

	show_ok_button is
			-- Show the ok button
		do
			ok_button_hidden := false
			if ok /= Void and then ok.exists then
				ok.show
			end
		end

feature -- Removal

	remove_apply_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- apply button is activated.
		do
			apply_actions.remove (Current, a_command, arg)
		end

	remove_cancel_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		do
			cancel_actions.remove (Current, a_command, arg)
		end

	remove_ok_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		do
			ok_actions.remove (Current, a_command, arg)
		end

feature -- Implementation

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
			-- Process notification messages
		local
			a_name, a_style: STRING
		do
			if control = ok then
				ok_actions.execute (Current, Void)
			elseif control = cancel then
				cancel_actions.execute (Current, Void)
			elseif control = apply then
				apply_actions.execute (Current, Void)
			elseif control = font_names then
				if notify_code = lbn_selchange then
					select_new_font (font_names.selected_string)
				end
			elseif control = font_sizes then
				if notify_code = lbn_selchange then
					if font_names.selected then
						a_name := font_names.selected_string
					else
						a_name := font_names.i_th_text (0)
					end
					if font_styles.selected then
						a_style := font_styles.selected_string
					else
						a_style := font_styles.i_th_text (0)
					end
					select_new_size (a_name, a_style,
							 font_sizes.selected_string)
				end
			elseif control = font_styles then
				if notify_code = lbn_selchange then
					if font_names.selected then
						a_name := font_names.selected_string
					else
						a_name := font_names.i_th_text (0)
					end
					select_new_style (a_name, font_styles.selected_string)
				end
			end
		end

feature {NONE} -- Implementation

	action (elf: WEL_ENUM_LOG_FONT; tm: WEL_TEXT_METRIC; font_type: INTEGER) is
			-- Called for each font found.
			-- `elf', `tm' and `font_type' contain informations
			-- about the font.
			-- See class WEL_FONT_TYPE_ENUM_CONSTANTS for
			-- `font_type' values.
		local
			efw: ENUMERATED_FONT_WINDOWS
		do
			!! efw.make (elf.log_font.face_name)
			if font_type /= Raster_fonttype then
				efw.set_not_raster
			end
			fonts.extend (efw)
		end

	fill is
			-- Initial fill of lists
		local
			fw: FONT_IMP
			efw: ENUMERATED_FONT_WINDOWS
			dc: WEL_CLIENT_DC
		do
			from
				!! dc.make (example_text)
				dc.get
				fonts.start
			until
				fonts.after
			loop
				font_names.add_string (fonts.item.name)
				fonts.item.get_families (dc, fonts.item.name)
				fonts.forth
			end
			if font /= Void then
				fw ?= font.implementation
				efw := find_font_name (fw.wel_log_font.face_name)
				if efw = Void then
					efw := fonts.first
				end
			else
				efw := fonts.first
			end
			dc.release
			efw.fill (font_styles, font_sizes)
		end

	select_new_font (new_font: STRING) is
			-- Action to perform when a font is selected
		local
			current_style, current_size: STRING;
			efw: ENUMERATED_FONT_WINDOWS
			lefdw: LINKED_LIST [ENUMERATED_FONT_DETAILS_WINDOWS]
			style_selected: BOOLEAN
		do
			if font_styles.selected then
				current_style := font_styles.selected_string
			end
			if font_sizes.selected then
				current_size := font_sizes.selected_string
			end
			efw := find_font_name (new_font)
			from
				lefdw := efw.details
				lefdw.start
				font_styles.reset_content
				font_sizes.reset_content
			until
				lefdw.off
			loop
				font_styles.add_string (lefdw.item.style)
				if current_style /= Void and then lefdw.item.style.is_equal (current_style) then
					style_selected := true
					select_new_style (new_font, current_style)
				end
				lefdw.forth
			end
			if not style_selected then
				current_style := font_styles.i_th_text (0)
				select_new_style (new_font, current_style)
			end
			if current_size /= Void then	
				select_new_size (new_font, current_style, current_size)
			else
				select_new_size (new_font, current_style, font_sizes.i_th_text (0))
			end
			create_font
		end

	select_new_size (new_font, new_style, new_size: STRING) is
			-- Action to perform when a size is selected
		require
			new_size_exists: new_size /= Void
			new_size_integer: new_size.is_integer
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > font_sizes.count
			loop
				if font_sizes.i_th_text (i-1).to_integer >= new_size.to_integer then
					font_sizes.select_item (i-1)
					i := font_sizes.count + 1
				end
				i := i + 1
			end
			create_font
		end

	select_new_style (new_font, new_style: STRING) is
			-- Action to perform when a style is selected
		require
			new_style_exists: new_style /= Void
		local
			efw: ENUMERATED_FONT_WINDOWS
			efdw: ENUMERATED_FONT_DETAILS_WINDOWS
		do
			efw := find_font_name (font_names.selected_string)
			if efw /= Void then
				efdw := efw.find_style (new_style)
				efdw.fill_sizes (font_sizes)
				create_font
			end
		end

	fonts: SORTED_TWO_WAY_LIST [ENUMERATED_FONT_WINDOWS]
			-- List of fonts in system

	find_font_name (font_name: STRING): ENUMERATED_FONT_WINDOWS is
			-- Find the font given the name
		local
			c: CURSOR
		do
			from
				c := fonts.cursor
				fonts.start
			until
				Result /= Void or fonts.off
			loop
				if fonts.item.name.is_equal (font_name) then
					Result := fonts.item
				end
				fonts.forth
			end
			fonts.go_to (c)
		end

	adjust_controls_height is
			-- Resize control heights
		require
			exists: exists
		local
			usable_height: INTEGER
			item_count: INTEGER
			nearest_possible_height: INTEGER
			rest: INTEGER
		do
			if height > 15 then
				usable_height := (height - 15) * 4 // 5
				example_text.set_y (usable_height + 5)
			else
				usable_height := height * 4 // 5
				example_text.set_y (usable_height)
			end
			item_count := usable_height // font_names.item_height
			rest := usable_height \\ font_names.item_height
			if rest > (font_names.item_height // 2) then
				nearest_possible_height := (item_count + 1) * font_names.item_height +
				2 * Border_height
			else
				nearest_possible_height := item_count * font_names.item_height +
				2 * Border_height
			end
			font_names.set_height (nearest_possible_height)
			font_styles.set_height (nearest_possible_height)
			font_sizes.set_height (nearest_possible_height)
			example_text.set_y (nearest_possible_height + 10)
			example_text.set_height (nearest_possible_height // 4)
		end

	adjust_controls_width is
			-- Resize control widths
		require
			exists: exists
		local
			usable_width: INTEGER
		do
			if width > 20 then
				usable_width := width - 20
				font_names.set_width (usable_width  * 30 // 55)
				font_styles.set_width (usable_width * 17 // 55)
				font_sizes.set_width (usable_width * 8 // 55)
				font_styles.set_x (font_names.width + 10)
				font_sizes.set_x (font_styles.x + font_styles.width + 5)
				example_text.set_width (usable_width)
			else
				font_names.set_width (width  * 30 // 64)
				font_styles.set_width (width * 20 // 64)
				font_sizes.set_width (width * 5 // 64)
				font_styles.set_x (font_names.width)
				font_sizes.set_x (font_styles.x + font_styles.width)
				example_text.set_width (width)
			end
		end

	create_font is
			-- Create font
		local
			efw: ENUMERATED_FONT_WINDOWS
			efdw: ENUMERATED_FONT_DETAILS_WINDOWS
			wlf: WEL_LOG_FONT
			wf: WEL_FONT
			fw: FONT_IMP
		do
			if font_names.selected then 
				efw := find_font_name (font_names.selected_string)
			else
				efw := find_font_name (font_names.i_th_text (0))
			end
			if font_styles.selected then
				efdw := efw.find_style (font_styles.selected_string)
			else
				efdw := efw.find_style (font_styles.i_th_text (0))
			end
			if font_sizes.selected then
				wlf := efdw.find_log_font (font_sizes.selected_string)
			else
				wlf := efdw.find_log_font (font_sizes.i_th_text (0))
			end
			!! font.make
			fw ?= font.implementation
			!! wf.make_indirect (wlf)
			fw.make_by_wel (wf)
			example_text.set_font (wf)
			example_text.invalidate
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionFontBox"
		end

	Border_height: INTEGER is
			-- Height of the border
		once
			Result := window_border_height
		end

feature {NONE} -- Dispose feature

	dispose is
		do
			{TERMINAL_IMP} Precursor
			{WEL_FONT_FAMILY_ENUMERATOR} Precursor
		end

invariant
	fonts_exist: fonts /= Void

end -- class FONT_BOX_IMP
 

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

