indexing
	description: "List view message (LVM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LVM_CONSTANTS

feature -- Access

	Lvm_arrange: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_ARRANGE"
		end

	Lvm_createdragimage: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_CREATEDRAGIMAGE"
		end

	Lvm_deleteallitems: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_DELETEALLITEMS"
		end

	Lvm_deletecolumn: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_DELETECOLUMN"
		end

	Lvm_deleteitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_DELETEITEM"
		end

	Lvm_editlabel: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_EDITLABEL"
		end

	Lvm_ensurevisible: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_ENSUREVISIBLE"
		end

	Lvm_finditem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_FINDITEM"
		end

	Lvm_getbkcolor: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETBKCOLOR"
		end

	Lvm_getcallbackmask: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETCALLBACKMASK"
		end

	Lvm_getcolumn: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETCOLUMN"
		end

	Lvm_getcolumnwidth: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETCOLUMNWIDTH"
		end

	Lvm_getcountperpage: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETCOUNTPERPAGE"
		end

	Lvm_geteditcontrol: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETEDITCONTROL"
		end

	Lvm_getimagelist: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETIMAGELIST"
		end

	Lvm_getisearchstring: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETISEARCHSTRING"
		end

	Lvm_getitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETITEM"
		end

	Lvm_getitemcount: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETITEMCOUNT"
		end

	Lvm_getitemposition: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETITEMPOSITION"
		end

	Lvm_getitemrect: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETITEMRECT"
		end

	Lvm_getitemspacing: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETITEMSPACING"
		end

	Lvm_getitemstate: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETITEMSTATE"
		end

	Lvm_getitemtext: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETITEMTEXT"
		end

	Lvm_getnextitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETNEXTITEM"
		end

	Lvm_getorigin: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETORIGIN"
		end

	Lvm_getselectedcount: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETSELECTEDCOUNT"
		end

	Lvm_getstringwidth: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETSTRINGWIDTH"
		end

	Lvm_gettextbkcolor: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETTEXTBKCOLOR"
		end

	Lvm_gettextcolor: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETTEXTCOLOR"
		end

	Lvm_gettopindex: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETTOPINDEX"
		end

	Lvm_getviewrect: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_GETVIEWRECT"
		end

	Lvm_hittest: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_HITTEST"
		end

	Lvm_insertcolumn: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_INSERTCOLUMN"
		end

	Lvm_insertitem: INTEGER is
		external
			"c [macro %"cctrl.h%"]"
		alias
			"LVM_INSERTITEM"
		end

	Lvm_redrawitems: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_REDRAWITEMS"
		end

	Lvm_scroll: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SCROLL"
		end

	Lvm_setbkcolor: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SETBKCOLOR"
		end

	Lvm_setcallbackmask: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SETCALLBACKMASK"
		end

	Lvm_setcolumn: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SETCOLUMN"
		end

	Lvm_setcolumnwidth: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SETCOLUMNWIDTH"
		end

	Lvm_setimagelist: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SETIMAGELIST"
		end

	Lvm_setitem: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SETITEM"
		end

	Lvm_setitemcount: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SETITEMCOUNT"
		end

	Lvm_setitemposition: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SETITEMPOSITION"
		end

	Lvm_setitemposition32: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SETITEMPOSITION32"
		end

	Lvm_setitemstate: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SETITEMSTATE"
		end

	Lvm_setitemtext: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SETITEMTEXT"
		end

	Lvm_settextbkcolor: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SETTEXTBKCOLOR"
		end

	Lvm_settextcolor: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SETTEXTCOLOR"
		end

	Lvm_sortitems: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_SORTITEMS"
		end

	Lvm_update: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"LVM_UPDATE"
		end

end -- class WEL_LVM_CONSTANTS

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
