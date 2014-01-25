note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_BRANCH_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_branch_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b1: BASIC_BLOCK
			b2: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i: BRANCH_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b1.make (ctx)
			create b2.make_name (ctx, "target")
			f.basic_block_list_push_back (b1)
			f.basic_block_list_push_back (b2)
			m.function_list_push_back (f)
			create i.make (b2)
			b1.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_branch_1", s_result ~ test_branch_1_expected)
		end

	test_branch_1_expected: STRING_8 =
"[
; ModuleID = 'test'

define i32 @main() {
  br label %target

target:                                           ; preds = %0
}

]"

	test_branch_2
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b1: BASIC_BLOCK
			b2: BASIC_BLOCK
			b3: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			a: ALLOCA_INST
			e: LOAD_INST
			e2: LOAD_INST
			s1: STORE_INST
			s2: STORE_INST
			g1: GLOBAL_VARIABLE
			g2: GLOBAL_VARIABLE
			l: LOAD_INST
			i: BRANCH_INST
			i2: BRANCH_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b1.make (ctx)
			create b2.make_name (ctx, "lhs_false")
			create b3.make_name (ctx, "prolog")
			f.basic_block_list_push_back (b1)
			f.basic_block_list_push_back (b2)
			f.basic_block_list_push_back (b3)
			m.function_list_push_back (f)
			create a.make_type (create {INTEGER_TYPE}.make (ctx, 1))
			b1.inst_list_push_back (a)
			create g1.make (create {INTEGER_TYPE}.make (ctx, 1), False, linkage_types.external_linkage)
			m.global_list_push_back (g1)
			create e.make (g1)
			b1.inst_list_push_back (e)
			create s1.make (e, a)
			b1.inst_list_push_back (s1)
			create i.make_conditional (b3, b2, e)
			b1.inst_list_push_back (i)
			create g2.make (create {INTEGER_TYPE}.make (ctx, 1), False, linkage_types.external_linkage)
			m.global_list_push_back (g2)
			create e2.make (g2)
			b2.inst_list_push_back (e2)
			create s2.make (e2, a)
			b2.inst_list_push_back (s2)
			create i2.make (b3)
			b2.inst_list_push_back (i2)
			create l.make (a)
			b3.inst_list_push_back (l)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_branch_2", s_result ~ test_branch_2_expected)
		end

	test_branch_2_expected: STRING_8 =
"[
; ModuleID = 'test'

@0 = external global i1
@1 = external global i1

define i32 @main() {
  %1 = alloca i1
  %2 = load i1* @0
  store i1 %2, i1* %1
  br i1 %2, label %prolog, label %lhs_false

lhs_false:                                        ; preds = %0
  %3 = load i1* @1
  store i1 %3, i1* %1
  br label %prolog

prolog:                                           ; preds = %lhs_false, %0
  %4 = load i1* %1
}

]"

end


