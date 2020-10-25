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
	tmp_name: STRING = "t"
	void_name: STRING = "void"
	dtype_name: STRING = "dtype"
	dftype_name: STRING = "dftype"
	inlined_dtype_name: STRING = "inlined_dtype"
	inlined_dftype_name: STRING = "inlined_dftype"
	keys_name: STRING = "keys"
	where_name: STRING = "where"
	eif_optimize_return: STRING = "eif_optimize_return"
	nstcall: STRING = "nstcall"
	data: STRING = "data"

	error: STRING = "ERROR"

	define: STRING = "#define"
	undef: STRING = "#undef"
	undef_result: STRING = "#undef Result"
	undef_arg: STRING = "#undef arg"
	define_arg: STRING = "#define arg"
	eif_volatile: STRING = "EIF_VOLATILE"
	undef_eif_volatile: STRING = "#undef EIF_VOLATILE"
	define_eif_volatile: STRING = "#define EIF_VOLATILE"

	body_postfix: STRING = "_body"
	notreached_comment: STRING = "/* NOTREACHED */"
	space_equals_space: STRING = " = "
	space_or_space: STRING = " || "

	eif_reference__earg: STRING = "EIF_REFERENCE earg"
	eif_boolean__uarg: STRING = "EIF_BOOLEAN uarg"

	sarg: STRING = "sarg"
	earg: STRING = "earg"
	uarg: STRING = "uarg"
	arg: STRING = "arg"
	sloc: STRING = "sloc"
	ptr: STRING = "ptr"
	fnptr: STRING = "fnptr"

	saved_except: STRING = "saved_except"

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

feature -- Run-time functions

	eif_attached_type: STRING = "eif_attached_type"
	eif_non_attached_type: STRING = "eif_non_attached_type"

feature -- Macros

	rtlr: STRING = "RTLR"
	gtcx: STRING = "GTCX"
	rti64c: STRING = "RTI64C"
	rtu64c: STRING = "RTU64C"
	rtms_ex_h: STRING = "RTMS_EX_H"
	rtmis8_ex_h: STRING = "RTMIS8_EX_H"
	rtms32_ex_h: STRING = "RTMS32_EX_H"
	rtmis32_ex_h: STRING = "RTMIS32_EX_H"
	dtype: STRING = "Dtype"
	dftype: STRING = "Dftype"
	rtcv_open: STRING = "RTCV("
	rtcw_open: STRING = "RTCW("
	rtcw_arg: STRING = "RTCW(arg"
	rtcw_earg: STRING = "RTCW(earg"
	rtcw_loc: STRING = "RTCW(loc"
	open_rtna_open: STRING = "(RTNA("
	rtnr_close: STRING = "RTNR)"
	rtar_open: STRING = "RTAR("
	rtal: STRING = "RTAL"
	rtgc: STRING = "RTGC"
	rtrs: STRING = "RTRS"
	rteaa: STRING = "RTEAA"
	rtdbgeaa: STRING = "RTDBGEAA"
	rtev: STRING = "RTEV"
	rtdbgle: STRING = "RTDBGLE"
	rtee: STRING = "RTEE"
	rtle: STRING = "RTLE"
	rtme: STRING = "RTME"
	rtrr: STRING = "RTRR"
	rtpr: STRING = "RTPR"
	rtmd: STRING = "RTMD"
	rtxt: STRING = "RTXT"
	rtxp: STRING = "RTXP"
	rtex: STRING = "RTEX"
	rted: STRING = "RTED"
	rtlt: STRING = "RTLT"
	rtlp: STRING = "RTLP"

	rtbu: STRING = "RTBU"

	rtiv: STRING = "RTIV"
	rtvi: STRING = "RTVI"

	rtsa: STRING = "RTSA"
	rtsc: STRING = "RTSC"

	rtjb: STRING = "RTJB"
	rtck: STRING = "RTCK"
	rtcf: STRING = "RTCF"
	rtct: STRING = "RTCT"
	rtct0: STRING = "RTCT0"
	rtit: STRING = "RTIT"

	rtsn: STRING = "RTSN"
	rtda: STRING = "RTDA"
	rtdt: STRING = "RTDT"
	rtxd: STRING = "RTXD"
	rtld: STRING = "RTLD"
	rtlxd: STRING = "RTLXD"

	rtti: STRING = "RTTI"
	rtpi: STRING = "RTPI"
	rte_t: STRING = "RTE_T"
	rte_e: STRING = "RTE_E"
	rtlxe: STRING = "RTLXE"
	rtxs: STRING = "RTXS"
	rte_ee: STRING = "RTE_EE"

	rtwf: STRING = "RTWF"
	rtwpf: STRING = "RTWPF"
	rtvf: STRING = "RTVF"
	rtvpf: STRING = "RTVPF"
	rtwc: STRING = "RTWC"
	rtwpc: STRING = "RTWPC"
	rtcc: STRING = "RTCC"

	rteainv: STRING = "RTEAINV"

	rtlnrw: STRING = "RTLNRW"
	rtlnrf: STRING = "RTLNRF"

	rteok: STRING = "RTEOK"
	rtxe: STRING = "RTXE"

	rtrcl: STRING = "RTRCL"
	rtrb: STRING = "RTRB"
	rtre: STRING = "RTRE"
	rtrv: STRING = "RTRV"

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

	eif_object: STRING = "EIF_OBJECT"
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
	char_star: STRING = "char *"
	int: STRING = "int"
	else_conditional: STRING = "else"
	if_conditional: STRING = "if"
	where: STRING = "where"
	sizeof: STRING = "sizeof"
	return: STRING = "return"
	null: STRING = "NULL"
	volatile: STRING = "volatile"

	ignore_value: STRING = "(void) "

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
