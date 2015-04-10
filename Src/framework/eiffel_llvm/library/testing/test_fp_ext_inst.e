note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_FP_EXT_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_fpext_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i: FP_EXT_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b.make (ctx)
			f.basic_block_list_push_back (b)
			m.function_list_push_back (f)
			create i.make (create {CONSTANT_FP}.make (create {TYPE_L}.make_float (ctx), 4.7), create {TYPE_L}.make_double (ctx))
			b.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_fp_ext_inst_1", s_result ~ test_fp_ext_inst_1_expected)
		end

	test_fp_ext_inst_1_expected: STRING_8 =
"[
; ModuleID = 'test'

define i32 @main() {
  %1 = fpext float 0x4012CCCCC0000000 to double
}

]"

end


