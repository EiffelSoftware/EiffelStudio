note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_OPAQUE_TYPE

--inherit
--	EQA_TEST_SET

--feature -- Test routines

--	test_opaque_type_1
--		local
--			ctx: LLVM_CONTEXT
--			m: MODULE
--			linkage_types: LINKAGE_TYPES
--			t: TYPE_VECTOR
--			st: STRUCT_TYPE
--			g: GLOBAL_VARIABLE
--			s: RAW_STRING_OSTREAM
--			s_result: STRING
--		do
--			create ctx
--			create m.make ("test", ctx)
--			create t.make
--			t.push_back (create {INTEGER_TYPE}.make (ctx, 32))
--			t.push_back (create {OPAQUE_TYPE}.make (ctx))
--			create st.make (ctx, t)
--			create g.make (st, True, linkage_types.external_linkage)
--			m.global_list_push_back (g)
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_1", s_result ~ test_opaque_type_1_expected)
--		end

--	test_opaque_type_1_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--%0 = type { i32, %1 }
--%1 = type opaque

--@0 = external constant %0                         ; <%0*> [#uses=0]

--]"

--	test_opaque_type_2
--		local
--			ctx: LLVM_CONTEXT
--			m: MODULE
--			linkage_types: LINKAGE_TYPES
--			o: OPAQUE_TYPE
--			p: TYPE_VECTOR
--			pt: POINTER_TYPE
--			i: STRUCT_TYPE
--			g: GLOBAL_VARIABLE
--			s: RAW_STRING_OSTREAM
--			s_result: STRING
--		do
--			create ctx
--			create m.make ("test", ctx)
--			create p.make
--			p.push_back (create {INTEGER_TYPE}.make (ctx, 32))
--			create o.make (ctx)
--			p.push_back (o)
--			create i.make (ctx, p)
--			create g.make (i, True, linkage_types.external_linkage)
--			m.global_list_push_back (g)
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_2_1", s_result ~ test_opaque_type_2_1_expected)
--			create pt.make (i)
--			o.refine_abstract_type_to (pt)
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_2_2", s_result ~ test_opaque_type_2_2_expected)
--		end

--	test_opaque_type_2_1_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--%0 = type { i32, %1 }
--%1 = type opaque

--@0 = external constant %0                         ; <%0*> [#uses=0]

--]"

--	test_opaque_type_2_2_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--%0 = type { i32, %0* }

--@0 = external constant %0                         ; <%0*> [#uses=0]

--]"

--	test_opaque_type_3
--		local
--			ctx: LLVM_CONTEXT
--			m: MODULE
--			linkage_types: LINKAGE_TYPES
--			o: OPAQUE_TYPE
--			p: POINTER_TYPE
--			g: GLOBAL_VARIABLE
--			s: RAW_STRING_OSTREAM
--			s_result: STRING
--		do
--			create ctx
--			create m.make ("test", ctx)
--			create o.make (ctx)
--			create p.make (o)
--			create g.make (p, True, linkage_types.external_linkage)
--			m.global_list_push_back (g)
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_3_1", s_result ~ test_opaque_type_3_1_expected)
--			p.refine_abstract_type_to (create {POINTER_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 32)))
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_3_2", s_result ~ test_opaque_type_3_2_expected)
--		end

--	test_opaque_type_3_1_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--%0 = type opaque

--@0 = external constant %0*                        ; <%0**> [#uses=0]

--]"

--	test_opaque_type_3_2_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--@0 = external constant i32*                       ; <i32**> [#uses=0]

--]"

--	test_opaque_type_4
--		local
--			ctx: LLVM_CONTEXT
--			m: MODULE
--			linkage_types: LINKAGE_TYPES
--			o: OPAQUE_TYPE
--			p: POINTER_TYPE
--			g: GLOBAL_VARIABLE
--			s: RAW_STRING_OSTREAM
--			s_result: STRING
--		do
--			create ctx
--			create m.make ("test", ctx)
--			create o.make (ctx)
--			create p.make (o)
--			create g.make (p, True, linkage_types.external_linkage)
--			m.global_list_push_back (g)
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_4_1", s_result ~ test_opaque_type_4_1_expected)
--			o.refine_abstract_type_to (create {INTEGER_TYPE}.make (ctx, 32))
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_4_2", s_result ~ test_opaque_type_4_2_expected)
--		end

--	test_opaque_type_4_1_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--%0 = type opaque

--@0 = external constant %0*                        ; <%0**> [#uses=0]

--]"

--	test_opaque_type_4_2_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--@0 = external constant i32*                       ; <i32**> [#uses=0]

--]"

--	test_opaque_type_5
--		local
--			ctx: LLVM_CONTEXT
--			m: MODULE
--			linkage_types: LINKAGE_TYPES
--			o: OPAQUE_TYPE
--			p: POINTER_TYPE
--			g: GLOBAL_VARIABLE
--			s: RAW_STRING_OSTREAM
--			s_result: STRING
--		do
--			create ctx
--			create m.make ("test", ctx)
--			create o.make (ctx)
--			create p.make (o)
--			create g.make_initializer (p, True, linkage_types.external_linkage, create {CONSTANT_POINTER_NULL}.make (p))
--			m.global_list_push_back (g)
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_5_1", s_result ~ test_opaque_type_5_1_expected)
--			o.refine_abstract_type_to (create {INTEGER_TYPE}.make (ctx, 32))
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_5_2", s_result ~ test_opaque_type_5_2_expected)
--		end

--	test_opaque_type_5_1_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--%0 = type opaque

--@0 = constant %0* null                            ; <%0**> [#uses=0]

--]"

--	test_opaque_type_5_2_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--@0 = constant i32* null                           ; <i32**> [#uses=0]

--]"

--	test_opaque_type_6
--		local
--			ctx: LLVM_CONTEXT
--			m: MODULE
--			linkage_types: LINKAGE_TYPES

--			t1: TYPE_VECTOR
--			v1: CONSTANT_STLVECTOR
--			c1: CONSTANT_STRUCT
--			st1: STRUCT_TYPE
--			o1: OPAQUE_TYPE
--			o2: OPAQUE_TYPE
--			p1: POINTER_TYPE
--			p2: POINTER_TYPE
--			g1: GLOBAL_VARIABLE

--			t2: TYPE_VECTOR
--			v2: CONSTANT_STLVECTOR
--			c2: CONSTANT_STRUCT
--			st2: STRUCT_TYPE
--			o3: OPAQUE_TYPE
--			o4: OPAQUE_TYPE
--			p3: POINTER_TYPE
--			p4: POINTER_TYPE
--			g2: GLOBAL_VARIABLE

--			s: RAW_STRING_OSTREAM
--			s_result: STRING
--		do
--			create ctx
--			create m.make ("test", ctx)
--			create t1.make
--			create v1.make
--			create o1.make (ctx)
--			create p1.make (o1)
--			t1.push_back (p1)
--			v1.push_back (create {CONSTANT_POINTER_NULL}.make (create {POINTER_TYPE}.make (o1)))
--			create o2.make (ctx)
--			create p2.make (o2)
--			t1.push_back (p2)
--			v1.push_back (create {CONSTANT_POINTER_NULL}.make (create {POINTER_TYPE}.make (o2)))
--			create c1.make (ctx, v1)
--			create st1.make (ctx, t1)
--			create g1.make_initializer (st1, True, linkage_types.external_linkage, c1)
--			m.global_list_push_back (g1)

--			create t2.make
--			create v2.make
--			create o3.make (ctx)
--			create p3.make (o3)
--			t2.push_back (p3)
--			v2.push_back (create {CONSTANT_POINTER_NULL}.make (create {POINTER_TYPE}.make (o3)))
--			create o4.make (ctx)
--			create p4.make (o4)
--			t2.push_back (p4)
--			v2.push_back (create {CONSTANT_POINTER_NULL}.make (create {POINTER_TYPE}.make (o4)))
--			create c2.make (ctx, v2)
--			create st2.make (ctx, t2)
--			create g2.make_initializer (st2, True, linkage_types.external_linkage, c2)
--			m.global_list_push_back (g2)
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_6_1", s_result ~ test_opaque_type_6_1_expected)
--			o1.refine_abstract_type_to (st1)
--			o2.refine_abstract_type_to (st1)
--			o3.refine_abstract_type_to (st2)
--			o4.refine_abstract_type_to (st2)
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_6_2", s_result ~ test_opaque_type_6_2_expected)
--		end

--	test_opaque_type_6_1_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--%0 = type { %1*, %2* }
--%1 = type opaque
--%2 = type opaque
--%3 = type { %4*, %5* }
--%4 = type opaque
--%5 = type opaque

--@0 = constant %0 zeroinitializer                  ; <%0*> [#uses=0]
--@1 = constant %3 zeroinitializer                  ; <%3*> [#uses=0]

--]"

--	test_opaque_type_6_2_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--%0 = type { %0*, %0* }

--@0 = constant %0 zeroinitializer                  ; <%0*> [#uses=0]
--@1 = constant %0 zeroinitializer                  ; <%0*> [#uses=0]

--]"

--	test_opaque_type_7
--		local
--			ctx: LLVM_CONTEXT
--			m: MODULE
--			linkage_types: LINKAGE_TYPES

--			t1: TYPE_VECTOR
--			v1: CONSTANT_STLVECTOR
--			c1: CONSTANT_STRUCT
--			st1: STRUCT_TYPE
--			sh1: PA_TYPE_HOLDER
--			o1: OPAQUE_TYPE
--			o2: OPAQUE_TYPE
--			p1: POINTER_TYPE
--			p2: POINTER_TYPE
--			g1: GLOBAL_VARIABLE

--			t2: TYPE_VECTOR
--			v2: CONSTANT_STLVECTOR
--			c2: CONSTANT_STRUCT
--			st2: STRUCT_TYPE
--			sh2: PA_TYPE_HOLDER
--			o3: OPAQUE_TYPE
--			o4: OPAQUE_TYPE
--			p3: POINTER_TYPE
--			p4: POINTER_TYPE
--			g2: GLOBAL_VARIABLE

--			s: RAW_STRING_OSTREAM
--			s_result: STRING
--		do
--			create ctx
--			create m.make ("test", ctx)
--			create t1.make
--			create v1.make
--			create o1.make (ctx)
--			create p1.make (o1)
--			t1.push_back (create {INTEGER_TYPE}.make (ctx, 32))
--			v1.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 14))
--			t1.push_back (p1)
--			v1.push_back (create {CONSTANT_POINTER_NULL}.make (p1))
--			create o2.make (ctx)
--			create p2.make (o2)
--			t1.push_back (p2)
--			v1.push_back (create {CONSTANT_POINTER_NULL}.make (p2))
--			create c1.make (ctx, v1)
--			create st1.make (ctx, t1)
--			create sh1.make (st1)
--			create g1.make_initializer (create {POINTER_TYPE}.make (st1), True, linkage_types.external_linkage, create {CONSTANT_POINTER_NULL}.make (create {POINTER_TYPE}.make (st1)))
--			m.global_list_push_back (g1)
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_7_1", s_result ~ test_opaque_type_7_1_expected)
--			o1.refine_abstract_type_to (sh1.get)
--			o2.refine_abstract_type_to (sh1.get)
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_7_2", s_result ~ test_opaque_type_7_2_expected)

--			create t2.make
--			create v2.make
--			create o3.make (ctx)
--			create p3.make (o3)
--			t2.push_back (create {INTEGER_TYPE}.make (ctx, 32))
--			v2.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 32), 14))
--			t2.push_back (p3)
--			v2.push_back (create {CONSTANT_POINTER_NULL}.make (p3))
--			create o4.make (ctx)
--			create p4.make (o4)
--			t2.push_back (p4)
--			v2.push_back (create {CONSTANT_POINTER_NULL}.make (p4))
--			create c2.make (ctx, v2)
--			create st2.make (ctx, t2)
--			create sh2.make (st2)
--			create g2.make_initializer (create {POINTER_TYPE}.make (st2), True, linkage_types.external_linkage, create {CONSTANT_POINTER_NULL}.make (create {POINTER_TYPE}.make (st2)))
--			m.global_list_push_back (g2)
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_7_3", s_result ~ test_opaque_type_7_3_expected)
--			o3.refine_abstract_type_to (sh2.get)
--			o4.refine_abstract_type_to (sh2.get)
--			create s.make
--			m.print (s)
--			s_result := s.string
--			assert ("test_opaque_type_7_4", s_result ~ test_opaque_type_7_4_expected)
--		end

--	test_opaque_type_7_1_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--%0 = type { i32, %1*, %2* }
--%1 = type opaque
--%2 = type opaque

--@0 = constant %0* null                            ; <%0**> [#uses=0]

--]"

--	test_opaque_type_7_2_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--%0 = type { i32, %0*, %0* }

--@0 = constant %0* null                            ; <%0**> [#uses=0]

--]"

--	test_opaque_type_7_3_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--%0 = type { i32, %0*, %0* }
--%1 = type { i32, %2*, %3* }
--%2 = type opaque
--%3 = type opaque

--@0 = constant %0* null                            ; <%0**> [#uses=0]
--@1 = constant %1* null                            ; <%1**> [#uses=0]

--]"

--	test_opaque_type_7_4_expected: STRING_8 =
--"[
--; ModuleID = 'test'

--%0 = type { %0*, %0* }

--@0 = constant %0 zeroinitializer                  ; <%0*> [#uses=0]
--@1 = constant %0 zeroinitializer                  ; <%0*> [#uses=0]

--]"

--	test_opaque_type_8
--		local
--			ctx: LLVM_CONTEXT
--			h: PA_TYPE_HOLDER
--			o: OPAQUE_TYPE
--		do
--			create ctx
--			create h.make (create {OPAQUE_TYPE}.make (ctx))
--			o := h.get.cast_to_opaque_type
--			o.refine_abstract_type_to (create {INTEGER_TYPE}.make (ctx, 32))
--		end

end


