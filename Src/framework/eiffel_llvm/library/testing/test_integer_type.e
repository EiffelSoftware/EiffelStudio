note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_INTEGER_TYPE

inherit
	EQA_TEST_SET

feature -- Test routines

	test_isa
			-- New test routine
		local
			ctx: LLVM_CONTEXT
			t1: TYPE_L
			t2: TYPE_L
		do
			create ctx
			create {INTEGER_TYPE}t1.make (ctx, 32)
			create {POINTER_TYPE}t2.make (create {INTEGER_TYPE}.make (ctx, 32))
			assert ("test_isa_1", t1.classof_integer_type)
			assert ("test_isa_2", not t2.classof_integer_type)
		end

	test_get_bit_width
		local
			ctx: LLVM_CONTEXT
			t: INTEGER_TYPE
		do
			create ctx
			create t.make (ctx, 32)
			assert ("test_get_bit_width_1", t.get_bit_width = 32)
		end

end


