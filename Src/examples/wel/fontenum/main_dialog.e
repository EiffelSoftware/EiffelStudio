note
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make
			-- Create the main dialog.
		do
			make_by_id (Main_dialog)
			create edit.make_by_id (Current, Idc_edit)
			create size.make_by_id (Current, Idc_edit_size)
			create list_box.make_by_id (Current, Idc_font_list_box)
		end

feature -- Access

	edit: detachable WEL_MULTIPLE_LINE_EDIT
			-- Edit box

	list_box: detachable WEL_SINGLE_SELECTION_LIST_BOX
			-- List box which contains the fonts

	size: detachable WEL_SINGLE_LINE_EDIT
			-- Edit box to input the size

	current_size: INTEGER
			-- Last size entered by the user

	current_font: detachable WEL_FONT
			-- Current font selected

feature -- Basic operations

	notify (control: WEL_CONTROL; notify_code: INTEGER)
			-- Set the text font with the new font selected
			-- by the user.
		local
			lf: WEL_LOG_FONT
			l_font: like current_font
			l_size: like size
			l_edit: like edit
			l_list_box: like list_box
		do
			if control.id = Idc_font_list_box and
				notify_code = Lbn_selchange then
				l_size := size
				l_list_box := list_box
				l_edit := edit
					-- Per invariant
				check
					l_size_attached: l_size /= Void
					l_list_box_attached: l_list_box /= Void
					l_edit_attached: l_edit /= Void
				end
				if l_size.text.is_integer then
					current_size := l_size.text.to_integer
				end
				create lf.make (current_size, l_list_box.selected_string)
				create l_font.make_indirect (lf)
				current_font := l_font
				l_edit.set_font (l_font)
			end
		end

	on_control_id_command (control_id: INTEGER)
			-- Destroy application when Close button is pushed.
		do
			if control_id = Idc_close_button then
				destroy
			end
		end

	setup_dialog
			-- Fill the list box with the fonts.
		local
			dc: WEL_CLIENT_DC
		do
			create dc.make (Current)
			dc.get
			font_family_enumerator_make (dc, Void)
			dc.release
		end

	action (elf: WEL_ENUM_LOG_FONT; tm: WEL_TEXT_METRIC; font_type: INTEGER)
			-- Called for each font found.
		local
			l_list_box: like list_box
		do
			if font_type = Truetype_fonttype then
				l_list_box := list_box
					-- Per invariant
				check l_list_box_attached: l_list_box /= Void end
				l_list_box.add_string (elf.full_name)
			end
		end

	dispose
			-- Called when the main dialog is destroyed.
		do
			Precursor {WEL_FONT_FAMILY_ENUMERATOR}
			Precursor {WEL_MAIN_DIALOG}
		end

invariant
	edit_attached: edit /= Void
	size_attached: size /= Void
	list_box_attached: list_box /= Void

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

end -- class MAIN_DIALOG
