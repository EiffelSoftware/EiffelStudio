note
	description: "Various constants for C code generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	C_CONST

feature -- Various names used for registers during code generation.

	current_name: STRING = "Current"
	result_name: STRING = "Result"
	argument_name: STRING = "arg"
	workbench_argument_name: STRING = "argx"
	local_name: STRING = "loc"
	void_name: STRING = "void"
	dtype_name: STRING = "dtype"
	dftype_name: STRING = "dftype"
	inlined_dtype_name: STRING = "inlined_dtype"
	inlined_dftype_name: STRING = "inlined_dftype"
	keys_name: STRING = "keys"
	where_name: STRING = "where"

feature -- Skeleton

	starting_c_code: STRING = "%N%N#ifdef __cplusplus%Nextern %"C%" {%N#endif%N"
	ending_c_code: STRING = "%N%N#ifdef __cplusplus%N}%N#endif%N"
	comma_space: STRING = ", "

feature -- Function definitions

	static: STRING = "static"
	stdcall: STRING = " __stdcall"
	rtil: STRING = "RT_IL"
	extern: STRING = "extern"

	function_cast: STRING = "FUNCTION_CAST"
	function_cast_type: STRING = "FUNCTION_CAST_TYPE"

feature -- Macros

	rtlr: STRING = "RTLR"
	rtmb: STRING = "RTMB"
	gtcx: STRING = "GTCX"
	rti64c: STRING = "RTI64C"
	rtu64c: STRING = "RTU64C"
	rtms_ex_h: STRING = "RTMS_EX_H"
	dtype: STRING = "Dtype"
	dftype: STRING = "Dftype"

feature -- C constants

	opt_all: STRING = "OPT_ALL"
	opt_unnamed: STRING = "OPT_UNNAMED"

	ex_pre: STRING = "EX_PRE"
	ex_post: STRING = "EX_POST"
	ex_check: STRING = "EX_CHECK"
	ex_linv: STRING = "EX_LINV"
	ex_var: STRING = "EX_VAR"
	ex_cinv: STRING = "EX_CINV"
	ex_invc: STRING = "EX_INVC"

feature -- Typing

	eif_reference: STRING = "EIF_REFERENCE"
	eif_typed_value: STRING = "EIF_TYPED_VALUE"
	eif_type_index: STRING = "EIF_TYPE_INDEX"
	eif_boolean: STRING = "EIF_BOOLEAN"
	eif_character_8: STRING = "EIF_CHARACTER_8"
	eif_character_32: STRING = "EIF_CHARACTER_32"
	eif_natural_8: STRING = "EIF_NATURAL_8"
	eif_natural_16: STRING = "EIF_NATURAL_16"
	eif_natural_32: STRING = "EIF_NATURAL_32"
	eif_natural_64: STRING = "EIF_NATURAL_64"
	eif_integer_8: STRING = "EIF_INTEGER_8"
	eif_integer_16: STRING = "EIF_INTEGER_16"
	eif_integer_32: STRING = "EIF_INTEGER_32"
	eif_integer_64: STRING = "EIF_INTEGER_64"
	eif_real_32: STRING = "EIF_REAL_32"
	eif_real_64: STRING = "EIF_REAL_64"
	eif_pointer: STRING = "EIF_POINTER"

	eif_true: STRING = "EIF_TRUE"
	eif_false: STRING = "EIF_FALSE"

feature -- C language

	char: STRING = "char"
	else_conditional: STRING = "else"
	if_conditional: STRING = "if"
	sizeof: STRING = "sizeof"
	return: STRING = "return"
	null: STRING = "NULL"

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
