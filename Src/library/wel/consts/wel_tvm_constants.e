indexing
	description: "Tree view message (TVM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TVM_CONSTANTS

feature -- Access

	Tvm_createdragimage: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_CREATEDRAGIMAGE"
		end

	Tvm_deleteitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_DELETEITEM"
		end

	Tvm_editlabel: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_EDITLABEL"
		end

	Tvm_endeditlabelnow: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_ENDEDITLABELNOW"
		end

	Tvm_ensurevisible: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_ENSUREVISIBLE"
		end

	Tvm_expand: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_EXPAND"
		end

	Tvm_getcount: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_GETCOUNT"
		end

	Tvm_geteditcontrol: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_GETEDITCONTROL"
		end

	Tvm_getimagelist: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_GETIMAGELIST"
		end

	Tvm_getindent: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_GETINDENT"
		end

	Tvm_getisearchstring: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_GETISEARCHSTRING"
		end

	Tvm_getitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_GETITEM"
		end

	Tvm_getitemrect: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_GETITEMRECT"
		end

	Tvm_getnextitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_GETNEXTITEM"
		end

	Tvm_getvisiblecount: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_GETVISIBLECOUNT"
		end

	Tvm_hittest: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_HITTEST"
		end

	Tvm_insertitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_INSERTITEM"
		end

	Tvm_selectitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_SELECTITEM"
		end

	Tvm_setimagelist: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_SETIMAGELIST"
		end

	Tvm_setindent: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_SETINDENT"
		end

	Tvm_setitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_SETITEM"
		end

	Tvm_sortchildren: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_SORTCHILDREN"
		end

	Tvm_sortchildrencb: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TVM_SORTCHILDRENCB"
		end

end -- class WEL_TVM_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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

