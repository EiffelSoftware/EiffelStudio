note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_STRUCT_TYPE

inherit
	EQA_TEST_SET

feature -- Test routines

	test_struct_type_1
		local
			ctx: LLVM_CONTEXT
			s: STRUCT_TYPE
			t: TYPE_VECTOR
			type_id: TYPE_ID
		do
			create ctx
			create t.make
			t.push_back (create {INTEGER_TYPE}.make (ctx, 32))
			t.push_back (create {TYPE_L}.make_double (ctx))
			t.push_back (create {INTEGER_TYPE}.make (ctx, 1))
			create s.make (ctx, t)
			assert ("test_struct_type_1_1", s.index_valid (0))
			assert ("test_struct_type_1_2", s.get_type_at_index (0).get_type_id = type_id.integer_ty_id)
			assert ("test_struct_type_1_3", s.index_valid (1))
			assert ("test_struct_type_1_4", s.get_type_at_index (1).get_type_id = type_id.double_ty_id)
			assert ("test_struct_type_1_5", s.index_valid (2))
			assert ("test_struct_type_1_6", s.get_type_at_index (2).get_type_id = type_id.integer_ty_id)
		end

end


