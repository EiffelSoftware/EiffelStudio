indexing
	description: "Common controls initialization constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ICC_CONSTANTS

feature -- Access

	Icc_animate_class: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"ICC_ANIMATE_CLASS"
		end

	Icc_bar_classes: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"ICC_BAR_CLASSES"
		end

	Icc_cool_classes: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"ICC_COOL_CLASSES"
		end

	Icc_date_classes: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"ICC_DATE_CLASSES"
		end

	Icc_hotkey_class: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"ICC_HOTKEY_CLASS"
		end

	Icc_listview_classes: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"ICC_LISTVIEW_CLASSES"
		end

	Icc_progress_class: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"ICC_PROGRESS_CLASS"
		end

	Icc_tab_classes: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"ICC_TAB_CLASSES"
		end

	Icc_treeview_classes: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"ICC_TREEVIEW_CLASSES"
		end

	Icc_updown_class: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"ICC_UPDOWN_CLASS"
		end

	Icc_userex_classes: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"ICC_USEREX_CLASSES"
		end

	Icc_win95_classes: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"ICC_WIN95_CLASSES"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_ICC_CONSTANTS

