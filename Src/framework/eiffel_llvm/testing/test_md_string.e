note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_MD_STRING

inherit
	EQA_TEST_SET

feature -- Test routines

	test_md_string_1
		local
			ctx: LLVM_CONTEXT
			m: MODULE
			t: FUNCTION_TYPE
			f: FUNCTION_L
			v: VALUE_VECTOR
			ms: MD_STRING
			mn: MD_NODE
			b: BASIC_BLOCK
			linkage_types: LINKAGE_TYPES
			a: ALLOCA_INST
			s: RAW_STRING_OSTREAM
			s_result: STRING
		do
			create ctx
			create m.make ("test", ctx)
			create t.make_without_parameters (create {TYPE_L}.make_void (ctx))
			create f.make (t, linkage_types.external_linkage)
			m.function_list_push_back (f)
			create b.make (ctx)
			f.basic_block_list_push_back (b)
			create ms.make (ctx, "test_metadata")
			create v.make
			v.push_back (ms)
			create mn.make (ctx, v)
			create a.make_type (create {INTEGER_TYPE}.make (ctx, 32))
			b.inst_list_push_back (a)
			a.set_metadata_string ("dbg", mn)
			create s.make
			m.print (s)
			s_result := s.string
			assert ("test_md_string_1", s_result ~ test_md_string_1_expected)
		end

	test_md_string_1_expected: STRING_8 =
"[
; ModuleID = 'test'

define void @0() {
  %1 = alloca i32, !dbg !0
}

!0 = metadata !{metadata !"test_metadata"}

]"

end


