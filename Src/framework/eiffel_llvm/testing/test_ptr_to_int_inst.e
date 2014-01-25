note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_PTR_TO_INT_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_ptr_to_int_inst_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i: PTR_TO_INT_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
			g: GLOBAL_VARIABLE
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b.make (ctx)
			f.basic_block_list_push_back (b)
			m.function_list_push_back (f)
			create g.make_initializer (create {INTEGER_TYPE}.make (ctx, 32), True, linkage_types.external_linkage, create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 8))
			m.global_list_push_back (g)
			create i.make (g, create {INTEGER_TYPE}.make (ctx, 32))
			b.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_ptr_to_int_inst_1", s_result ~ test_ptr_to_int_inst_1_expected)
		end

	test_ptr_to_int_inst_1_expected: STRING_8 =
"[
; ModuleID = 'test'

@0 = constant i32 8

define i32 @main() {
  %1 = ptrtoint i32* @0 to i32
}

]"

end


