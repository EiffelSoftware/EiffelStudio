note
	description: "Toolbar system-defined standard and view bitmaps constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STANDARD_TOOL_BAR_BITMAP_CONSTANTS

feature -- Access

	Std_copy: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_COPY"
		end

	Std_paste: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_PASTE"
		end

	Std_cut: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_CUT"
		end

	Std_print: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_PRINT"
		end

	Std_delete: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_DELETE"
		end

	Std_printpre: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_PRINTPRE"
		end

	Std_filenew: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_FILENEW"
		end

	Std_properties: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_PROPERTIES"
		end

	Std_fileopen: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_FILEOPEN"
		end

	Std_redow: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_REDOW"
		end

	Std_filesave: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_FILESAVE"
		end

	Std_replace: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_REPLACE"
		end

	Std_find: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_FIND"
		end

	Std_undo: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_UNDO"
		end

	Std_help: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_HELP"
		end

	View_largeicons: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_LARGEICONS"
		end

	View_sortname: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_SORTNAME"
		end

	View_smallicons: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_SMALLICONS"
		end

	View_sortsize: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_SORTSIZE"
		end

	View_list: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_LIST"
		end

	View_sortdate: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_SORTDATE"
		end

	View_details: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_DETAILS"
		end

	View_sorttype: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_SORTTYPE"
		end

feature -- Status report

	valid_standard_tool_bar_bitmap_constant (c: INTEGER): BOOLEAN
			-- Is `c' a valid standard tool bar bitmap constant?
		do
			Result := c = Std_copy or else
				c = Std_paste or else
				c = Std_cut or else
				c = Std_print or else
				c = Std_delete or else
				c = Std_printpre or else
				c = Std_filenew or else
				c = Std_properties or else
				c = Std_fileopen or else
				c = Std_redow or else
				c = Std_filesave or else
				c = Std_replace or else
				c = Std_find or else
				c = Std_undo or else
				c = Std_help or else
				c = View_largeicons or else
				c = View_sortname or else
				c = View_smallicons or else
				c = View_sortsize or else
				c = View_list or else
				c = View_sortdate or else
				c = View_details or else
				c = View_sorttype
		end

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




end -- class WEL_STANDARD_TOOL_BAR_BITMAP_CONSTANTS

