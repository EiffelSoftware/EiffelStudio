note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_CONSTANT_POINTER_NULL

inherit
	EQA_TEST_SET

feature -- Test routines

	test_constant_pointer_null_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			linkage_types: LINKAGE_TYPES
			t: POINTER_TYPE
			i: CONSTANT_POINTER_NULL
			g: GLOBAL_VARIABLE
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create t.make (create {INTEGER_TYPE}.make (ctx, 32))
			create i.make (t)
			create g.make_initializer (t, True, linkage_types.external_linkage, i)
			m.global_list_push_back (g)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_constant_pointer_null_1", s_result ~ test_constant_pointer_null_1_expected)
		end

	test_constant_pointer_null_1_expected: STRING_8 =
"[
; ModuleID = 'test'

@0 = constant i32* null

]"

end


