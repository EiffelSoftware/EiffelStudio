note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_GET_ELEMENT_PTR_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_get_element_ptr_inst_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i: GET_ELEMENT_PTR_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
			array: CONSTANT_ARRAY
			values: CONSTANT_STLVECTOR
			index: VALUE_VECTOR
			global: GLOBAL_VARIABLE
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b.make (ctx)
			f.basic_block_list_push_back (b)
			m.function_list_push_back (f)
			create values.make
			values.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 8))
			create array.make (create {ARRAY_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 32), 1), values)
			create global.make_initializer (create {ARRAY_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 32), 1), True, linkage_types.external_linkage, array)
			m.global_list_push_back (global)
			create index.make
			index.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 0))
			create i.make_index_list (global, index)
			b.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_fdiv_operator_1", s_result ~ test_fdiv_operator_1_expected)
		end

	test_fdiv_operator_1_expected: STRING_8 =
"[
; ModuleID = 'test'

@0 = constant [1 x i32] [i32 8]

define i32 @main() {
  %1 = getelementptr [1 x i32]* @0, i32 0
}

]"

end


