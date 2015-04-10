note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_MODULE_PRINTING

inherit
	EQA_TEST_SET

feature -- Test routines

	test_hello_world
		local
			ctx: LLVM_CONTEXT
			module: MODULE
			str: GLOBAL_VARIABLE
			linkage_types: LINKAGE_TYPES
			int_t: INTEGER_TYPE
			str_t: ARRAY_TYPE
			str_values: CONSTANT_STLVECTOR
			main: FUNCTION_L
			puts: FUNCTION_L
			entry: BASIC_BLOCK
			return: BASIC_BLOCK
			retval: ALLOCA_INST
			call: CALL_INST
			call_arguments: VALUE_VECTOR
			br: BRANCH_INST
			output: RAW_STRING_OSTREAM
			attributes: ATTRIBUTES
			return_inst: RETURN_INST
			load: LOAD_INST
			puts_parameters: TYPE_VECTOR
			get_inst: GET_ELEMENT_PTR_INST
			get_parameters: VALUE_VECTOR
		do
			create ctx.default_create
			create module.make ("test.o", ctx)
			module.set_data_layout ("e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128")
			module.set_target_triple ("x86_64-apple-darwin10.3")
			create int_t.make (ctx, 8)
			create str_t.make (int_t, 12)
			create str_values.make
			str_values.push_back (create {CONSTANT_INT}.make (int_t, ('H').code.to_natural_64))
			str_values.push_back (create {CONSTANT_INT}.make (int_t, ('e').code.to_natural_64))
			str_values.push_back (create {CONSTANT_INT}.make (int_t, ('l').code.to_natural_64))
			str_values.push_back (create {CONSTANT_INT}.make (int_t, ('l').code.to_natural_64))
			str_values.push_back (create {CONSTANT_INT}.make (int_t, ('o').code.to_natural_64))
			str_values.push_back (create {CONSTANT_INT}.make (int_t, (' ').code.to_natural_64))
			str_values.push_back (create {CONSTANT_INT}.make (int_t, ('W').code.to_natural_64))
			str_values.push_back (create {CONSTANT_INT}.make (int_t, ('o').code.to_natural_64))
			str_values.push_back (create {CONSTANT_INT}.make (int_t, ('r').code.to_natural_64))
			str_values.push_back (create {CONSTANT_INT}.make (int_t, ('l').code.to_natural_64))
			str_values.push_back (create {CONSTANT_INT}.make (int_t, ('d').code.to_natural_64))
			str_values.push_back (create {CONSTANT_INT}.make (int_t, ('%U').code.to_natural_64))
			create str.make_initializer (str_t, True, linkage_types.internal_linkage, create {CONSTANT_ARRAY}.make (str_t, str_values))
			str.set_section ("__TEXT,__cstring,cstring_literals")
			module.global_list_push_back (str)
			create main.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {INTEGER_TYPE}.make (ctx, 32)), linkage_types.external_linkage, "main")
			create puts_parameters.make
			puts_parameters.push_back (create {POINTER_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 8)))
			create puts.make_name (create {FUNCTION_TYPE}.make_with_parameters (create {INTEGER_TYPE}.make (ctx, 32), puts_parameters), linkage_types.external_linkage, "puts")
			main.add_fn_attr (attributes.no_unwind)
			main.add_fn_attr (attributes.stack_protect)
			create entry.make_name (ctx, "entry")
			create return.make_name (ctx, "return")
			main.basic_block_list_push_back (entry)
			module.function_list_push_back (main)
			module.function_list_push_back (puts)
			create retval.make_type_name (create {INTEGER_TYPE}.make (ctx, 32), "retval")
			create get_parameters.make
			get_parameters.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 64), 0))
			get_parameters.push_back (create {CONSTANT_INT}.make (create {INTEGER_TYPE}.make (ctx, 64), 0))
			create get_inst.make_inbounds_index_list (str, get_parameters)
			create call_arguments.make
			call_arguments.push_back (get_inst)
			create call.make_arguments (puts, call_arguments)
			create load.make_name (retval, "retval1")
			create return_inst.make_value (ctx, load)
			return.inst_list_push_back (load)
			return.inst_list_push_back (return_inst)
			create br.make (return)
			main.basic_block_list_push_back (return)
			entry.inst_list_push_back (retval)
			entry.inst_list_push_back (get_inst)
			entry.inst_list_push_back (call)
			entry.inst_list_push_back (br)
			create output.make
			module.print (output)
			assert ("Output matches", output.string ~ test_hello_world_expected)
		end

	test_hello_world_expected: STRING =
"[
; ModuleID = 'test.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128"
target triple = "x86_64-apple-darwin10.3"

@0 = internal constant [12 x i8] c"Hello World\00", section "__TEXT,__cstring,cstring_literals"

define i32 @main() nounwind ssp {
entry:
  %retval = alloca i32
  %0 = getelementptr inbounds [12 x i8]* @0, i64 0, i64 0
  %1 = call i32 @puts(i8* %0)
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval
  ret i32 %retval1
}

declare i32 @puts(i8*)

]"

	test_type_naming
		local
			ctx: LLVM_CONTEXT
			module: MODULE
			v: TYPE_VECTOR
			s: STRUCT_TYPE
			output: RAW_STRING_OSTREAM
		do
			create ctx.default_create
			create module.make ("test.o", ctx)
			create v.make
			v.push_back (create {INTEGER_TYPE}.make (ctx, 32))
			create s.make (ctx, v)
			module.add_type_name ("test_type", s)
			create output.make
			module.print (output)
			assert ("Output matches", output.string ~ test_type_naming_expected)
		end

	test_type_naming_expected: STRING =
"[
; ModuleID = 'test.o'

%test_type = type { i32 }

]"

	test_function_remove
		local
			ctx: LLVM_CONTEXT
			module: MODULE
			f1: FUNCTION_L
			f2: FUNCTION_L
			search_function: FUNCTION_L
			output: RAW_STRING_OSTREAM
			s: STRING_8
			linkage_types: LINKAGE_TYPES
		do
			create ctx.default_create
			create module.make ("test.o", ctx)
			create f1.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {TYPE_L}.make_void (ctx)), linkage_types.external_linkage, "f1")
			module.function_list_push_back (f1)
			create f2.make_name (create {FUNCTION_TYPE}.make_without_parameters (create {TYPE_L}.make_void (ctx)), linkage_types.external_linkage, "f2")
			module.function_list_push_back (f2)
			assert ("test_function_remove_1", module.has_function_named (f1.get_name))
			search_function := module.get_function ("f1")
			assert ("test_function_remove_2", search_function.item /= default_pointer)
			module.remove_function (search_function)
			assert ("test_function_remove_3", not module.has_function_named (search_function.get_name))
			search_function := module.get_function ("f1")
			assert ("test_function_remove_4", search_function.item = default_pointer)
			create output.make
			module.print (output)
			s := output.string
			assert ("Output matches", s ~ test_function_remove_expected)
		end

	test_function_remove_expected: STRING =
"[
; ModuleID = 'test.o'

declare void @f2()

]"

	test_verify_1
		local
			ctx: LLVM_CONTEXT
			m1: MODULE
			m2: MODULE
			f1: FUNCTION_L
			linkage_types: LINKAGE_TYPES
			v: CONSTANT_STLVECTOR
			a: CONSTANT_ARRAY
			g: GLOBAL_VARIABLE
			ver: MODULE_VERIFICATION
			st: RAW_STRING_OSTREAM
		do
			create ctx
			create m1.make ("m1", ctx)
			create m2.make ("m2", ctx)
			create f1.make (create {FUNCTION_TYPE}.make_without_parameters (create {TYPE_L}.make_void (ctx)), linkage_types.external_linkage)
			f1.set_name ("f1")
			m1.function_list_push_back (f1)
			create v.make
			v.push_back (create {CONSTANT_EXPR}.get_bit_cast (f1, create {POINTER_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 8))))
			create a.make (create {ARRAY_TYPE}.make (create {POINTER_TYPE}.make (create {INTEGER_TYPE}.make (ctx, 8)), 1), v)
			create g.make_initializer (a.get_raw_type, True, linkage_types.external_linkage, a)
			m2.global_list_push_back (g)
			create ver.make (m2)

			create st.make
			m2.write_bit_code_to_file (st)
		end

end


