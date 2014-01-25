note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_FCMP_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_fcmp_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i: FCMP_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
			predicates: PREDICATE_L
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b.make (ctx)
			f.basic_block_list_push_back (b)
			m.function_list_push_back (f)
			create i.make (predicates.fcmp_oeq, create {CONSTANT_FP}.make (create {TYPE_L}.make_double (ctx), 4.7), create {CONSTANT_FP}.make (create {TYPE_L}.make_double (ctx), 8.7))
			b.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_fcmp_1", s_result ~ test_fcmp_1_expected)
		end

	test_fcmp_1_expected: STRING_8 =
"[
; ModuleID = 'test'

define i32 @main() {
  %1 = fcmp oeq double 4.700000e+00, 8.700000e+00
}

]"

end


