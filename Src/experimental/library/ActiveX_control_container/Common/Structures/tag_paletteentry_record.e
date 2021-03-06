note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

class
	TAG_PALETTEENTRY_RECORD

inherit
	ECOM_STRUCTURE
		redefine
			make
		end

create
	make,
	make_from_pointer

feature {NONE}  -- Initialization

	make
			-- Make.
		do
			Precursor {ECOM_STRUCTURE}
		end

	make_from_pointer (a_pointer: POINTER)
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	pe_red: CHARACTER
			-- No description available.
		do
			Result := ccom_tag_paletteentry_pe_red (item)
		end

	pe_green: CHARACTER
			-- No description available.
		do
			Result := ccom_tag_paletteentry_pe_green (item)
		end

	pe_blue: CHARACTER
			-- No description available.
		do
			Result := ccom_tag_paletteentry_pe_blue (item)
		end

	pe_flags: CHARACTER
			-- No description available.
		do
			Result := ccom_tag_paletteentry_pe_flags (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of structure
		do
			Result := c_size_of_tag_paletteentry
		end

feature -- Basic Operations

	set_pe_red (a_pe_red: CHARACTER)
			-- Set `pe_red' with `a_pe_red'.
		do
			ccom_tag_paletteentry_set_pe_red (item, a_pe_red)
		end

	set_pe_green (a_pe_green: CHARACTER)
			-- Set `pe_green' with `a_pe_green'.
		do
			ccom_tag_paletteentry_set_pe_green (item, a_pe_green)
		end

	set_pe_blue (a_pe_blue: CHARACTER)
			-- Set `pe_blue' with `a_pe_blue'.
		do
			ccom_tag_paletteentry_set_pe_blue (item, a_pe_blue)
		end

	set_pe_flags (a_pe_flags: CHARACTER)
			-- Set `pe_flags' with `a_pe_flags'.
		do
			ccom_tag_paletteentry_set_pe_flags (item, a_pe_flags)
		end

feature {NONE}  -- Externals

	c_size_of_tag_paletteentry: INTEGER
			-- Size of structure
		external
			"C [macro %"ecom_control_library_tagPALETTEENTRY_s.h%"]"
		alias
			"sizeof(ecom_control_library::tagPALETTEENTRY)"
		end

	ccom_tag_paletteentry_pe_red (a_pointer: POINTER): CHARACTER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagPALETTEENTRY_s_impl.h%"](ecom_control_library::tagPALETTEENTRY *):EIF_CHARACTER"
		end

	ccom_tag_paletteentry_set_pe_red (a_pointer: POINTER; arg2: CHARACTER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagPALETTEENTRY_s_impl.h%"](ecom_control_library::tagPALETTEENTRY *, UCHAR)"
		end

	ccom_tag_paletteentry_pe_green (a_pointer: POINTER): CHARACTER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagPALETTEENTRY_s_impl.h%"](ecom_control_library::tagPALETTEENTRY *):EIF_CHARACTER"
		end

	ccom_tag_paletteentry_set_pe_green (a_pointer: POINTER; arg2: CHARACTER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagPALETTEENTRY_s_impl.h%"](ecom_control_library::tagPALETTEENTRY *, UCHAR)"
		end

	ccom_tag_paletteentry_pe_blue (a_pointer: POINTER): CHARACTER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagPALETTEENTRY_s_impl.h%"](ecom_control_library::tagPALETTEENTRY *):EIF_CHARACTER"
		end

	ccom_tag_paletteentry_set_pe_blue (a_pointer: POINTER; arg2: CHARACTER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagPALETTEENTRY_s_impl.h%"](ecom_control_library::tagPALETTEENTRY *, UCHAR)"
		end

	ccom_tag_paletteentry_pe_flags (a_pointer: POINTER): CHARACTER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagPALETTEENTRY_s_impl.h%"](ecom_control_library::tagPALETTEENTRY *):EIF_CHARACTER"
		end

	ccom_tag_paletteentry_set_pe_flags (a_pointer: POINTER; arg2: CHARACTER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagPALETTEENTRY_s_impl.h%"](ecom_control_library::tagPALETTEENTRY *, UCHAR)"
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




end -- TAG_PALETTEENTRY_RECORD

