note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_FUNCTION_TYPE

inherit
	EQA_TEST_SET

feature -- Test routines

	test_function_type_1
		local
			ctx: LLVM_CONTEXT
			t: FUNCTION_TYPE
		do
			create ctx
			create t.make_without_parameters (create {TYPE_L}.make_void (ctx))
			assert ("test_function_type_1", t.get_num_params = 0)
		end

	test_function_type_2
		local
			ctx: LLVM_CONTEXT
			t: FUNCTION_TYPE
			v: TYPE_VECTOR
		do
			create ctx
			create v.make
			v.push_back (create {INTEGER_TYPE}.make (ctx, 8))
			create t.make_with_parameters (create {TYPE_L}.make_void (ctx), v)
			assert ("test_function_type_2", t.get_num_params = 1)
		end

end


