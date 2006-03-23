indexing
	description: "Contains information about the class, title, owner, %
		%location, and size of a MDI child window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MDI_CREATE_STRUCT

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

	WEL_WS_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_class_name: STRING_GENERAL; a_title: STRING_GENERAL) is
			-- Make a MDI create structure with `a_class_name' and
			-- `a_title'.
		do
			structure_make
			set_class_name (a_class_name)
			set_title (a_title)
			set_owner (main_args.current_instance)
			set_x (Cw_usedefault)
			set_y (Cw_usedefault)
			set_width (Cw_usedefault)
			set_height (Cw_usedefault)
			set_style (0)
			set_lparam (default_pointer)
		ensure
			class_name_set: class_name.is_equal (a_class_name)
			title_set: title.is_equal (a_title)
			owner_set: owner.item = main_args.current_instance.item
			style_set: style = 0
			lparam_set: lparam = default_pointer
		end

feature -- Access

	class_name: STRING_32 is
			-- Class name of the MDI child window
		do
			if str_class_name /= Void then
				Result := str_class_name.string
			else
				create Result.make_empty
			end
		ensure
			result_not_void: Result /= Void
		end

	title: STRING_32 is
			-- Title of the MDI child window
		do
			if str_title /= Void then
				Result := str_title.string
			else
				create Result.make_empty
			end
		ensure
			result_not_void: Result /= Void
		end

	owner: WEL_INSTANCE is
			-- Owner of the MDI child window
		do
			create Result.make (cwel_mdi_cs_get_owner (item))
		ensure
			result_not_void: Result /= Void
		end

	x: INTEGER is
			-- x position of the MDI child window
		do
			Result := cwel_mdi_cs_get_x (item)
		end

	y: INTEGER is
			-- y position of the MDI child window
		do
			Result := cwel_mdi_cs_get_y (item)
		end

	width: INTEGER is
			-- Width of the MDI child window
		do
			Result := cwel_mdi_cs_get_width (item)
		end

	height: INTEGER is
			-- Height of the MDI child window
		do
			Result := cwel_mdi_cs_get_height (item)
		end

	style: INTEGER is
			-- Style of the MDI child window
		do
			Result := cwel_mdi_cs_get_style (item)
		end

	lparam: POINTER is
			-- Lparam of the MDI child window
		do
			Result := cwel_mdi_cs_get_lparam (item)
		end

feature -- Element change

	set_class_name (a_class_name: STRING_GENERAL) is
			-- Set `class_name' with `a_class_name'
		require
			a_class_name_valid: a_class_name /= Void
		do
			create str_class_name.make (a_class_name)
			cwel_mdi_cs_set_class_name (item,
				str_class_name.item)
		ensure
			class_name_set: class_name.is_equal (a_class_name)
		end

	set_title (a_title: STRING_GENERAL) is
			-- Set `title' with `a_title'
		require
			a_title_valid: a_title /= Void
		do
			create str_title.make (a_title)
			cwel_mdi_cs_set_title (item, str_title.item)
		ensure
			title_set: title.is_equal (a_title)
		end

	set_owner (an_owner: WEL_INSTANCE) is
			-- Set `owner' with `an_owner'
		require
			an_owner_not_void: an_owner /= Void
		do
			cwel_mdi_cs_set_owner (item, an_owner.item)
		ensure
			owner_set: owner.item = an_owner.item
		end

	set_x (a_x: INTEGER) is
			-- Set `x' with `a_x'
		do
			cwel_mdi_cs_set_x (item, a_x)
		end

	set_y (a_y: INTEGER) is
			-- Set `y' with `a_y'
		do
			cwel_mdi_cs_set_y (item, a_y)
		end

	set_width (a_width: INTEGER) is
			-- Set `width' with `a_width'
		do
			cwel_mdi_cs_set_width (item, a_width)
		end

	set_height (a_height: INTEGER) is
			-- Set `height' with `a_height'
		do
			cwel_mdi_cs_set_height (item, a_height)
		end

	set_style (a_style: INTEGER) is
			-- Set `style' with `a_style'
		do
			cwel_mdi_cs_set_style (item, a_style)
		ensure
			style_set: style = a_style
		end

	set_lparam (a_lparam: POINTER) is
			-- Set `lparam' with `a_lparam'
		do
			cwel_mdi_cs_set_lparam (item, a_lparam)
		ensure
			lparam_set: lparam = a_lparam
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_mdi_cs
		end

feature {NONE} -- Implementation

	str_class_name: WEL_STRING
			-- C string to save the window class name

	str_title: WEL_STRING
			-- C string to save the window title

feature {NONE} -- Implementation

	main_args: WEL_MAIN_ARGUMENTS is
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	c_size_of_mdi_cs: INTEGER is
		external
			"C [macro <mdics.h>]"
		alias
			"sizeof (MDICREATESTRUCT)"
		end

	cwel_mdi_cs_set_class_name (ptr: POINTER; value: POINTER) is
		external
			"C [macro <mdics.h>]"
		end

	cwel_mdi_cs_set_title (ptr: POINTER; value: POINTER) is
		external
			"C [macro <mdics.h>]"
		end

	cwel_mdi_cs_set_owner (ptr: POINTER; value: POINTER) is
		external
			"C [macro <mdics.h>]"
		end

	cwel_mdi_cs_get_owner (ptr: POINTER): POINTER is
		external
			"C [macro <mdics.h>] (MDICREATESTRUCT*): EIF_POINTER"
		end

	cwel_mdi_cs_set_x (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <mdics.h>]"
		end

	cwel_mdi_cs_get_class_name (ptr: POINTER): POINTER is
		external
			"C [macro <mdics.h>] (MDICREATESTRUCT*): EIF_POINTER"
		end

	cwel_mdi_cs_get_class_title (ptr: POINTER): POINTER is
		external
			"C [macro <mdics.h>] (MDICREATESTRUCT*): EIF_POINTER"
		end

	cwel_mdi_cs_get_x (ptr: POINTER): INTEGER is
		external
			"C [macro <mdics.h>]"
		end

	cwel_mdi_cs_set_y (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <mdics.h>]"
		end

	cwel_mdi_cs_get_y (ptr: POINTER): INTEGER is
		external
			"C [macro <mdics.h>]"
		end

	cwel_mdi_cs_set_width (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <mdics.h>]"
		end

	cwel_mdi_cs_get_width (ptr: POINTER): INTEGER is
		external
			"C [macro <mdics.h>]"
		end

	cwel_mdi_cs_set_height (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <mdics.h>]"
		end

	cwel_mdi_cs_get_height (ptr: POINTER): INTEGER is
		external
			"C [macro <mdics.h>]"
		end

	cwel_mdi_cs_set_style (ptr: POINTER; value: INTEGER) is
		external
			"C [macro <mdics.h>]"
		end

	cwel_mdi_cs_get_style (ptr: POINTER): INTEGER is
		external
			"C [macro <mdics.h>]"
		end

	cwel_mdi_cs_set_lparam (ptr: POINTER; value: POINTER) is
		external
			"C [macro <mdics.h>]"
		end

	cwel_mdi_cs_get_lparam (ptr: POINTER): POINTER is
		external
			"C [macro <mdics.h>] (MDICREATESTRUCT*): EIF_POINTER"
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




end -- class WEL_MDI_CREATE_STRUCT

