indexing
	description: "Toolbar system-defined standard and view bitmaps constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STANDARD_TOOL_BAR_BITMAP_CONSTANTS

feature -- Access

	Std_copy: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_COPY"
		end

	Std_paste: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_PASTE"
		end

	Std_cut: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_CUT"
		end

	Std_print: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_PRINT"
		end

	Std_delete: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_DELETE"
		end

	Std_printpre: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_PRINTPRE"
		end

	Std_filenew: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_FILENEW"
		end

	Std_properties: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_PROPERTIES"
		end

	Std_fileopen: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_FILEOPEN"
		end

	Std_redow: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_REDOW"
		end

	Std_filesave: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_FILESAVE"
		end

	Std_replace: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_REPLACE"
		end

	Std_find: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_FIND"
		end

	Std_undo: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_UNDO"
		end

	Std_help: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"STD_HELP"
		end

	View_largeicons: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_LARGEICONS"
		end

	View_sortname: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_SORTNAME"
		end

	View_smallicons: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_SMALLICONS"
		end

	View_sortsize: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_SORTSIZE"
		end

	View_list: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_LIST"
		end

	View_sortdate: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_SORTDATE"
		end

	View_details: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_DETAILS"
		end

	View_sorttype: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"VIEW_SORTTYPE"
		end

feature -- Status report

	valid_standard_tool_bar_bitmap_constant (c: INTEGER): BOOLEAN is
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

end -- class WEL_STANDARD_TOOL_BAR_BITMAP_CONSTANTS


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

