note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_CONSTANT_STRUCT

inherit
	EQA_TEST_SET

feature -- Test routines

	test_constant_struct_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			linkage_types: LINKAGE_TYPES
			values: CONSTANT_STLVECTOR
			types: TYPE_VECTOR
			t: STRUCT_TYPE
			st: CONSTANT_STRUCT
			g: GLOBAL_VARIABLE
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create values.make
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 8))
			values.push_back (create {CONSTANT_FP}.make (create {TYPE_L}.make_double (ctx), 9.8))
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 1), 1))
			create types.make
			types.push_back (create {INTEGER_TYPE}.make (ctx, 32))
			types.push_back (create {TYPE_L}.make_double (ctx))
			types.push_back (create {INTEGER_TYPE}.make (ctx, 1))
			create t.make (ctx, types)
			create st.make (ctx, values)
			create g.make_initializer (t, True, linkage_types.external_linkage, st)
			m.global_list_push_back (g)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_constant_struct_1", s_result ~ test_constant_struct_1_expected)
		end

	test_constant_struct_1_expected: STRING_8 =
"[
; ModuleID = 'test'

@0 = constant { i32, double, i1 } { i32 8, double 9.800000e+00, i1 true }

]"

end


