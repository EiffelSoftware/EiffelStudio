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

	APPLICATION_IDS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create the main dialog.
		do
			make_by_id (Main_dialog)
		end

feature -- Basic operations

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
