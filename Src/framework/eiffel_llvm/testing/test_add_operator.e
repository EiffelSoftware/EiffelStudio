note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_ADD_OPERATOR

inherit
	EQA_TEST_SET

feature -- Test routines

	test_memory
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i: ADD_OPERATOR
			mem: ALLOCA_INST
			idx1, idx2: VALUE_VECTOR
			g1: GET_ELEMENT_PTR_INST
			g2: GET_ELEMENT_PTR_INST
			l1: LOAD_INST
			l2: LOAD_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b.make (ctx)
			f.basic_block_list_push_back (b)
			m.function_list_push_back (f)
			create mem.make_type (create {INTEGER_TYPE}.make (ctx, 32))

			create idx1.make
			create idx2.make
			idx1.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 0))
			idx2.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 0))


			create g1.make_index_list (mem, idx1)
			create g2.make_index_list (mem, idx2)
			create l1.make (g1)
			create l2.make (g2)
			b.inst_list_push_back (mem)
			b.inst_list_push_back (g1)
			b.inst_list_push_back (g2)
			b.inst_list_push_back (l1)
			b.inst_list_push_back (l2)
			create i.make (l1, l2)
			b.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_memory_correct", s_result ~ test_memory_expected)
		end

	test_memory_expected: STRING_8 =
"[
; ModuleID = 'test'

define i32 @main() {
  %1 = alloca i32
  %2 = getelementptr i32* %1, i32 0
  %3 = getelementptr i32* %1, i32 0
  %4 = load i32* %2
  %5 = load i32* %3
  %6 = add i32 %4, %5
}

]"

	test_constants
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i: ADD_OPERATOR
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b.make (ctx)
			f.basic_block_list_push_back (b)
			m.function_list_push_back (f)
			create i.make (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 100), create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 200))
			b.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_constants_correct", s_result ~ test_constants_expected)
		end

	test_constants_expected: STRING_8 =
"[
; ModuleID = 'test'

define i32 @main() {
  %1 = add i32 100, 200
}

]"

end


