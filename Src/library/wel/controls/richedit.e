indexing
	description: "A control in which the user can enter and edit rich text."
	note: "Rich edit DLL needs to be loaded. See class WEL_RICH_EDIT_DLL."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RICH_EDIT

inherit
	WEL_MULTIPLE_LINE_EDIT
		redefine
			class_name
		end

	WEL_RICH_EDIT_MESSAGE_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature -- Status report

	default_char_format: WEL_CHARACTER_FORMAT is
			-- Default character format information
		do
			!! Result.make
			Result.set_all_masks
			cwin_send_message (item, Em_getcharformat, 0,
				Result.to_integer)
		ensure
			result_not_void: Result /= Void
		end

	current_selection_char_format: WEL_CHARACTER_FORMAT is
			-- Current selection character format information
		do
			!! Result.make
			Result.set_all_masks
			cwin_send_message (item, Em_getcharformat, 1,
				Result.to_integer)
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_character_format_selection (a_char_format: WEL_CHARACTER_FORMAT) is
			-- Set the current selection with `a_char_format'.
		require
			a_char_format_not_void: a_char_format /= Void
		do
			cwin_send_message (item, Em_setcharformat,
				Scf_selection, a_char_format.to_integer)
		end

	set_character_format_word (a_char_format: WEL_CHARACTER_FORMAT) is
			-- Set the current word with `a_char_format'.
		require
			a_char_format_not_void: a_char_format /= Void
		do
			cwin_send_message (item, Em_setcharformat,
				Scf_word + Scf_selection,
				a_char_format.to_integer)
		end

	set_paragraph_format (a_para_format: WEL_PARAGRAPH_FORMAT) is
			-- Set the current paragraph with `a_para_format'.
		require
			a_para_format_not_void: a_para_format /= Void
		do
			cwin_send_message (item, Em_setparaformat, 0,
				a_para_format.to_integer)
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			Result := "RichEdit"
		end

feature {NONE} -- Externals

	Scf_selection: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"SCF_SELECTION"
		end

	Scf_word: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"SCF_WORD"
		end

end -- class WEL_RICH_EDIT

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
