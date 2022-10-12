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
			l_assembly_ref: CIL_ASSEMBLY_DEF
		do
			core_flags := a_core_flags

			create module_refs.make (0)

			create {LINKED_LIST [CIL_ASSEMBLY_DEF]} assembly_refs.make
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
			valid_obj_input_size: obj_input_size = 0
			valid_obj_input_pos: obj_input_pos = 0
			valid_obj_input_cache: obj_input_cache = 0
			core_flags_set: core_flags = a_core_flags
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

	assembly_refs: LIST [CIL_ASSEMBLY_DEF]

	p_invoke_signatures: STRING_TABLE [CIL_METHOD]

	p_invoke_references: STRING_TABLE [LIST [CIL_METHOD_SIGNATURE]]
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

	using_list: ARRAYED_LIST [CIL_NAMESPACE]

	container_stack: LINKED_LIST [CIL_DATA_CONTAINER]
			-- Use it as a deque
			-- deque (usually pronounced like "deck") is an irregular acronym of double-ended queue.
			-- Double-ended queues are sequence containers with dynamic sizes that can be expanded or contracted on both ends (either its front or its back).

	code_container: detachable CIL_CODE_CONTAINER

	obj_input_buf: detachable STRING

	obj_input_size: INTEGER

	obj_input_pos: INTEGER

	obj_input_cache: INTEGER

feature -- Access

	module_refs: HASH_TABLE [NATURAL, NATURAL]

--	        ///** Get the working assembly
--        // This is the one with your code and data, that gets written to the output
--        AssemblyDef *WorkingAssembly() const { return assemblyRefs_.front(); }

	working_assembly: CIL_ASSEMBLY_DEF
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

	add_pinvoke_reference (a_method_sig: CIL_METHOD_SIGNATURE; a_dll_name: STRING_32; iscdecl: BOOLEAN)
		local
			l_method: CIL_METHOD
		do
			create l_method.make (a_method_sig, create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.pinvokefunc | {CIL_QUALIFIERS_ENUM}.public), False)
			l_method.set_pinvoke (a_dll_name, if iscdecl then {CIL_INVOKE_TYPE}.Cdecl else {CIL_INVOKE_TYPE}.Stdcall end, "")
			p_invoke_signatures.force (l_method, a_method_sig.name)
		end

	allocate_method (a_method_sig: CIL_METHOD_SIGNATURE; a_flags: CIL_QUALIFIERS; a_entry: BOOLEAN): CIL_METHOD
		do
				-- TODO double check if we really need this feature.
				-- since we can create it directly.
				-- In C++ it's needed since the class it's responsible to Manage the Memory
			create Result.make (a_method_sig, a_flags, a_entry)
		end

feature -- Assembly

	mscorlib_assembly: CIL_ASSEMBLY_DEF
			-- loads the MSCorLib assembly.
		local
			l_result: CIL_ASSEMBLY_DEF
			l_system: CIL_NAMESPACE
			l_object, l_value, l_enum: CIL_CLASS
		do
				-- [mscorlib]System.ParamArrayAttribute
				-- System. + typeNames_[tp_]

			l_result := find_assembly ("mscorlib")
			if l_result = Void then
				l_result := add_external_assembly ("mscorlib", Void)
				create l_system.make ("System")
				l_result.add (l_system)
				create l_object.make ("Object", create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), -1, -1)
				l_system.add (l_object)
				create l_value.make ("ValueType", create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), -1, -1)
				l_value.set_extend_from (l_object)
				l_system.add (l_value)
				create l_enum.make ("Enum", create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), -1, -1)
				l_enum.set_extend_from (l_value)
				l_system.add (l_enum)
			end
			Result := l_result
		end

	load_assembly (a_assembly_name: STRING_32; a_major, a_minor, a_build, a_revision: INTEGER)
			-- Load data out of an assembly.
		local
			reader: PE_READER
			l_assembly: CIL_ASSEMBLY_DEF
		do
			l_assembly := find_assembly (a_assembly_name)
			if l_assembly = Void or else attached l_assembly and then not l_assembly.is_loaded then
				create reader.make
				reader.managed_load (a_assembly_name, a_major, a_minor, a_build, a_revision)
			end
		end

	find_assembly (a_name: STRING_32): detachable CIL_ASSEMBLY_DEF
			-- Find an assembly
		local
			found: BOOLEAN
		do
			across assembly_refs as it until found loop
				if it.name.same_string (a_name) then
					found := True
					Result := it
				end
			end
		end

	add_external_assembly (a_assembly: STRING; a_token: detachable ARRAY [NATURAL_8]): CIL_ASSEMBLY_DEF
			-- Add a reference to another assembly
			-- this is an empty assembly you can put stuff in if you want to
			--| Deprecated
		do
			create Result.make (a_assembly, True, Void)
			assembly_refs.force (Result)
		end

	find (a_path: STRING_32; a_generics: detachable LIST [CIL_TYPE]; a_assembly: detachable CIL_ASSEMBLY_DEF): TUPLE [type: CIL_FIND_TYPE; resource: detachable ANY]
			-- find `a_path`, return value tells what type of object was found
		local
			l_npos: INTEGER
			l_assembly_name: STRING_32
			l_path: STRING_32
			l_assembly: CIL_ASSEMBLY_DEF
			l_split: LIST [STRING_32]
			l_found: LIST [CIL_DATA_CONTAINER]
			l_found_field: LIST [CIL_FIELD]
			l_found_method: LIST [CIL_METHOD]
			l_found_property: LIST [CIL_PROPERTY]
			l_tuple: TUPLE [index: INTEGER; dc: detachable CIL_DATA_CONTAINER]
			n: INTEGER
			exit: BOOLEAN
		do
			Result := [{CIL_FIND_TYPE}.s_notfound, Void]
			create l_path.make_from_string (a_path)
			l_path.replace_substring_all ("/", ".")

			if not l_path.is_empty and then l_path [1] = '[' then
				l_npos := l_path.index_of (']', 1)
				if l_npos /= 0 then
					l_assembly_name := l_path.substring (2, l_npos - 1)
					l_path := l_path.substring (l_npos + 1, l_path.count)
					l_assembly := find_assembly (l_assembly_name)
				end
			end
			l_split := split_path (l_path)

			create {ARRAYED_LIST [CIL_DATA_CONTAINER]} l_found.make (0)
			create {ARRAYED_LIST [CIL_FIELD]} l_found_field.make (0)
			create {ARRAYED_LIST [CIL_METHOD]} l_found_method.make (0)
			create {ARRAYED_LIST [CIL_PROPERTY]} l_found_property.make (0)

			across assembly_refs as ic loop
				if not (attached a_assembly) or else
					attached a_assembly and then a_assembly.is_equal (ic) -- TODO check
				then
					l_tuple := ic.find_container_collection (l_split, a_generics, false)
					if attached l_tuple.dc as l_dc then
						if l_tuple.index = l_split.count then
							l_found.force (l_dc)
						elseif l_tuple.index = l_split.count - 1 and then
							attached {CIL_CLASS} l_dc or else
							attached {CIL_ENUM} l_dc or else
							attached {CIL_ASSEMBLY_DEF} l_dc
						then
							across l_dc.fields as field loop
									-- TODO double check the index since C++ is 0 based.
								if field.name.same_string (l_split [l_tuple.index]) then
									l_found_field.force (field)
								end
							end
							across l_dc.methods as cc loop
								if attached {CIL_METHOD} cc as l_method and then
									l_method.prototype.name.same_string (l_split [n])
								then
									l_found_method.force (l_method)
								end
							end
							if attached {CIL_CLASS} l_dc as l_class then
								across l_class.properties as cc loop
									l_found_property.force (cc)
								end
							end
						end
					end
				end
			end

			across using_list as u loop
				l_tuple := u.find_container_collection (l_split, a_generics, false)
				if attached l_tuple.dc as l_dc then
					if l_tuple.index = l_split.count then
						l_found.force (l_dc)
					elseif l_tuple.index = l_split.count - 1 and then
						(attached {CIL_CLASS} l_dc or else
							attached {CIL_ENUM} l_dc)
					then
						across l_dc.fields as field loop
								-- TODO double check the index since C++ is 0 based.
							if field.name.same_string (l_split [l_tuple.index]) then
								l_found_field.force (field)
							end
						end
						across l_dc.methods as cc loop
							if attached {CIL_METHOD} cc as l_method and then
								l_method.prototype.name.same_string (l_split [n])
							then
								l_found_method.force (l_method)
							end
						end
						if attached {CIL_CLASS} l_dc as l_class then
							across l_class.properties as cc loop
								l_found_property.force (cc)
							end
						end
					end
				end
			end

			n := l_found.count + l_found_field.count + l_found_method.count + l_found_property.count
			if n = 0 then
				exit := True
				Result := [{CIL_FIND_TYPE}.s_notfound, Void]
			elseif not exit and then n > 1 then
				exit := True
				Result := [{CIL_FIND_TYPE}.s_ambiguous, Void]
			elseif not exit and then not l_found.is_empty then
				Result.resource := l_found [1]
				if attached {CIL_NAMESPACE} l_found [1] then
					Result.type := {CIL_FIND_TYPE}.s_namespace
				elseif attached {CIL_CLASS} l_found [1] then
					Result.type := {CIL_FIND_TYPE}.s_class
				elseif attached {CIL_ENUM} l_found [1] then
					Result.type := {CIL_FIND_TYPE}.s_enum
				end
				exit := True
			elseif not exit and then not l_found_method.is_empty then
				Result := [{CIL_FIND_TYPE}.s_method, l_found_method [1]]
				exit := True
			elseif not exit and then not l_found_field.is_empty then
				Result := [{CIL_FIND_TYPE}.s_field, l_found_field [1]]
				exit := True
			elseif not exit and then not l_found_property.is_empty then
				Result := [{CIL_FIND_TYPE}.s_property, l_found_property [1]]
				exit := True
			end

		end

feature {ANY} -- Implementation

	split_path (a_path: STRING_32): LIST [STRING_32]
		local
			l_last: STRING_32
			l_path: STRING_32
			n: INTEGER_32
			l_split: LIST [STRING_32]
		do
			l_last := ""
			create {ARRAYED_LIST [STRING_32]} Result.make (0)
			create l_path.make_from_string (a_path)
			n := l_path.index_of (':', 1)
			if n /= 0 and then n < l_path.count - 2 and then l_path [n + 1] = ':' then
				l_last := l_path.substring (n + 2, l_path.count)
				l_path := l_path.substring (1, n - 1)
			end
			n := l_path.index_of ('.', 1)
			from
			until
				n = 0
			loop
				Result.force (l_path.substring (1, n - 1))
				if l_path.count > n + 1 then
					l_path := l_path.substring (n + 1, l_path.count)
				else
					l_path := ""
				end
				n := l_path.index_of ('.', 1)
			end
			if not l_path.is_empty then
				Result.force (l_path)
			end
			if not l_last.is_empty then
				Result.force (l_last)
			end

			if Result.count > 2 then
				if Result [Result.count].same_string ("ctor") or else Result [Result.count].same_string ("cctor") then
					if Result [Result.count - 1].is_empty then
						Result [Result.count - 1] := "." + Result [Result.count]
						Result.prune (Result [Result.count])
					end
				end
			end
		end

feature -- Output

	dump_output_file (a_file_name: STRING_32; a_mode: CIL_OUTPUT_MODE; a_gui: BOOLEAN)
			-- write an output file, possibilities are a .il file, an EXE or a DLL
			-- the file can also be tagged as either console or win32
		local
			rv: BOOLEAN
			l_stream: FILE_STREAM
		do
			if a_mode = {CIL_OUTPUT_MODE}.ilasm or else a_mode = {CIL_OUTPUT_MODE}.object then
				create l_stream.make (a_file_name)
			else
				create l_stream.make_binary (a_file_name)
			end

			debug ("debug-cli")
				l_stream.enable_debug
			end
			output_stream := l_stream
			inspect a_mode
			when {CIL_OUTPUT_MODE}.ilasm then
				rv := il_src_dump
			when {CIL_OUTPUT_MODE}.peexe then
				rv := dump_pe_file (a_file_name, true, a_gui)
			when {CIL_OUTPUT_MODE}.pedll then
			when {CIL_OUTPUT_MODE}.object then
				rv := obj_out
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

				across assembly_refs as it loop
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
			n := working_assembly.number (n)

--			create L_pe_writer
		end

	obj_out: BOOLEAN
		do
				-- TODO to implement
		end

end
