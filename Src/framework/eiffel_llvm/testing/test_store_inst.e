note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_STORE_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_store_inst_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i1: INT_TO_PTR_INST
			i2: STORE_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b.make (ctx)
			f.basic_block_list_push_back (b)
			m.function_list_push_back (f)
			create i1.make (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 0x1000), create {POINTER_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 32)))
			create i2.make (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 10), i1)
			b.inst_list_push_back (i1)
			b.inst_list_push_back (i2)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_int_to_ptr_inst_1", s_result ~ test_int_to_ptr_inst_1_expected)
		end

	test_int_to_ptr_inst_1_expected: STRING_8 =
"[
; ModuleID = 'test'

define i32 @main() {
  %1 = inttoptr i32 4096 to i32*
  store i32 10, i32* %1
}

]"

end


