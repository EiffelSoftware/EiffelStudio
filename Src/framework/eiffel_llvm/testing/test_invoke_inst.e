note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_INVOKE_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_invoke_inst_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f1: FUNCTION_L
			f2: FUNCTION_L
			b1: BASIC_BLOCK
			b2: BASIC_BLOCK
			b3: BASIC_BLOCK
			b4: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i: INVOKE_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create f1.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create f2.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "target")
			create b1.make (ctx)
			create b2.make (ctx)
			create b3.make_name (ctx, "normal")
			create b4.make_name (ctx, "exception")
			f1.basic_block_list_push_back (b1)
			f1.basic_block_list_push_back (b3)
			f1.basic_block_list_push_back (b4)
			f2.basic_block_list_push_back (b2)
			m.function_list_push_back (f1)
			m.function_list_push_back (f2)
			create i.make (f2, b3, b4)
			b1.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_invoke_inst_1", s_result ~ test_invoke_inst_1_expected)
		end

	test_invoke_inst_1_expected: STRING_8 =
"[
; ModuleID = 'test'

define i32 @main() {
  %1 = invoke i32 @target()
          to label %normal unwind label %exception

normal:                                           ; preds = %0

exception:                                        ; preds = %0
}

define i32 @target() {
}

]"

end


