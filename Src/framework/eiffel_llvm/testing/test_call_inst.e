note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_CALL_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_call_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f1: FUNCTION_L
			f2: FUNCTION_L
			b1: BASIC_BLOCK
			b2: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i: CALL_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
			parameters:TYPE_VECTOR
			arguments: VALUE_VECTOR
		do
			create ctx
			create m.make ("test", ctx)
			create f1.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create parameters.make
			parameters.push_back (create {INTEGER_TYPE}.make (ctx, 32))
			create f2.make_name (create {FUNCTION_TYPE}.make_with_parameters (create {INTEGER_TYPE}.make (ctx, 32), parameters), linkage_types.external_linkage, "thing")
			create b1.make (ctx)
			create b2.make (ctx)
			f1.basic_block_list_push_back (b1)
			f2.basic_block_list_push_back (b2)
			m.function_list_push_back (f1)
			m.function_list_push_back (f2)
			create arguments.make
			arguments.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 777))
			create i.make_arguments (f2, arguments)
			b1.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_call_1", s_result ~ test_call_1_expected)
		end

	test_call_1_expected: STRING_8 =
"[
; ModuleID = 'test'

define i32 @main() {
  %1 = call i32 @thing(i32 777)
}

define i32 @thing(i32) {
}

]"

end


