note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_LINKER

inherit
	EQA_TEST_SET

feature -- Test routines

	test_linker_1
		local
			ctx: LLVM_CONTEXT
			m1: MODULE
			m2: MODULE
			test_module: MODULE
			g1: GLOBAL_VARIABLE
			g2: GLOBAL_VARIABLE
			linkage_types: LINKAGE_TYPES
			l: LINKER
			m3: MODULE
			s: RAW_STRING_OSTREAM
			str: STRING_8
		do
			create ctx
			create m1.make ("m1", ctx)
			create m2.make ("m2", ctx)
			create g1.make_initializer (create {INTEGER_TYPE}.make (ctx, 32), True, linkage_types.external_linkage, create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 100))
			m1.global_list_push_back (g1)
			create g2.make_initializer (create {INTEGER_TYPE}.make (ctx, 32), True, linkage_types.external_linkage, create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 200))
			m2.global_list_push_back (g2)

			create test_module.make ("l", ctx)
			create l.make (test_module)
			l.link_in_module (m1)
			l.link_in_module (m2)
			m3 := l.get_module
			create s.make
			m3.print (s)
			str := s.string
			assert ("same_module", m3 ~ test_module)
			assert ("test_linker_1", str ~ test_linker_1_expected)

		end

	test_linker_1_expected: STRING_8 =
"[
; ModuleID = 'l'

@0 = constant i32 100
@1 = constant i32 200

]"

end


