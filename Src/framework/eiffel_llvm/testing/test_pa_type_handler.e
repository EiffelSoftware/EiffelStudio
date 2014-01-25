note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_PA_TYPE_HANDLER

--inherit
--	EQA_TEST_SET

--feature -- Test routines

--	test_pa_type_handler_1
--		local
--			ctx: LLVM_CONTEXT
--			o1: OPAQUE_TYPE
--			o2: OPAQUE_TYPE
--			t1: PA_TYPE_HOLDER
--			t2: PA_TYPE_HOLDER
--		do
--			create ctx
--			create o1.make (ctx)
--			create o2.make (ctx)
--			create t1.make (o1)
--			create t2.make (o2)
--			assert ("test_pa_type_handler_1_1", t1.get.item /= t2.get.item)
--			o1.refine_abstract_type_to (create {INTEGER_TYPE}.make (ctx, 32))
--			assert ("test_pa_type_handler_1_2", t1.get.item /= t2.get.item)
--			o2.refine_abstract_type_to (create {INTEGER_TYPE}.make (ctx, 32))
--			assert ("test_pa_type_handler_1_3", t1.get.item = t2.get.item)
--		end

end


