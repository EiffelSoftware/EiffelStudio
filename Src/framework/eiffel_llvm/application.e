note
	description : "llvm_test application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
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
			output: RAW_FD_OSTREAM
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
			puts.add_fn_attr (attributes.no_unwind)
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
			create output.make_filename ("/Users/colinlemahieu/Desktop/Out.ll")
			module.print (output)
		end

	make2
		local
			tr: TARGET_REGISTRY_CLASS
			it: TARGET_REGISTRY_ITERATOR
		do
			tr.initialize_all_targets
			from
				it := tr.begin
			until
				it ~ tr.end_item
			loop
				io.put_string (it.target.get_name)
				it.forth
			end
		end

	make3
			-- Run application.
		local
			tr: TARGET_REGISTRY_CLASS
			target: TARGET
			iterator: TARGET_REGISTRY_ITERATOR
			name: STRING
			module: MODULE
			diag: SM_DIAGNOSTIC
			context: LLVM_CONTEXT
			buff: MEMORY_BUFFER
			buff_size: INTEGER_32
			machine: TARGET_MACHINE
--			fd_stream: RAW_FD_OSTREAM
			fd_stream: RAW_STRING_OSTREAM
			formatted_stream: FORMATTED_RAW_OSTREAM
			pm: PASS_MANAGER
			td: TARGET_DATA
			verifier: FUNCTION_PASS
			triple_string: STRING
			assembly_buffer: MEMORY_BUFFER
			binary_buffer: RAW_STRING_OSTREAM
			output_buffer: FORMATTED_RAW_OSTREAM
			src_mgr: SOURCE_MGR
			mai: MC_ASM_INFO
			ctx: MC_CONTEXT
			ce: MC_CODE_EMITTER
			tab: TARGET_ASM_BACKEND
			str: MC_STREAMER
			parser: ASM_PARSER
			tap: TARGET_ASM_PARSER
			res: STRING
			output_file: RAW_FILE
			bc_buffer: RAW_STRING_OSTREAM
			bc_file: RAW_FILE
		do
			io.put_string ("")
			tr.initialize_all_targets
			tr.initialize_all_asm_printers
			tr.initialize_all_asm_parsers
			--create buff.get_file ("/Users/colinlemahieu/Desktop/test.o.ll")
			create buff.get_mem_buffer_copy (assembly_code)
			create diag
			create context
			create module.parse_assembly (buff, diag, context)
			create bc_buffer.make
			module.write_bit_code_to_file (bc_buffer)
			bc_buffer.flush
			create bc_file.make_open_write ("/Users/colinlemahieu/Desktop/hello.bc")
			bc_file.put_string (bc_buffer.string)
			bc_file.close
			triple_string := module.get_target_triple
			target := tr.lookup_target (triple_string)
			machine := target.create_target_machine (triple_string, "")
--			create fd_stream.make_filename ("/Users/colinlemahieu/Desktop/test.s")
			create fd_stream.make
			create formatted_stream.make_raw_ostream (fd_stream)
			create pm.default_create
			create td.make_module (module)
			pm.add (td)
			create verifier.verifier_pass
			pm.add (verifier)
			machine.add_passes_to_emit_file (pm, formatted_stream, 0, 2, True)
			pm.run (module)
			formatted_stream.flush
--			io.put_string (fd_stream.string)
--			create output_file.make_open_write ("/Users/clemahieu/Desktop/hello e bc.o")
--			output_file.put_string (fd_stream.string)
--			output_file.close
--			formatted_stream.dispose
			create assembly_buffer.get_mem_buffer_copy (fd_stream.string)
			create src_mgr.make
			src_mgr.add_new_source_buffer (assembly_buffer, create {SM_LOC}.make)
			src_mgr.set_include_dirs (create {CPP_STRING_VECTOR}.make)
			mai := target.create_asm_info (triple_string)
--			create ctx.make (mai)
			create binary_buffer.make
			create output_buffer.make_raw_ostream (binary_buffer)
			ce := target.create_code_emitter (machine, ctx)
--			tab := target.create_asm_backend (triple_string)
--			str := target.create_object_streamer (triple_string, ctx, tab, output_buffer, ce, False)
			create parser.make (src_mgr, ctx, str, mai)
			tap := target.create_asm_parser (parser)
			parser.set_target_parser (tap)
			parser.run
			output_buffer.flush
			res := binary_buffer.string
			create output_file.make_open_write ("/Users/colinlemahieu/Desktop/hello e obj.o")
			output_file.put_string (res)
			output_file.close
		end

	fun: detachable FUNCTION_L
	int: detachable INTEGER_TYPE
	a_inst: detachable ALLOCA_INST

	assembly_code: STRING =
		"[
; ModuleID = 'hello.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.3"

@.str = private constant [12 x i8] c"Hello world\00", align 1 ; <[12 x i8]*> [#uses=1]

define i32 @main() nounwind ssp {
entry:
  %retval = alloca i32                            ; <i32*> [#uses=2]
  %0 = alloca i32                                 ; <i32*> [#uses=2]
  %"alloca point" = bitcast i32 0 to i32          ; <i32> [#uses=0]
  %1 = call i32 @puts(i8* getelementptr inbounds ([12 x i8]* @.str, i64 0, i64 0)) nounwind ; <i32> [#uses=0]
  store i32 0, i32* %0, align 4
  %2 = load i32* %0, align 4                      ; <i32> [#uses=1]
  store i32 %2, i32* %retval, align 4
  br label %return

return:                                           ; preds = %entry
  %retval1 = load i32* %retval                    ; <i32> [#uses=1]
  ret i32 %retval1
}

declare i32 @puts(i8*)
		]"

end
