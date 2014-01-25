note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EXTRACT_ELEMENT_INST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_extract_element_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			i: EXTRACT_ELEMENT_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
			const: CONSTANT_STLVECTOR
			vec: CONSTANT_VECTOR
			idx: CONSTANT_INT
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b.make (ctx)
			f.basic_block_list_push_back (b)
			m.function_list_push_back (f)
			create const.make
			const.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 300))
			create vec.make (create {VECTOR_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 32), 1), const)
			create idx.make (create {INTEGER_TYPE}.make (ctx, 32), 0)
			create i.make (vec, idx)
			b.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_extract_element_1", s_result ~ test_extract_element_1_expected)
		end

	test_extract_element_1_expected: STRING_8 =
"[
; ModuleID = 'test'

define i32 @main() {
  %1 = extractelement <1 x i32> <i32 300>, i32 0
}

]"
end


