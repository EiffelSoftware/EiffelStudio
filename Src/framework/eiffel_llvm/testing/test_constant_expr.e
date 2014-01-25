note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_CONSTANT_EXPR

inherit
	EQA_TEST_SET

feature -- Test routines

	test_constant_expr_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			linkage_types: LINKAGE_TYPES
			c: CONSTANT_STLVECTOR
			indicies: SPECIAL [POINTER]
			e: CONSTANT_EXPR
			i: CONSTANT_ARRAY
			v: GLOBAL_VARIABLE
			v2: GLOBAL_VARIABLE
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
			create indicies.make_empty (2)
			indicies.extend ((create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 0)).item)
			indicies.extend ((create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 0)).item)
			create e.get_get_element_ptr_single (v, indicies)
			create v2.make_initializer (e.get_raw_type, True, linkage_types.external_linkage, e)
			m.global_list_push_back (v2)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_constant_expr_1", s_result ~ test_constant_expr_1_expected)
		end

	test_constant_expr_1_expected: STRING_8 =
"[
; ModuleID = 'test'

@0 = global [3 x i32] [i32 100, i32 200, i32 300]
@1 = constant i32* getelementptr inbounds ([3 x i32]* @0, i32 0, i32 0)

]"

end


