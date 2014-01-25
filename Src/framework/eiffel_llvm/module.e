note
	description: "Summary description for {MODULE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MODULE

inherit

	ANY
		rename
			print as print_eif
		end

	DEBUG_OUTPUT
		rename
			print as print_eif
		end

create

	make,
	make_from_pointer,
--	parse_ir_file
	parse_assembly

feature {NONE} -- Creation

	make (module_id: STRING; context: LLVM_CONTEXT)
		local
			module_id_c_string: C_STRING
			module_id_str_ref: STRING_REF
		do
			create module_id_c_string.make (module_id)
			create module_id_str_ref.make (module_id_c_string.item)
			item := ctor_external (module_id_str_ref.item, context.item)
		end

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

--	parse_ir_file (filename_a: STRING; err: SM_DIAGNOSTIC; context: LLVM_CONTEXT)
--		local
--			filename_c_string: C_STRING
--			result_pointer: POINTER
--		do
--			create filename_c_string.make (filename_a)
--			result_pointer := parse_ir_file_external (filename_c_string.item, err.item, context.item)
--		end

	parse_assembly (buffer: MEMORY_BUFFER; err: SM_DIAGNOSTIC; context: LLVM_CONTEXT)
		do
			item := parse_assembly_external (buffer.item, default_pointer, err.item, context.item)
			if item = default_pointer then
				(create {EXCEPTION}).raise
			end
		end

feature

	debug_output: STRING_8
		do
			Result := get_module_identifier
		end

	get_module_identifier: STRING_8
		local
			c_string: C_STRING
		do
			create c_string.own_from_pointer (get_module_identifier_external (item))
			Result := c_string.string
		end

	function_list_push_back (v: FUNCTION_L)
		require
			not_present: v.has_name implies not has_function_named (v.get_name)
		do
			function_list_push_back_external (item, v.item)
		end

	has_function_named (name: STRING_8): BOOLEAN
		local
			name_ref: STRING_REF
		do
			name_ref := name
			Result := has_function_external (item, name_ref.item)
		end

	has_global (v: GLOBAL_VARIABLE): BOOLEAN
		local
			name_ref: STRING_REF
		do
			name_ref := v.get_name
			Result := has_global_external (item, name_ref.item)
		end

	get_global (name: STRING_8): GLOBAL_VARIABLE
		local
			name_ref: STRING_REF
		do
			name_ref := name
			create Result.make_from_pointer (get_global_external (item, name_ref.item))
		end

	remove_global (v: GLOBAL_VARIABLE)
		require
			has_global (v)
		do
			remove_global_external (item, v.item)
		end

	get_function (name: STRING_8): FUNCTION_L
		local
			name_ref: STRING_REF
		do
			name_ref := name
			create Result.make_from_pointer (get_function_external (item, name_ref.item))
		end

	remove_function (v: FUNCTION_L)
		require
			has_function_named (v.get_name)
		do
			remove_function_external (item, v.item)
		end

	global_list_push_back (v: GLOBAL_VARIABLE)
		do
			global_list_push_back_external (item, v.item)
		end

--	get_function_list: FUNCTION_LIST_TYPE
--		do
--			create Result.make
--			get_function_list_external (item, Result.item)
--		end

	get_or_insert_function_with_type (name: STRING; t: FUNCTION_TYPE): CONSTANT
		local
			name_c_string: C_STRING
			name_string_ref: STRING_REF
		do
			create name_c_string.make (name)
			create name_string_ref.make (name_c_string.item)
			create Result.make_from_pointer (get_or_insert_function_with_type_external (item, name_string_ref.item, t.item))
		end

	get_target_triple: STRING
		local
			c_result: C_STRING
		do
			create c_result.own_from_pointer (get_target_triple_external (item))
			Result := c_result.string
		end

	write_bit_code_to_file (output: RAW_OSTREAM)
		do
			check broken: False end
			write_bit_code_to_file_external (item, output.item)
		end

	module_identifier: STRING
		local
			external_string: CPP_STRING
		do
			create external_string.make
			module_identifier_external (item, external_string.item)
		end

	set_data_layout (dl: STRING)
		local
			dl_c_string: C_STRING
			dl_ref: STRING_REF
		do
			create dl_c_string.make (dl)
			create dl_ref.make (dl_c_string.item)
			set_data_layout_external (item, dl_ref.item)
		end

	set_target_triple (t: STRING)
		local
			t_c_string: C_STRING
			t_ref: STRING_REF
		do
			create t_c_string.make (t)
			create t_ref.make (t_c_string.item)
			set_target_triple_external (item, t_ref.item)
		end

	add_type_name (name: STRING_REF; ty: TYPE_L)
		local
			already_there: BOOLEAN
		do
			check signature_changed: False end
--			already_there := add_type_name_external (item, name.item, ty.item)
		end

	print (os: RAW_OSTREAM)
		do
			print_external (item, os.item)
		end

	write_bitcode (bc: BITSTREAM_WRITER)
		do
			check signature_changed: False end
--			write_bitcode_external (item, bc.item)
		end

feature {NONE} -- Externals

	remove_function_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				((llvm::Module *)$item_a)->getFunctionList ().erase ((llvm::Function *)$v);
			]"
		end

	remove_global_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				((llvm::Module *)$item_a)->getGlobalList ().erase ((llvm::GlobalVariable *)$v);
			]"
		end

	get_function_external (item_a: POINTER; v: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				return ((llvm::Module *)$item_a)->getFunction(*((llvm::StringRef *)$v));
			]"
		end

	get_global_external (item_a: POINTER; v: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				return ((llvm::Module *)$item_a)->getNamedGlobal (*((llvm::StringRef *)$v));
			]"
		end

	has_function_external (item_a: POINTER; v: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				return ((llvm::Module *)$item_a)->getFunction (*((llvm::StringRef *)$v)) != NULL;
			]"
		end

	has_global_external (item_a: POINTER; v: POINTER): BOOLEAN
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				return ((llvm::Module *)$item_a)->getNamedGlobal (*((llvm::StringRef *)$v)) != NULL;
			]"
		end

	get_module_identifier_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				std::string result_str;
				size_t result_size;
				char * result;
				
				result_str = ((llvm::Module *)$item_a)->getModuleIdentifier ();
				result_size = result_str.length () + 1;
				result = (char *)malloc (result_size);
				strncpy (result, result_str.c_str (), result_size);
				return result;
			]"
		end

--	write_bitcode_external (item_a: POINTER; bc: POINTER)
--		external
--			"C++ inline use %"llvm/Bitcode/BitstreamWriter.h%""
--		alias
--			"[
--				llvm::WriteBitcodeToStream ((llvm::Module *)$item_a, *((llvm::BitstreamWriter *)$bc));
--			]"
--		end

--	add_type_name_external (item_a: POINTER; name: POINTER; ty: POINTER): BOOLEAN
--		external
--			"C++ inline use %"llvm/IR/Module.h%""
--		alias
--			"[
--				return ((llvm::Module *)$item_a)->addTypeName (*((llvm::StringRef *)$name), (llvm::Type *)$ty);
--			]"
--		end

	print_external (item_a: POINTER; os: POINTER)
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				((llvm::Module *)$item_a)->print (*((llvm::raw_ostream *)$os), NULL);
			]"
		end

	set_target_triple_external (item_a: POINTER; t: POINTER)
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				((llvm::Module *)$item_a)->setTargetTriple (*((llvm::StringRef *)$t));
			]"
		end

	set_data_layout_external (item_a: POINTER; dl: POINTER)
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				((llvm::Module *)$item_a)->setDataLayout (*((llvm::StringRef *)$dl));
			]"
		end

	global_list_push_back_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				((llvm::Module *)$item_a)->getGlobalList ().push_back ((llvm::GlobalVariable *)$v);
			]"
		end

	function_list_push_back_external (item_a: POINTER; v: POINTER)
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				((llvm::Module *)$item_a)->getFunctionList ().push_back ((llvm::Function *)$v);
			]"
		end

--	get_function_list_external (item_a: POINTER; target: POINTER)
--		external
--			"C++ inline use %"llvm/IR/Module.h%""
--		alias
--			"[
--				*((llvm::Module::FunctionListType *)$target) = ((llvm::Module *)$item_a)->getFunctionList ();		
--			]"
--		end

	get_or_insert_function_with_type_external (item_a: POINTER; name: POINTER; t: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Module.h%", %"llvm/ADT/StringRef.h%", %"llvm/IR/DerivedTypes.h%""
		alias
			"[
				return ((llvm::Module *)$item_a)->getOrInsertFunction (*((llvm::StringRef *)$name), (llvm::FunctionType *)$t);
			]"
		end

	ctor_external (module_id: POINTER; context: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				return new llvm::Module (*((llvm::StringRef *)$module_id), *((llvm::LLVMContext *)$context))
			]"
		end

	module_identifier_external (item_a: POINTER; target_a: POINTER)
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				*((std::string *)$target_a) = ((llvm::Module *)$item_a)->getModuleIdentifier ();
			]"
		end

	write_bit_code_to_file_external (item_a: POINTER; output: POINTER)
		external
			"C++ inline use %"llvm/Bitcode/ReaderWriter.h%", <llvm/Support/raw_ostream.h>"
		alias
			"[
				llvm::WriteBitcodeToFile (((llvm::Module *)$item_a), *((llvm::raw_ostream *)$output));
			]"
		end

	get_target_triple_external (item_a: POINTER): POINTER
		external
			"C++ inline use %"llvm/IR/Module.h%""
		alias
			"[
				std::string triple;
				char * result;
				size_t result_size;
				
				triple = ((llvm::Module *)$item_a)->getTargetTriple ();
				result_size = triple.length () + 1;
				result = (char *)malloc (result_size);
				strncpy (result, triple.c_str (), result_size);
				
				return result;
			]"
		end

	parse_assembly_external (buffer: POINTER; module: POINTER; err: POINTER; context: POINTER): POINTER
		external
			"C++ inline use %"llvm/Assembly/Parser.h%", %"llvm/IR/Module.h%", %"llvm/Support/SourceMgr.h%", %"llvm/Support/MemoryBuffer.h%""
		alias
			"[
				return llvm::ParseAssembly ((llvm::MemoryBuffer *)$buffer, (llvm::Module *)$module, *((llvm::SMDiagnostic *)$err), *((llvm::LLVMContext *)$context));
			]"
		end

--	parse_ir_file_external (filename_a: POINTER; err: POINTER; context: POINTER): POINTER
--		external
--			"C++ inline use %"llvm/LLVMContext.h%", %"llvm/Support/IRReader.h%""
--		alias
--			"[
--				std::string filename ((const char *)$filename_a);		
--				
--				return ParseIRFile (filename, *((SMDiagnostic *)$err), *((LLVMContext *)$context));
--			]"
--		end

feature -- Implementation

	item: POINTER
end
