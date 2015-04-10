note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_LOAD_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_load_inst_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			array: CONSTANT_ARRAY
			values: CONSTANT_STLVECTOR
			g: GLOBAL_VARIABLE
			index: VALUE_VECTOR
			i1: GET_ELEMENT_PTR_INST
			i2: LOAD_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
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
			create g.make_initializer (create {ARRAY_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 32), 1), True, linkage_types.external_linkage, array)
			m.global_list_push_back (g)
			create index.make
			index.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 0))
			create i1.make_index_list (g, index)
			create i2.make (i1)
			b.inst_list_push_back (i1)
			b.inst_list_push_back (i2)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_int_to_ptr_inst_1", s_result ~ test_int_to_ptr_inst_1_expected)
		end

	test_int_to_ptr_inst_1_expected: STRING_8 =
"[
; ModuleID = 'test'

@0 = constant [1 x i32] [i32 8]

define i32 @main() {
  %1 = getelementptr [1 x i32]* @0, i32 0
  %2 = load [1 x i32]* %1
}

]"


end


