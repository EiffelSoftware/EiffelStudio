note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EXTRACT_VALUE_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_extract_value_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i: EXTRACT_VALUE_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
			const: CONSTANT_STLVECTOR
			array: CONSTANT_ARRAY
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b.make (ctx)
			f.basic_block_list_push_back (b)
			m.function_list_push_back (f)
			create const.make
			const.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 300))
			create array.make (create {ARRAY_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 32), 1), const)
			create i.make (array, 0)
			b.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_extract_value_1", s_result ~ test_extract_element_1_expected)
		end

	test_extract_element_1_expected: STRING_8 =
"[
; ModuleID = 'test'

define i32 @main() {
  %1 = extractvalue [1 x i32] [i32 300], 0
}

]"

end


