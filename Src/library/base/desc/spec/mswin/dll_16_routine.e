indexing

	description:
		"16 bit DLL routine for Windows";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DLL_16_ROUTINE

inherit
	SHARED_LIBRARY_ROUTINE
		redefine
			shared_library
		end

creation
	make_by_name, make_by_index

feature

	make_by_index (lib: DLL_16; r_index: INTEGER;
				arg_types: ARRAY [INTEGER]; ret_type: INTEGER) is
			-- Connect to the routine of index `r_index' in library `lib'
		require
			library_exists: lib /= Void
			meaningful: lib.meaningful
			valid_index: r_index > 0
			valid_argument_array: arg_types /= Void
			valid_argument_types: valid_argument_types (arg_types)
			valid_return_type: valid_return_type (ret_type)
		do
			shared_library := lib
			library_index := r_index
			function_handle := desc_get_function_index_pointer (lib.module_handle, r_index)
			if function_handle /= default_pointer then
				error_code := No_error
			else
				error_code := No_routine
			end
			argument_types := arg_types
			return_type := ret_type
			make_argument_array
			routine_called := False
		ensure
			consistent_index: library_index = r_index
			consistent_lib: lib = shared_library
			routine_not_called: not routine_called
		end

	make_by_name (lib: DLL_16; f_name: STRING;
				arg_types: ARRAY [INTEGER]; ret_type: INTEGER) is
			-- Connect to the routine `f_name' in library `lib'
		local
			c_func_name: ANY
		do
			shared_library := lib
			function_name := f_name
			c_func_name := f_name.to_c
			function_handle := desc_get_function_pointer (lib.module_handle, $c_func_name)
			if function_handle /= default_pointer then
				error_code := No_error
			else
				error_code := No_routine
			end
			argument_types := arg_types
			return_type := ret_type
			make_argument_array
			routine_called := False
		end

feature -- Basic operations

	call (args: ARRAY [ANY]) is
			-- Call the routine with actual arguments `args'
		local
			formal_args: ANY
			actual_args: ANY
		do
			fill_argument_array (args)
			actual_args := argument_array.area
			formal_args := argument_types.area

			inspect
				return_type
			when T_boolean then
				imp_boolean_result := desc_call_dll16_boolean (function_handle, argument_count, $formal_args, $actual_args)
			when T_character then
				imp_character_result := desc_call_dll16_character (function_handle, argument_count, $formal_args, $actual_args)
			when T_double then
				imp_double_result := desc_call_dll16_double (function_handle, argument_count, $formal_args, $actual_args)
			when T_integer then
				imp_integer_result := desc_call_dll16_integer (function_handle, argument_count, $formal_args, $actual_args)
			when T_real then
				imp_real_result := desc_call_dll16_real (function_handle, argument_count, $formal_args, $actual_args)
			when T_pointer then
				imp_pointer_result := desc_make_np32 (desc_call_dll16_pointer (function_handle, argument_count, $formal_args, $actual_args))
			when T_reference then
				imp_reference_result := desc_call_dll16_reference (function_handle, argument_count, $formal_args, $actual_args)
			when T_short_integer then
				imp_integer_result := desc_call_dll16_short_integer (function_handle, argument_count, $formal_args, $actual_args)
			when T_string then
				imp_string_result := desc_rtms (desc_make_np32 (desc_call_dll16_string (function_handle, argument_count, $formal_args, $actual_args)))
			when T_no_type then
				desc_call_dll16_procedure (function_handle, argument_count, $formal_args, $actual_args)
			end
			routine_called := true
		end

feature -- Status report

	boolean_result: BOOLEAN is
			-- Value when the routine returns a boolean
		do
			Result := imp_boolean_result
		end

	character_result: CHARACTER is
			-- Value when the routine returns a character
		do
			Result := imp_character_result
		end

	double_result: DOUBLE is
			-- Value when the routine returns a double
		do
			Result := imp_double_result
		end

	integer_result: INTEGER is
			-- Value when the routine returns an integer
		do
			Result := imp_integer_result
		end

	pointer_result: POINTER is
			-- Value when the routine returns a pointer
		do
			Result := imp_pointer_result
		end

	real_result: REAL is
			-- Value when the routine returns a real
		do
			Result := imp_real_result
		end

	reference_result: ANY is
			-- Value when the routine returns a reference
		do
			Result := imp_reference_result
		end

	string_result: STRING is
			-- Value when the routine returns a string
		do
			Result := imp_string_result
		end

feature -- Access

	library_index: INTEGER
			-- Index of the routine in `shared_library'

	shared_library: DLL_16
			-- Associated library for the routine

feature {NONE} -- Implementation

	argument_array: ARRAY [CHARACTER]
			-- Values to be pushed on the C stack

	fill_argument_array (args: ARRAY [ANY]) is
			-- Fill area for stack pushing operation
		local
			i, j, nb: INTEGER
			area: ANY
			position: INTEGER
			arg_type, arg_size: INTEGER
			b_ref: BOOLEAN_REF
			c_ref: CHARACTER_REF
			d_ref: DOUBLE_REF
			i_ref: INTEGER_REF
			r_ref: REAL_REF
			p_ref: POINTER_REF
			b: BOOLEAN
			c: CHARACTER
			d: DOUBLE
			int: INTEGER
			r: REAL
			p: POINTER
			a: ANY
			s: STRING
			s1: ARRAY [INTEGER]
			s2: ARRAY [REAL]
			s3: ARRAY [DOUBLE]
			s4: ARRAY [BOOLEAN]
			s5: ARRAY [CHARACTER]
			s6: ARRAY [POINTER]
			s7: ARRAY [ANY]
			array_area: ANY
		do
			from
				i := args.lower
				j := argument_types.lower
				nb := argument_count
				area := argument_array.area
			until
				i > nb
			loop
				arg_type := argument_types @ j
				arg_size := desc_get_size (arg_type)
				inspect
					arg_type
				when T_array then
					s1 ?= args @ i
					if s1 = Void then
						s2 ?= args @ i
						if s2 = Void then
							s3 ?= args @ i
							if s3 = Void then
								s4 ?= args @ i
								if s4 = Void then
									s5 ?= args @ i
									if s5 = Void then
										s6 ?= args @ i
										if s6 = Void then
											s7 ?= args @ i
											array_area := s7.area
										else
											array_area := s6.area
										end
									else
										array_area := s5.area
									end
								else
									array_area := s4.area
								end
							else
								array_area := s3.area
							end
						else
							array_area := s2.area
						end
					else
						array_area := s1.area
					end
					p := desc_alloc_alias16 ($array_area)
					desc_copy_arg ($area, $p, position, arg_size)
				when T_boolean then
					b_ref ?= args @ i
					b := b_ref.item
					desc_copy_arg ($area, $b, position, arg_size)
				when T_character then
					c_ref ?= args @ i
					c := c_ref.item
					desc_copy_arg ($area, $c, position, arg_size)
				when T_double then
					d_ref ?= args @ i
					d := d_ref.item
					desc_copy_arg ($area, $d, position, arg_size)
				when T_integer, T_short_integer then
					i_ref ?= args @ i
					int := i_ref.item
					desc_copy_arg ($area, $int, position, arg_size)
				when T_real then
					r_ref ?= args @ i
					r := r_ref.item
					desc_copy_arg ($area, $r, position, arg_size)
				when T_pointer then
					p_ref ?= args @ i
					p := desc_alloc_alias16 (p_ref.item)
					desc_copy_arg ($area, $p, position, arg_size)
				when T_reference then
					a := args @ i
					p := desc_alloc_alias16 ($a)
					desc_copy_arg ($area, $p, position, arg_size)
				when T_string then
					s ?= args @ i
					a := s.to_c
					p := desc_alloc_alias16 ($a)
					desc_copy_arg ($area, $p, position, arg_size)
				end
				position := position + arg_size
				i := i + 1
				j := j + 1
			end
		end

	function_handle: POINTER
			-- Pointer to the external routine

	imp_boolean_result: BOOLEAN
			-- Value when the routine returns a boolean

	imp_character_result: CHARACTER
			-- Value when the routine returns a character

	imp_double_result: DOUBLE
			-- Value when the routine returns a double

	imp_integer_result: INTEGER
			-- Value when the routine returns an integer

	imp_pointer_result: POINTER
			-- Value when the routine returns a pointer

	imp_real_result: REAL
			-- Value when the routine returns a real

	imp_reference_result: ANY
			-- Value when the routine returns a reference

	imp_string_result: STRING
			-- Value when the routine returns a string

	make_argument_array is
			-- Allocates area for stack pushing operation
		local
			i, nb: INTEGER
			size: INTEGER
		do
				-- This needs to be done at creation time, since no
				-- allocation is allowed between the call to `call' and
				-- the real call (if the area of a STRING is passed as a
				-- C string, it has to be valid, i.e. not move).
			from
				i := argument_types.lower
				nb := argument_count
			until
				i > nb
			loop
				size := size + desc_get_size (argument_types @ i)
				i := i + 1
			end
			!! argument_array.make (1, size)
		end

feature {NONE} -- Externals

	desc_alloc_alias16 (np32: POINTER): POINTER is
			-- Obtains a 16-bit far pointer equivalent
			-- of a 32-bit near pointer `np32'
			--| Watcom specific
		external
			"C [macro <windows.h>]"
		alias
			"AllocAlias16"
		end

	desc_call_dll16_boolean (f_ptr: POINTER; arg_count: INTEGER; formal_args, actual_args: POINTER): BOOLEAN is
			-- Call to function returning a boolean
		external
			"C [dll16 %"desc.dll%"] (DWORD, DWORD, PTR, PTR): EIF_BOOLEAN"
		alias
			"2"
		end

	desc_call_dll16_character (f_ptr: POINTER; arg_count: INTEGER; formal_args, actual_args: POINTER): CHARACTER is
			-- Call to function returning a character
		external
			"C [dll16 %"desc.dll%"] (DWORD, DWORD, PTR, PTR): EIF_CHARACTER"
		alias
			"3"
		end

	desc_call_dll16_double (f_ptr: POINTER; arg_count: INTEGER; formal_args, actual_args: POINTER): DOUBLE is
			-- Call to function returning a double
		external
			"C [dll16 %"desc.dll%"] (DWORD, DWORD, PTR, PTR): EIF_DOUBLE"
		alias
			"4"
		end

	desc_call_dll16_integer (f_ptr: POINTER; arg_count: INTEGER; formal_args, actual_args: POINTER): INTEGER is
			-- Call to function returning an integer
		external
			"C [dll16 %"desc.dll%"] (DWORD, DWORD, PTR, PTR): EIF_INTEGER"
		alias
			"5"
		end

	desc_call_dll16_pointer (f_ptr: POINTER; arg_count: INTEGER; formal_args, actual_args: POINTER): POINTER is
			-- Call to function returning a pointer
		external
			"C [dll16 %"desc.dll%"] (DWORD, DWORD, PTR, PTR): EIF_POINTER"
		alias
			"6"
		end

	desc_call_dll16_real (f_ptr: POINTER; arg_count: INTEGER; formal_args, actual_args: POINTER): REAL is
			-- Call to function returning a real
		external
			"C [dll16 %"desc.dll%"] (DWORD, DWORD, PTR, PTR): EIF_REAL"
		alias
			"7"
		end

	desc_call_dll16_reference (f_ptr: POINTER; arg_count: INTEGER; formal_args, actual_args: POINTER): ANY is
			-- Call to function returning a reference
		external
			"C [dll16 %"desc.dll%"] (DWORD, DWORD, PTR, PTR): EIF_REFERENCE"
		alias
			"8"
		end

	desc_call_dll16_procedure (f_ptr: POINTER; arg_count: INTEGER; formal_args, actual_args: POINTER) is
			-- Call to procedure
		external
			"C [dll16 %"desc.dll%"] (DWORD, DWORD, PTR, PTR)"
		alias
			"9"
		end

	desc_call_dll16_short_integer (f_ptr: POINTER; arg_count: INTEGER; formal_args, actual_args: POINTER): INTEGER is
			-- Call to function returning a short integer
		external
			"C [dll16 %"desc.dll%"] (DWORD, DWORD, PTR, PTR): short int"
		alias
			"10"
		end

	desc_call_dll16_string (f_ptr: POINTER; arg_count: INTEGER; formal_args, actual_args: POINTER): POINTER is
			-- Call to function returning a string
		external
			"C [dll16 %"desc.dll%"] (DWORD, DWORD, PTR, PTR): EIF_POINTER"
		alias
			"11"
		end

	desc_copy_arg (target, source: POINTER; offset, size: INTEGER) is
			-- Copy `size' characters from `source'
			-- to `target' + `offset'
		external
			"C [macro %"eif_desc.h%"]"
		alias
			"DESC_BCOPY"
		end

	desc_get_function_index_pointer (m_p: POINTER; r_index: INTEGER): POINTER is
			-- Get function handle (by index)
		external
			"C [dll16 %"desc.dll%"] (DWORD, DWORD): EIF_POINTER"
		alias
			"13"
		end

	desc_get_function_pointer (m_p, f_p: POINTER): POINTER is
			-- Get function handle (by name)
		external
			"C [dll16 %"desc.dll%"] (DWORD, PTR): EIF_POINTER"
		alias
			"14"
		end

	desc_get_size (type: INTEGER): INTEGER is
			-- Get size of type `type'
		external
			"C [dll16 %"desc.dll%"] (DWORD): short int"
		alias
			"16"
		end

	desc_make_np32 (fp16: POINTER): POINTER is
			-- Makes a 32-bit near pointer from
			-- a 16-bit far pointer `fp16'
			--| Watcom specific
		external
			"C [macro %"eif_desc.h%"] (EIF_POINTER): EIF_POINTER"
		alias
			"DESC_MAKE_NP32"
		end

	desc_rtms (str: POINTER): STRING is
			-- Creates an Eiffel string from a
			-- C manifest string `str'
		external
			"C [macro %"eif_macros.h%"] (EIF_POINTER): EIF_REFERENCE"
		alias
			"RTMS"
		end

end -- class DLL_16_ROUTINE

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

