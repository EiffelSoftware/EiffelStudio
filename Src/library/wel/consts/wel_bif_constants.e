indexing
	description: "Browse Info Folder (BIF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BIF_CONSTANTS

feature -- Access

	Bif_browseforcomputer: INTEGER is
			-- Only return computers. If the user selects
			-- anything other than a computer, the OK button is grayed.
		external
			"C [macro %"shlobj.h%"]"
		alias
			"BIF_BROWSEFORCOMPUTER"
		end

	Bif_browseforprinter: INTEGER is
			-- Only return printers. If the user selects
			-- anything other than a printer, the OK button is grayed.
		external
			"C [macro %"shlobj.h%"]"
		alias
			"BIF_BROWSEFORPRINTER"
		end

	Bif_browseincludefiles: INTEGER is
			-- Requires MVC Version 4.71 or greater. The browse dialog
			-- will display files as well as folders.
		external
			"C [macro %"shlobj.h%"]"
		alias
			"BIF_BROWSEINCLUDEFILES"
		end

	Bif_dontgobelowdomain: INTEGER is
			-- Do not include network folders below the domain level
			-- in the tree view control.
		external
			"C [macro %"shlobj.h%"]"
		alias
			"BIF_DONTGOBELOWDOMAIN"
		end

	Bif_returnfsancestors: INTEGER is
			-- Only return file system ancestors. If the user selects
			-- anything other than a file system ancestor, the OK button
			-- is grayed.
		external
			"C [macro %"shlobj.h%"]"
		alias
			"BIF_RETURNFSANCESTORS"
		end

	Bif_returnonlyfsdirs: INTEGER is
			-- Only return file system directories. If the user selects
			-- folders that are not part of the file system, the OK button
			-- is grayed.
		external
			"C [macro %"shlobj.h%"]"
		alias
			"BIF_RETURNONLYFSDIRS"
		end

	Bif_statustext: INTEGER is
			-- Include a status area in the dialog box. The callback
			-- function can set the status text by sending messages to the
			-- dialog box.
		external
			"C [macro %"shlobj.h%"]"
		alias
			"BIF_STATUSTEXT"
		end

end -- class WEL_BIF_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

