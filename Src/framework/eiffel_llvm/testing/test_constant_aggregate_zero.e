note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_CONSTANT_AGGREGATE_ZERO

inherit
	EQA_TEST_SET

feature -- Test routines

	test_constant_aggregate_zero_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			linkage_types: LINKAGE_TYPES
			t: TYPE_VECTOR
			st: STRUCT_TYPE
			i: CONSTANT_AGGREGATE_ZERO
			v: GLOBAL_VARIABLE
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create t.make
			t.push_back (create {INTEGER_TYPE}.make (ctx, 64))
			t.push_back (create {INTEGER_TYPE}.make (ctx, 1))
			t.push_back (create {TYPE_L}.make_double (ctx))
			create st.make (ctx, t)
			create i.make (st)
			create v.make_initializer (st, False, linkage_types.external_linkage, i)
			m.global_list_push_back (v)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_constant_aggregate_zero_1", s_result ~ test_constant_aggregate_zero_1_expected)
		end

	test_constant_aggregate_zero_1_expected: STRING_8 =
"[
; ModuleID = 'test'

@0 = global { i64, i1, double } zeroinitializer

]"

end


