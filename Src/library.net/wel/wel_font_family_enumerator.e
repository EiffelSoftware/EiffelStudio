indexing
	description: "[
		Font family enumerator. The user must inherit from this
		class and define the routine `action'.
		
		Note: Do not use more than one instance of this class at the same
			time. Nested enumerations are not supported.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_FONT_FAMILY_ENUMERATOR

inherit
	WEL_FONT_TYPE_ENUM_CONSTANTS
		export
			{NONE} all
		end

	DISPOSABLE

feature {NONE} -- Initialization

	make (dc: WEL_DC; family: STRING) is
			-- Enumerate the fonts in the font `family' that are
			-- available on the `dc'.
			-- If `family' is Void, Windows randomly selects and
			-- enumerates one font of each available type family.
		require
			dc_not_void: dc /= Void
			dc_exits: dc.exists
		do
			create font_enumerator_delegate.make (Current, $update_current)
			cwel_set_enum_font_fam_procedure_address (font_enumerator_delegate)
			font_enumerator_object := {GC_HANDLE}.alloc (Current)
			cwel_set_font_family_enumerator_object
				({GC_HANDLE}.to_pointer (font_enumerator_object))

			enumerate (dc, family)

			cwel_set_enum_font_fam_procedure_address (Void)
			cwel_set_font_family_enumerator_object (default_pointer)
		end

feature -- Basic operations

	action (elf: WEL_ENUM_LOG_FONT; tm: WEL_TEXT_METRIC; font_type: INTEGER) is
			-- Called for each font found.
			-- `elf', `tm' and `font_type' contain informations
			-- about the font.
			-- See class WEL_FONT_TYPE_ENUM_CONSTANTS for
			-- `font_type' values.
		require
			elf_not_void: elf /= Void
			tm_not_void: tm /= Void
		deferred
		end

	init_action is
			-- Called before the enumeration.
			-- May be redefined to make special operations.
		do
		end

	finish_action is
			-- Called after the enumeration.
			-- May be redefined to make special operations.
		do
		end

feature {NONE} -- Implementation

	enumerate (dc: WEL_DC; family: STRING) is
			-- Enumerate `family' on `dc'
		require
			dc_not_void: dc /= Void
			dc_exits: dc.exists
		local
			p: POINTER
			str: WEL_STRING
		do
			init_action
			if family /= Void then
				create str.make (family)
				p := str.item
			end
			cwin_enum_font_families (dc.item, p, cwel_enum_font_fam_procedure, default_pointer)
			finish_action
		end

	update_current (lpelf, lpntm: POINTER; font_type: INTEGER; extra: POINTER) is
			-- Convert Windows pointers into Eiffel objects and
			-- call `action'.
		local
			elf: WEL_ENUM_LOG_FONT
			tm: WEL_TEXT_METRIC
		do
			create elf.make_with_pointer (lpelf)
			create tm.make_by_pointer (lpntm)
			action (elf, tm, font_type)
		end

feature {NONE} -- Memory management

	font_enumerator_object: GC_HANDLE
			-- Handle to Current object.

	font_enumerator_delegate: WEL_ENUM_FONT_DELEGATE
			-- Delegate for callbacks.

	dispose is
		do
			font_enumerator_object.free
		end

feature {NONE} -- Externals

	cwel_set_enum_font_fam_procedure_address (address: WEL_ENUM_FONT_DELEGATE) is
		external
			"C [macro %"enumfont.h%"]"
		end

	cwel_set_font_family_enumerator_object (object: POINTER) is
		external
			"C [macro %"enumfont.h%"]"
		end

	cwel_release_font_family_enumerator_object is
		external
			"C [macro %"enumfont.h%"]"
		end

	cwel_enum_font_fam_procedure: POINTER is
		external
			"C [macro %"enumfont.h%"] :EIF_POINTER"
		end

	cwin_enum_font_families (hdc, family, enum_proc, data: POINTER) is
			-- SDK EnumFontFamilies
		external
			"C [macro %"windows.h%"] (HDC, LPCTSTR, FONTENUMPROC, LPARAM)"
		alias
			"EnumFontFamilies"
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


end -- class WEL_FONT_FAMILY_ENUMERATOR

