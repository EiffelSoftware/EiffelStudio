note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_CONSTANT_ARRAY

inherit
	EQA_TEST_SET

feature -- Test routines

	test_constant_array_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			linkage_types: LINKAGE_TYPES
			c: CONSTANT_STLVECTOR
			i: CONSTANT_ARRAY
			v: GLOBAL_VARIABLE
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create c.make
			c.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 100))
			c.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 200))
			c.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 300))
			create i.make (create {ARRAY_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 32), 3), c)
			create v.make_initializer (i.get_raw_type, False, linkage_types.external_linkage, i)
			m.global_list_push_back (v)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_constant_array_1", s_result ~ test_constant_array_1_expected)
		end

	test_constant_array_1_expected: STRING_8 =
"[
; ModuleID = 'test'

@0 = global [3 x i32] [i32 100, i32 200, i32 300]

]"

end


