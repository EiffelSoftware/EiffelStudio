note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_SWITCH_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_switch_inst_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b1: BASIC_BLOCK
			b2: BASIC_BLOCK
			b3: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i: SWITCH_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b1.make (ctx)
			create b2.make_name (ctx, "default")
			create b3.make_name (ctx, "target")
			f.basic_block_list_push_back (b1)
			f.basic_block_list_push_back (b2)
			f.basic_block_list_push_back (b3)
			m.function_list_push_back (f)
			create i.make (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 8), b2)
			i.add_case (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 9), b3)
			b1.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_sub_operator_1", s_result ~ test_sub_operator_1_expected)
		end

	test_sub_operator_1_expected: STRING_8 =
"[
; ModuleID = 'test'

define i32 @main() {
  switch i32 8, label %default [
    i32 9, label %target
  ]

default:                                          ; preds = %0

target:                                           ; preds = %0
}

]"

end


