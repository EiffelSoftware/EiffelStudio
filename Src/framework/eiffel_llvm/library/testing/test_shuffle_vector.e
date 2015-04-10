note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_SHUFFLE_VECTOR

inherit
	EQA_TEST_SET

feature -- Test routines

	test_shuffle_vector_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			f: FUNCTION_L
			b: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			v1: CONSTANT_VECTOR
			v2: CONSTANT_VECTOR
			v3: CONSTANT_VECTOR
			val1: CONSTANT_STLVECTOR
			val2: CONSTANT_STLVECTOR
			val3: CONSTANT_STLVECTOR
			i: SHUFFLE_VECTOR_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create f.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create b.make (ctx)
			f.basic_block_list_push_back (b)
			m.function_list_push_back (f)
			create val1.make
			val1.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 4))
			val1.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 8))
			create val2.make
			val2.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 12))
			val2.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 16))
			create val3.make
			val3.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 2))
			val3.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 0))
			val3.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 1))
			val3.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 3))
			create v1.make (create {VECTOR_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 32), 2), val1)
			create v2.make (create {VECTOR_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 32), 2), val2)
			create v3.make (create {VECTOR_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 32), 4), val3)
			create i.make (v1, v2, v3)
			b.inst_list_push_back (i)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_mul_operator_1", s_result ~ test_mul_operator_1_expected)
		end

	test_mul_operator_1_expected: STRING_8 =
"[
; ModuleID = 'test'

define i32 @main() {
  %1 = shufflevector <2 x i32> <i32 4, i32 8>, <2 x i32> <i32 12, i32 16>, <4 x i32> <i32 2, i32 0, i32 1, i32 3>
}

]"

end


