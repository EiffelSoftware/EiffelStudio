note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_TYPE

inherit
	EQA_TEST_SET

feature -- Test routines

	test_get_type_id
		local
			ctx: LLVM_CONTEXT
			t: INTEGER_TYPE
			type_id: TYPE_ID
		do
			create ctx
			create t.make (ctx, 32)
			assert ("get_type_id", t.get_type_id = type_id.integer_ty_id)
		end

	test_description_1
		local
			ctx: LLVM_CONTEXT
			t: TYPE_L
			s: CPP_STRING
			r: STRING_8
		do
			create ctx
			create t.make_float (ctx)
			s := t.get_description
			r := s.string
			assert ("test_description_1", r ~ "float")
		end

--	test_type_1
--		local
--			ctx: LLVM_CONTEXT
--			t: PA_TYPE_HOLDER
--		do
--			create ctx
--			create t.make (create {OPAQUE_TYPE}.make (ctx))
--			assert ("test_type_1_1", t.get.is_abstract)
--			t.get.cast_to_opaque_type.refine_abstract_type_to (create {INTEGER_TYPE}.make (ctx, 32))
--			assert ("test_type_1_2", not t.get.is_abstract)
--		end

	test_type_2
		local
			ctx: LLVM_CONTEXT
			t: TYPE_L
		do
			create ctx
			create {POINTER_TYPE}t.make (create {INTEGER_TYPE}.make (ctx, 8))
			assert ("test_type_2_1", t.is_pointer_ty)
			assert ("test_type_2_2", t.get_type_id = {TYPE_ID}.pointer_ty_id)
		end

end


