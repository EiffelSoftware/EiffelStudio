note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_ALLOCA_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_alloca_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			linkage_types: LINKAGE_TYPES
			a: ALLOCA_INST
			b: BASIC_BLOCK
			s: RAW_STRING_OSTREAM
			r: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {TYPE_L}.make_void (ctx)), linkage_types.external_linkage, "test")
			create a.make_type (create {INTEGER_TYPE}.make (ctx, 32))
			create b.make (ctx)
			create s.make
			m.function_list_push_back (f)
			f.basic_block_list_push_back (b)
			b.inst_list_push_back (a)
			m.print (s)
			r := s.string
			assert ("test_alloca_1", r ~ test_alloca_1_expected)
		end

	test_alloca_1_expected: STRING_8 =
"[
; ModuleID = 'test'

define void @test() {
  %1 = alloca i32
}

]"

end


