class
	MAIN_DIALOG

inherit
	WEL_MAIN_DIALOG
		redefine
			setup_dialog,
			notify,
			on_control_id_command
		end

	WEL_FONT_FAMILY_ENUMERATOR
		rename
			make as font_family_enumerator_make
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_LBN_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	edit: WEL_MULTIPLE_LINE_EDIT
			-- Edit box

	list_box: WEL_SINGLE_SELECTION_LIST_BOX
			-- List box which contains the fonts

	size: WEL_SINGLE_LINE_EDIT
			-- Edit box to input the size

	current_size: INTEGER
			-- Last size entered by the user

	current_font: WEL_FONT

	make is
			-- Create the main dialog.
		do
			make_by_id (Main_dialog)
			!! edit.make_by_id (Current, Idc_edit)
			!! size.make_by_id (Current, Idc_edit_size)
			!! list_box.make_by_id (Current, Idc_font_list_box)
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
			-- Set the text font with the new font selected
			-- by the user.
		local
			lf: WEL_LOG_FONT
		do
			if control.id = Idc_font_list_box and
				notify_code = Lbn_selchange then
				if size.text.is_integer then
					current_size := size.text.to_integer
				end
				!! lf.make (current_size, list_box.selected_string)
				!! current_font.make_indirect (lf)
				edit.set_font (current_font)
			end
		end

	on_control_id_command (control_id: INTEGER) is
			-- Destroy application when Close button is pushed.
		do
			if control_id = Idc_close_button then
				destroy
			end
		end

	setup_dialog is
			-- Fill the list box with the fonts.
		local		
			dc: WEL_CLIENT_DC
		do
			!! dc.make (Current)
			dc.get
			font_family_enumerator_make (dc, Void)
			dc.release
		end

	action (elf: WEL_ENUM_LOG_FONT; tm: WEL_TEXT_METRIC; font_type: INTEGER) is
			-- Called for each font found.
		do
			if font_type = Truetype_fonttype then
				list_box.add_string (elf.full_name)
			end
		end

end -- class MAIN_DIALOG

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
