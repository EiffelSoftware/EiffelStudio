note
	description: "[
		    Main class to instantiate
    		the creation procedure creates a working assembly, you put all your code and data into that
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_LIB

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_32; a_core_flags: INTEGER)
			-- Create the working assembly
			-- Note that this will ALLWAYS be the first assembly in the list.
		local
			l_assembly_ref: ASSEMBLY_DEF
		do
			core_flags := a_core_flags

			create module_refs.make (0)

			create {LINKED_LIST [ASSEMBLY_DEF]} assembly_refs.make
			assembly_refs.compare_objects
			create p_invoke_signatures.make (0)
			create p_invoke_references.make (0)
			create assembly_name.make_empty
			create file_name.make_empty
			create unmanaged_routines.make (0)
			create using_list.make (0)
			create container_stack.make

				-- Create the working assembly.
				-- Note that this will ALWAYS be the fisrt
				-- assembly in the list.
			create l_assembly_ref.make (a_name, False, create {ARRAY [NATURAL_8]}.make_filled (0, 1, 8))
			assembly_refs.force (l_assembly_ref)
		ensure
			valid_obj_input_size:	obj_input_size = 0
			valid_obj_input_pos:	obj_input_pos = 0
			valid_obj_input_cache:	obj_input_cache = 0
			core_flags_set:  core_flags = a_core_flags
			module_refs_empty: module_refs.is_empty
			assembly_name_empty: assembly_name.is_empty
			assembly_refs_set: assembly_refs.count = 1
			using_list_empty: using_list.is_empty
			input_stream_void: input_stream = Void
			file_name_empty: file_name.is_empty
			unmanaged_routines_empty: unmanaged_routines.is_empty
			pe_writer_void: pe_writer = Void
			container_stack_empty: container_stack.is_empty
			code_container_void: code_container = Void
			p_invoke_references_empty: p_invoke_references.is_empty
			p_invoke_signatures_empty: p_invoke_signatures.is_empty
		end

	assembly_refs: LIST [ASSEMBLY_DEF]

	p_invoke_signatures: STRING_TABLE [METHOD]

	p_invoke_references: STRING_TABLE [LIST [METHOD_SIGNATURE]]
			-- Use it as a multimap.
			-- Multimap is an associative container that contains a sorted list of key-value pairs, while permitting multiple entries with the same key.
			-- Sorting is done according to the comparison function Compare, applied to the keys. Search, insertion, and removal operations have logarithmic complexity.

	assembly_name: STRING_32

	output_stream: detachable FILE_STREAM

	input_stream: detachable FILE

	file_name: STRING_32

	unmanaged_routines: STRING_TABLE [STRING_32]

	core_flags: INTEGER

	pe_writer: detachable PE_WRITER

	using_list: ARRAYED_LIST [NAMESPACE]

	container_stack: LINKED_LIST [DATA_CONTAINER]
			-- Use it as a deque
			-- deque (usually pronounced like "deck") is an irregular acronym of double-ended queue.
			-- Double-ended queues are sequence containers with dynamic sizes that can be expanded or contracted on both ends (either its front or its back).

	code_container: detachable CODE_CONTAINER

	obj_input_buf: detachable STRING

	obj_input_size: INTEGER

	obj_input_pos: INTEGER

	obj_input_cache: INTEGER


feature -- Access

	module_refs: HASH_TABLE [NATURAL, NATURAL]


--	        ///** Get the working assembly
--        // This is the one with your code and data, that gets written to the output
--        AssemblyDef *WorkingAssembly() const { return assemblyRefs_.front(); }

	working_assembly: ASSEMBLY_DEF
			-- Get the working assembly
			-- This is the one with your code and data, that gets written to the output
		do
			Result := assembly_refs.first
		end

feature -- Access::FindType

		-- TODO check if we can use once classes

	s_notfound: INTEGER = 0
	s_ambiguous: INTEGER = 1
	s_namespace: INTEGER = 2
	s_class: INTEGER = 3
	s_enum: INTEGER = 4
	s_field: INTEGER = 5
	s_property: INTEGER = 6
	s_method: INTEGER = 7

feature -- Access::CorFlags

		-- TODO check if we can use once classes

	il_only: INTEGER = 1
			-- Set this for compatibility with .net assembly imports,
			-- unset it for standalone assemblies if you want to modify your
			-- sdata

	bits32: INTEGER = 2
			-- Set this if you want to force 32 bits - you will possibly need it
			-- for pinvokes


feature -- Operations

	add_pinvoke_reference (a_method_sig: METHOD_SIGNATURE; a_dll_name: STRING_32; iscdecl: BOOLEAN)
		local
			l_method: METHOD
		do
			create l_method.make (a_method_sig, create {QUALIFIERS}.make_with_flags ({QUALIFIERS_ENUM}.pinvokefunc | {QUALIFIERS_ENUM}.public), False)
			l_method.set_pinvoke(a_dll_name, if iscdecl then {INVOKE_TYPE}.Cdecl else {INVOKE_TYPE}.Stdcall end)
			p_invoke_signatures.force (l_method, a_method_sig.name)
		end

	allocate_method (a_method_sig: METHOD_SIGNATURE; a_flags: QUALIFIERS; a_entry: BOOLEAN): METHOD
		do
				-- TODO double check if we really need this feature.
				-- since we can create it directly.
				-- In C++ it's needed since the class it's responsible to Manage the Memory
			create Result.make (a_method_sig, a_flags, a_entry)
		end

feature -- Assembly

	mscorlib_assembly: ASSEMBLY_DEF
			-- loads the MSCorLib assembly.
		local
			l_result: ASSEMBLY_DEF
			l_system: NAMESPACE
			l_object, l_value, l_enum: CLS_CLASS
		do
			  -- [mscorlib]System.ParamArrayAttribute
  			  -- System. + typeNames_[tp_]

  			l_result := find_assembly ("mscorlib")
  			if l_result = Void then
				l_result := add_external_assembly ("mscorlib", Void)
				create l_system.make ("System")
				l_result.add (l_system)
				create l_object.make ("Object", create {QUALIFIERS}.make_with_flags ({QUALIFIERS_ENUM}.public), -1, -1)
				l_system.add (l_object)
				create l_value.make ("ValueType", create {QUALIFIERS}.make_with_flags ({QUALIFIERS_ENUM}.public), -1, -1)
				l_value.set_extend_from (l_object)
				l_system.add (l_value)
				create l_enum.make ("Enum", create {QUALIFIERS}.make_with_flags ({QUALIFIERS_ENUM}.public), -1, -1)
				l_enum.set_extend_from (l_value)
				l_system.add (l_enum)
  			end
  			Result := l_result
		end

	load_assembly (a_assembly_name: STRING_32; a_major, a_minor, a_build, a_revision: INTEGER)
			-- Load data out of an assembly.
		local
			reader: PE_READER
			l_assembly: ASSEMBLY_DEF
		do
			l_assembly := find_assembly(a_assembly_name)
			if l_assembly = Void  or else attached l_assembly and then not l_assembly.is_loaded then
				create reader.make
				reader.managed_load (a_assembly_name, a_major, a_minor, a_build, a_revision)
			end
		end

	find_assembly(a_name: STRING_32): detachable ASSEMBLY_DEF
			-- Find an assembly
		local
			found: BOOLEAN
		do
			across assembly_refs as it until found loop
				if it.name.same_string(a_name) then
					found := True
					Result := it
				end
			end
		end

    add_external_assembly (a_assembly: STRING;  a_token: detachable ARRAY [NATURAL_8]): ASSEMBLY_DEF
    		-- Add a reference to another assembly
    		-- this is an empty assembly you can put stuff in if you want to
    		--| Deprecated
    	do
			create Result.make (a_assembly, True, Void)
			assembly_refs.force (Result)
    	end

feature -- Output

	dump_output_file (a_file_name: STRING_32; a_mode: OUTPUT_MODE; a_gui: BOOLEAN)
			-- write an output file, possibilities are a .il file, an EXE or a DLL
         	-- the file can also be tagged as either console or win32
		local
			rv: BOOLEAN
			l_stream: FILE_STREAM
		do
			if a_mode = {OUTPUT_MODE}.ilasm or else a_mode = {OUTPUT_MODE}.object then
				create l_stream.make (a_file_name)
			else
				create l_stream.make_binary (a_file_name)
			end

			debug ("debug-cli")
				l_stream.enable_debug
			end
			output_stream := l_stream
			inspect a_mode
			when {OUTPUT_MODE}.ilasm then
				rv := il_src_dump
			when {OUTPUT_MODE}.peexe then
				rv := dump_pe_file (a_file_name, true, a_gui)
			when {OUTPUT_MODE}.pedll then
			when {OUTPUT_MODE}.object then
				rv :=obj_out
			else
				rv := False
			end
			l_stream.close
		end

feature {NONE} -- Output Implementation

	il_src_dump: BOOLEAN
		do
			Result := il_src_dump_header and then il_src_dump_file
		end

	il_src_dump_header: BOOLEAN
		local
			rv: BOOLEAN
		do
			if attached output_stream as l_stream then
				l_stream.put_string (".corflags ")
				l_stream.put_integer (core_flags)
				l_stream.put_new_line
				l_stream.flush
				l_stream.put_new_line
				l_stream.flush

				across assembly_refs  as it loop
					rv := it.il_header_dump (l_stream)
				end
				l_stream.put_new_line
				l_stream.flush
				Result := True
			else
				Result := False
			end

		end

	il_src_dump_file: BOOLEAN
		do
			if attached output_stream as l_stream then
				Result := working_assembly.il_src_dump (l_stream)
				across p_invoke_signatures as ic loop
					Result := ic.il_src_dump (l_stream)
				end
			else
				Result := False
			end
		end


	dump_pe_file (a_file_name: STRING_32; a_is_exe: BOOLEAN; a_is_gui: BOOLEAN): BOOLEAN
		local
			n: NATURAL
			l_pe_writer: PE_WRITER
		do
			n := 1
				-- Give initial PE Indexes for field resolution..
			n :=  working_assembly.number (n)

--			create L_pe_writer
		end

	obj_out: BOOLEAN
		do
			-- TODO to implement
		end



end
