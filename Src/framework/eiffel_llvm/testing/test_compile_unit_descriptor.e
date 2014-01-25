note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_COMPILE_UNIT_DESCRIPTOR

inherit
	EQA_TEST_SET

feature -- Test routines

	test_compile_unit_descriptor_1
		local
			compile_unit: COMPILE_UNIT_DESCRIPTOR
			ctx: LLVM_CONTEXT
			m: MODULE
			t: FUNCTION_TYPE
			f: FUNCTION_L
			b: BASIC_BLOCK
			g: GLOBAL_VARIABLE
			a: ALLOCA_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
			linkage_types: LINKAGE_TYPES
		do
			create ctx
			create m.make ("test", ctx)
			create t.make_without_parameters (create {TYPE_L}.make_void (ctx))
			create f.make (t, linkage_types.external_linkage)
			m.function_list_push_back (f)
			create b.make (ctx)
			f.basic_block_list_push_back (b)
			create a.make_type (create {INTEGER_TYPE}.make (ctx, 32))
			b.inst_list_push_back (a)
			create compile_unit.make (ctx, "test_file", "test/directory", "Eiffel", True, False, "", 0)
			a.set_metadata_string ("dbg", compile_unit.descriptor)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_compile_unit_descriptor_1", s_result ~ test_compile_unit_descriptor_1_expected)
		end

	test_compile_unit_descriptor_1_expected: STRING_8 =

"[
; ModuleID = 'test'

define void @0() {
  %1 = alloca i32, !dbg !0
}

!0 = metadata !{i32 524305, i32 0, i32 40428, metadata !"test_file", metadata !"test/directory", metadata !"Eiffel", i1 true, i1 false, metadata !"", i32 0} ; [ DW_TAG_compile_unit ]

]"

end


