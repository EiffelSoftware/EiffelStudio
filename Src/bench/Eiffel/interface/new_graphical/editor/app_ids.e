indexing
	description: "Constants from the ressource file"

class
	APPLICATION_IDS

feature -- Access

	Id_ico_application			: INTEGER is 1
	Id_ico_child_window			: INTEGER is 2
	Id_menu_application			: INTEGER is 1

	Cmd_file_open				: INTEGER is 100
	Cmd_file_close				: INTEGER is 101
	Cmd_file_exit				: INTEGER is 102

	Cmd_edit_undo				: INTEGER is 103
	Cmd_edit_redo				: INTEGER is 104
	Cmd_edit_cut				: INTEGER is 105
	Cmd_edit_copy				: INTEGER is 106
	Cmd_edit_paste				: INTEGER is 107
	Cmd_edit_indent				: INTEGER is 108
	Cmd_edit_unindent			: INTEGER is 109
	Cmd_edit_comment			: INTEGER is 110
	Cmd_edit_uncomment			: INTEGER is 111

	Cmd_window_tile_vertical	: INTEGER is 200
	Cmd_window_tile_horizontal	: INTEGER is 201
	Cmd_window_cascade			: INTEGER is 202
	Cmd_window_arrange			: INTEGER is 203

end -- class APPLICATION_IDS

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
