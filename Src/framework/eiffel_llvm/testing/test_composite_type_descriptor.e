note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_COMPOSITE_TYPE_DESCRIPTOR

inherit
	EQA_TEST_SET

feature -- Test routines

	test_composite_type_descriptor_1
		local
			local_variable: LOCAL_VARIABLE_DESCRIPTOR
			compile_unit: COMPILE_UNIT_DESCRIPTOR
			composite_type: COMPOSITE_TYPE_DESCRIPTOR
			context: SUBPROGRAM_DESCRIPTOR
			members: MD_NODE
			v: VALUE_VECTOR
			basic_1: BASIC_TYPE_DESCRIPTOR
			basic_2: BASIC_TYPE_DESCRIPTOR
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
			create compile_unit.make (ctx, "file", "directory", "Eiffel", True, False, "", 0)
			create basic_1.make (ctx, compile_unit, "basic_1", compile_unit, 14, 4, 0, 0, 0, 5)
			create basic_2.make (ctx, compile_unit, "basic_2", compile_unit, 15, 4, 0, 0, 0, 5)
			create v.make
			v.push_back (basic_1.descriptor)
			v.push_back (basic_2.descriptor)
			create members.make (ctx, v)
			create composite_type.make (ctx, 19, compile_unit, "small_struct", compile_unit, 17, 4, 0, 0, 0, create {TYPE_DESCRIPTOR}.make_null, members, 0)
			create context.make (ctx, compile_unit, "context_name", "context_display_name", "context_mips_name", compile_unit, 1, create {TYPE_DESCRIPTOR}.make_null, False, True)
			create local_variable.make (ctx, 256, context, "variable_name", compile_unit, 17, composite_type)
			a.set_metadata_string ("dbg", local_variable.descriptor)
			create s.make
			m.print (s)
			s_result := s.string
		end

	test_composite_type_descriptor_1_expected: STRING_8 =

"[
; ModuleID = 'test'

define void @0() {
  %1 = alloca i32, !dbg !0
}

!0 = metadata !{i32 524544, metadata !"context_name", metadata !"variable_name", metadata !1, i32 17, metadata !2} ; [ DW_TAG_auto_variable ]
!1 = metadata !{i32 524305, i32 0, i32 40428, metadata !"file", metadata !"directory", metadata !"Eiffel", i1 true, i1 false, metadata !"", i32 0} ; [ DW_TAG_compile_unit ]
!2 = metadata !{i32 524307, metadata !1, metadata !"small_struct", metadata !1, i32 17, i64 4, i64 0, i64 0, i32 0, null, metadata !3, i32 0} ; [ DW_TAG_structure_type ]
!3 = metadata !{metadata !4, metadata !5}
!4 = metadata !{i32 524324, metadata !1, metadata !"basic_1", metadata !1, i32 14, i64 4, i64 0, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ]
!5 = metadata !{i32 524324, metadata !1, metadata !"basic_2", metadata !1, i32 15, i64 4, i64 0, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ]

]"

end


