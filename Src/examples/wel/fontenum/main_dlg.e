class
	MAIN_DIALOG

inherit
	WEL_MAIN_DIALOG
		redefine
			setup_dialog,
			notify,
			on_control_id_command,
			dispose
		end

	WEL_FONT_FAMILY_ENUMERATOR
		rename
			make as font_family_enumerator_make
		redefine
			dispose
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

	make is
			-- Create the main dialog.
		do
			make_by_id (Main_dialog)
			create edit.make_by_id (Current, Idc_edit)
			create size.make_by_id (Current, Idc_edit_size)
			create list_box.make_by_id (Current, Idc_font_list_box)
		end

feature -- Access

	edit: WEL_MULTIPLE_LINE_EDIT
			-- Edit box

	list_box: WEL_SINGLE_SELECTION_LIST_BOX
			-- List box which contains the fonts

	size: WEL_SINGLE_LINE_EDIT
			-- Edit box to input the size

	current_size: INTEGER
			-- Last size entered by the user

	current_font: WEL_FONT
			-- Current font selected

feature -- Basic operations

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
				create lf.make (current_size, list_box.selected_string)
				create current_font.make_indirect (lf)
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
			create dc.make (Current)
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

	dispose is
			-- Called when the main dialog is destroyed.
		do
			{WEL_FONT_FAMILY_ENUMERATOR} Precursor
			{WEL_MAIN_DIALOG} Precursor
		end

end -- class MAIN_DIALOG

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

