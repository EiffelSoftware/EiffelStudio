note
	description: "[
				
				
						    // TODO: the AST of PELib can be considerably simplified (we actually only need what the IlEmitter API provides)
			    			// TODO: the PEDump implementation still has issues (e.g. redundant calls to PEDump out in the tree leading to
						    // redundant types with different IDs and thus runtime exceptions because of "wrong" signatures)
							
							Main class to instantiate
						    the creation procedure creates a working assembly, you put all your code and data into that
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_LIB

inherit

	REFACTORING_HELPER

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
			create module_guid.make_filled (0, 1, 16)
			create {ARRAYED_LIST [CIL_METHOD]} all_methods.make (0)
			create source_file.make_empty
			create lib_path.make_empty
		ensure
			valid_obj_input_size: obj_input_size = 0
			valid_obj_input_pos: obj_input_pos = 0
			valid_obj_input_cache: obj_input_cache = 0
			core_flags_set: core_flags = a_core_flags
			module_refs_empty: module_refs.is_empty
			assembly_name_empty: assembly_name.is_empty
			assembly_refs_set: assembly_refs.count = 1
			using_list_empty: using_list.is_empty
			file_name_empty: file_name.is_empty
			unmanaged_routines_empty: unmanaged_routines.is_empty
			pe_writer_void: pe_writer = Void
			container_stack_empty: container_stack.is_empty
			code_container_void: code_container = Void
			p_invoke_references_empty: p_invoke_references.is_empty
			p_invoke_signatures_empty: p_invoke_signatures.is_empty
			module_guid_set: module_guid.count = 16
			all_method_set: all_methods.is_empty
			source_file_empty: source_file.is_empty
			lib_path_empty: lib_path.is_empty
		end

feature -- Access

	assembly_refs: LIST [CIL_ASSEMBLY_DEF]

	p_invoke_signatures: STRING_TABLE [CIL_METHOD]

	p_invoke_references: STRING_TABLE [LIST [CIL_METHOD_SIGNATURE]]
			-- Use it as a multimap.
			-- Multimap is an associative container that contains a sorted list of key-value pairs, while permitting multiple entries with the same key.
			-- Sorting is done according to the comparison function Compare, applied to the keys. Search, insertion, and removal operations have logarithmic complexity.

	assembly_name: STRING_32

	output_stream: detachable FILE_STREAM

	file_name: STRING_32

	unmanaged_routines: STRING_TABLE [STRING_32]

	core_flags: INTEGER
			-- the core flags.

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

	module_refs: HASH_TABLE [NATURAL, NATURAL]

	module_GUID: ARRAY [NATURAL_8]
			-- the length should be 16.

	source_file: STRING_32

	all_methods: LIST [CIL_METHOD]

	lib_path: STRING_32

feature -- Access::CorFlags

		-- TODO check if we can use once classes

	il_only: INTEGER = 1
			-- Set this for compatibility with .net assembly imports,
			-- unset it for standalone assemblies if you want to modify your
			-- sdata

	bits32: INTEGER = 2
			-- Set this if you want to force 32 bits - you will possibly need it
			-- for pinvokes

feature -- Operations: PInvoke

	add_pinvoke_reference (a_method_sig: CIL_METHOD_SIGNATURE; a_dll_name: STRING_32; iscdecl: BOOLEAN)
			-- References as always added to this object.
		local
			l_method: CIL_METHOD
		do
			create l_method.make (a_method_sig, create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.pinvokefunc | {CIL_QUALIFIERS_ENUM}.public), False)
			l_method.set_pinvoke (a_dll_name, if iscdecl then {CIL_INVOKE_TYPE}.Cdecl else {CIL_INVOKE_TYPE}.Stdcall end, "")
			p_invoke_signatures.force (l_method, a_method_sig.name)
		end

	add_pinvoke_with_varargs (a_signature: CIL_METHOD_SIGNATURE)
		local
			list: LIST [CIL_METHOD_SIGNATURE]
		do
			if attached {LIST [CIL_METHOD_SIGNATURE]} p_invoke_references.item (a_signature.name) as l_list then
				l_list.force (a_signature)
			else
				create {ARRAYED_LIST [CIL_METHOD_SIGNATURE]} list.make (1)
				list.force (a_signature)
				p_invoke_references.force (list, a_signature.name)
			end
		end

	remove_pinvoke_reference (a_name: STRING_32)
			-- Remove pinvoke reference associated with `a_name', if present.
		do
			p_invoke_references.remove (a_name)
		end

	find_pinvoke (a_name: STRING_32): detachable CIL_METHOD
		do
			if attached {CIL_METHOD} p_invoke_signatures.item (a_name) as l_method then
				Result := l_method
			end
		end

	find_pinvoke_with_varargs (a_name: STRING_32; a_vargs: LIST [CIL_PARAM]): detachable CIL_METHOD_SIGNATURE
		local
			i: INTEGER
			exit: BOOLEAN
		do
			if attached {LIST [CIL_METHOD_SIGNATURE]} p_invoke_references.item (a_name) as l_list then
				across l_list as ic until exit loop
					if a_vargs.count = ic.vararg_params.count then
						from
							i := 1
						until
							i > l_list.count or else exit
						loop
								-- -- TODO double check this condition.
							if attached {CIL_TYPE} ic.vararg_params [i].type as l_type1 and then
								attached {CIL_TYPE} a_vargs [i].type as l_type2 and then
								not l_type1.matches (l_type2)
							then

								exit := True
							else
								i := i + 1
							end
							if i > l_list.count and then not exit then
								Result := l_list [i - 1]
								exit := True
							end
						end
					end
				end
			end
		end

feature -- Operations

	traverse (a_callback: CIL_CALLBACK)
			--  Traverse the declaration tree.
		do
			fixme ("In C++ code, there is a method declaration in PElib.h, but there is no implementation in the PElib.cpp")
		end

	allocate_method (a_method_sig: CIL_METHOD_SIGNATURE; a_flags: CIL_QUALIFIERS; a_entry: BOOLEAN): CIL_METHOD
		do
				-- TODO double check if we really need this feature.
				-- since we can create it directly.
				-- In C++ it's needed since the class it's responsible to Manage the Memory
			create Result.make (a_method_sig, a_flags, a_entry)
		end

	find_or_create_generics (a_name: STRING_32; a_generics: LIST [CIL_TYPE]): detachable CIL_CLASS
		local
			l_tuple: TUPLE [type: CIL_FIND_TYPE; resource: detachable ANY]
			l_class: CIL_CLASS
			l_m1: CIL_METHOD_SIGNATURE
			l_nm: CIL_METHOD
		do
			l_tuple := find (a_name, a_generics, Void)
			if l_tuple.type = {CIL_FIND_TYPE}.s_class then
				if attached {CIL_CLASS} l_tuple.resource as l_resource then
					Result := l_resource
				end
			else
				l_tuple := find (a_name, Void, Void)
				if l_tuple.type = {CIL_FIND_TYPE}.s_class and then
					attached {CIL_CLASS} l_tuple.resource as l_resource
				then
					create l_class.make_from_class (l_resource)
					l_class.set_generics (a_generics)
					l_class.set_generic_parent (l_resource)
					if attached l_resource.parent as l_parent then
						l_parent.add (l_class)
					end
					l_class.clear
					across l_resource.methods as m loop
							-- only doing methods right now ...
						if attached {CIL_METHOD} m as l_old then
								-- TODO double check, maybe we need a new creation procedure
								-- make_from_signature in the class CIL_METHOD_SIGNATURE
							l_m1 := l_old.prototype.twin
							l_m1.set_container (l_class)
							create l_nm.make (l_m1, l_old.flags, False)
							l_class.add (l_nm)
						end
					end
					Result := l_class
				end
			end
		end

feature -- Assembly

	working_assembly: CIL_ASSEMBLY_DEF
			-- Get the working assembly
			-- This is the one with your code and data, that gets written to the output
		do
			Result := assembly_refs.first
		end

	empty_working_assembly (a_assembly_name: STRING_32): CIL_ASSEMBLY_DEF
			-- 	Replace the working assembly with an empty one.
			--  Data is not deleted and still remains a part of the PELib instance.
		do
			create Result.make (a_assembly_name, False, Void)
			if attached assembly_refs.first as l_first then
				assembly_refs.prune (l_first)
				assembly_refs.put_i_th (Result, assembly_refs.lower)
			else
				assembly_refs.force (Result)
			end
		end

	mscorlib_assembly: CIL_ASSEMBLY_DEF
			-- loads the MSCorLib assembly.
		local
			l_result: CIL_ASSEMBLY_DEF
			l_system: CIL_NAMESPACE
			l_object, l_value, l_enum: CIL_CLASS
		do
				-- [mscorlib]System.ParamArrayAttribute
				-- System. + typeNames_[tp_]

			l_result := find_assembly ({STRING_32} "mscorlib")
			if l_result = Void then
				l_result := add_external_assembly ("mscorlib", Void)
				create l_system.make ({STRING_32} "System")
				l_result.add (l_system)
				create l_object.make ({STRING_32} "Object", create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), -1, -1)
				l_system.add (l_object)
				create l_value.make ({STRING_32} "ValueType", create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), -1, -1)
				l_value.set_extend_from (l_object)
				l_system.add (l_value)
				create l_enum.make ({STRING_32} "Enum", create {CIL_QUALIFIERS}.make_with_flags ({CIL_QUALIFIERS_ENUM}.public), -1, -1)
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
			--| in the already loaded set.
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
			--| Correspond to C++ method
			--| PELib::eFindType PELib::Find(std::string path, Resource **result,
			--|           std::deque<Type*>* generics = nullptr, AssemblyDef *assembly = nullptr);
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
			l_assembly := a_assembly
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
						elseif l_tuple.index = l_split.count - 1 and then -- TODO double check
							attached {CIL_CLASS} l_dc or else
							attached {CIL_ENUM} l_dc or else
							attached {CIL_ASSEMBLY_DEF} l_dc
						then
							across l_dc.fields as field loop
									-- TODO double check the index since C++ is 0 based.
								if field.name.same_string (l_split [l_tuple.index + 1]) then
									l_found_field.force (field)
								end
							end
							across l_dc.methods as cc loop
								if attached {CIL_METHOD} cc as l_method and then
									l_method.prototype.name.same_string (l_split [l_tuple.index + 1])
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

	find_method (a_path: STRING_32; a_args: LIST [CIL_TYPE]; a_rv: detachable CIL_TYPE; a_generics: detachable LIST [CIL_TYPE]; a_assembly: detachable CIL_ASSEMBLY_DEF; a_match_args: BOOLEAN): TUPLE [type: CIL_FIND_TYPE; res: detachable CIL_METHOD]
			-- find a method, with overload matching.
			--| Correspong to C++ method
			--|  PELib::eFindType PELib::Find(std::string path, Method **result, const std::vector<Type *>& args, Type* rv = nullptr,
			--|           std::deque<Type*>* generics = nullptr, AssemblyDef *assembly = nullptr, bool matchArgs = true);

		local
			l_npos: INTEGER
			l_assembly_name: STRING_32
			l_path: STRING_32
			l_assembly: CIL_ASSEMBLY_DEF
			l_split: LIST [STRING_32]
			l_found_method: LIST [CIL_METHOD]
			l_tuple: TUPLE [index: INTEGER; dc: detachable CIL_DATA_CONTAINER]
			l_method: CIL_METHOD
		do
			l_assembly := a_assembly
			create l_path.make_from_string (a_path)
			Result := [{CIL_FIND_TYPE}.s_notfound, Void]
			if not l_path.is_empty and l_path [1] = '[' then
				l_npos := l_path.index_of ('[', 1)
				if l_npos /= 0 then
					l_assembly_name := l_path.substring (1, l_npos - 1)
					l_path := l_path.substring (l_npos + 1, l_path.count)
					l_assembly := find_assembly (l_assembly_name)
				end
			end
			l_split := split_path (l_path)
			create {ARRAYED_LIST [CIL_METHOD]} l_found_method.make (0)

			across assembly_refs as a loop
				if not (attached a_assembly) or else
					attached a_assembly and then a_assembly.is_equal (a) then -- TODO check

					l_tuple := a.find_container_collection (l_split, a_generics, True)
					if attached l_tuple.dc as l_dc then
						if l_tuple.index = l_split.count - 1 and then -- TODO double check
							attached {CIL_CLASS} l_dc or else
							attached {CIL_ENUM} l_dc or else
							attached {CIL_ASSEMBLY_DEF} l_dc
						then
							across l_dc.methods as cc loop
								if attached {CIL_METHOD} cc as ll_method and then
									ll_method.prototype.name.same_string (l_split [l_tuple.index + 1])
								then
									l_found_method.force (ll_method)
								end
							end
						end
					end
				end
			end

			across using_list as u loop
				l_tuple := u.find_container_collection (l_split, a_generics, false)
				if attached l_tuple.dc as l_dc then
					if l_tuple.index = l_split.count - 1 and then
						(attached {CIL_CLASS} l_dc or else
							attached {CIL_ENUM} l_dc)
					then
						across l_dc.methods as cc loop
							if attached {CIL_METHOD} cc as ll_method and then
								ll_method.prototype.name.same_string (l_split [l_tuple.index + 1])
							then
								l_found_method.force (ll_method)
							end
						end
					end
				end
			end
				-- TODO review
			if a_match_args then
				across l_found_method as it loop
					if it.prototype.matches (a_args) or else attached a_rv as l_rv and
						not (attached a_rv as l_rv and then
								attached it.prototype.return_type as l_return_type and then
								it.prototype.matches_type (l_return_type, l_rv))
					then
						l_found_method.prune (it)
					end
				end
			end

			if l_found_method.count > 1 then
				across l_found_method as it loop
					if it.prototype.flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.vararg /= 0 then
						l_found_method.prune (it)
					end
				end
			end

			if l_found_method.is_empty then
				l_method := find_pinvoke (l_path)
				if attached l_method then
					Result.res := l_method
					Result.type := {CIL_FIND_TYPE}.s_method
				else
					Result.type := {CIL_FIND_TYPE}.s_notfound
				end
			elseif l_found_method.count > 1 then
				Result.type := {CIL_FIND_TYPE}.s_ambiguous
			else
				Result.res := l_found_method [1]
				Result.type := {CIL_FIND_TYPE}.s_method
			end
		end

	set_lib_path (a_paths: STRING_32)
			-- Set the paths where assemblies are looked for. More than one path can be separated by ';'.
		do
			lib_path := a_paths
		ensure
			lib_path_set: lib_path = a_paths
		end

feature -- Element Change

	add_using (a_path: STRING_32): BOOLEAN
			-- add to the search path, returns true if it finds a namespace at `a_path`.
			-- in any assembly.
		local
			l_split: LIST [STRING_32]
			l_res: TUPLE [index: INTEGER; dc: detachable CIL_DATA_CONTAINER]
		do
			l_split := split_path (a_path)
			across assembly_refs as elem loop
				l_res := elem.find_container_collection (l_split, Void, False)
				if l_res.index = l_split.count and then attached {CIL_NAMESPACE} l_res.dc as l_namespace then
					using_list.force (l_namespace)
					Result := True
				end
			end
		end

feature {ANY} -- Implementation

	split_path (a_path: STRING_32): LIST [STRING_32]
		local
			l_last: STRING_32
			l_path: STRING_32
			n: INTEGER_32
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
						Result [Result.count - 1] := {STRING_32} "." + Result [Result.count]
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
			l_module_index: NATURAL_64
			l_type_def: PE_TYPEDEF_OR_REF
			l_table: PE_TABLE_ENTRY_BASE
			l_n: NATURAL_64
			l_base_types: CELL [INTEGER]
			l_system_index: NATURAL_64
			l_object_index: NATURAL_64
			l_value_index: NATURAL_64
			l_enum_index: NATURAL_64
			l_mscorlib_assembly: CIL_ASSEMBLY_DEF
			l_assembly_index: NATURAL_64
			l_rs: PE_RESOLUTION_SCOPE
			l_result: TUPLE [type: CIL_FIND_TYPE; resource: detachable ANY]
			l_pos: INTEGER
			l_file_name: STRING_32
			l_name_index: NATURAL_64
			l_guid_index: NATURAL_64
		do

			if attached output_stream as l_stream then
				n := 1
					-- Give initial PE Indexes for field resolution..
				n := working_assembly.number (n)

				create l_pe_writer.make (a_is_exe, a_is_gui, working_assembly.snk_file)

					-- RK: Unhandled Exception on Mono 3 and 5:
					-- System.TypeLoadException: Could not load type 'Module' from assembly 'test6, Version=0.0.0.0, Culture=neutral,
					-- PublicKeyToken=null'.
					-- [ERROR] FATAL UNHANDLED EXCEPTION: System.TypeLoadException: Could not load type 'Module' from assembly 'test6,
					-- Version=0.0.0.0, Culture=neutral, PublicKeyToken=null'.

				l_module_index := l_pe_writer.hash_string ({STRING_32} "<Module>")
					-- RK fix: "<Module>" instead of "Module" fixes the issue

				create l_type_def.make_with_tag_and_index ({PE_TYPEDEF_OR_REF}.typedef, 0)

				create {PE_TYPEDEF_TABLE_ENTRY} l_table.make_with_data (0, l_module_index, 0, l_type_def, 1, 1)
				l_n := l_pe_writer.add_table_entry (l_table)

				create l_base_types.put (0)
				working_assembly.base_types (l_base_types)
				if l_base_types.item /= 0 then
					if attached mscorlib_assembly then end
				end

				if l_base_types.item /= 0 then
					l_system_index := l_pe_writer.hash_string ("System")
					if l_base_types.item & {CIL_DATA_CONTAINER}.base_type_object /= 0 then
						l_object_index := l_pe_writer.hash_string ("Object")
					end
					if l_base_types.item & {CIL_DATA_CONTAINER}.base_type_value /= 0 then
						l_value_index := l_pe_writer.hash_string ("ValueType")
					end
					if l_base_types.item & {CIL_DATA_CONTAINER}.base_type_enum /= 0 then
						l_enum_index := l_pe_writer.hash_string ("Enum")
					end
				end

				l_stream.set_stream (l_pe_writer, Current)

				across assembly_refs as assembly loop
					Result := assembly.pe_header_dump (l_stream)
				end

				if l_base_types.item /= 0 then
					l_mscorlib_assembly := mscorlib_assembly
					l_assembly_index := l_mscorlib_assembly.pe_index
					create l_rs.make_with_tag_and_index ({PE_RESOLUTION_SCOPE}.AssemblyRef, l_assembly_index)
					if l_base_types.item & {CIL_DATA_CONTAINER}.base_type_object /= 0 then
						create {PE_TYPE_REF_TABLE_ENTRY} l_table.make_with_data (l_rs, l_object_index, l_system_index)
						l_object_index := l_pe_writer.add_table_entry (l_table)
						l_result := find ("[mscorlib]System::Object", Void, Void)
						if attached {CIL_CLASS} l_result.resource as l_resource then
							l_resource.set_peindex (l_object_index)
						end
					end
					if l_base_types.item & {CIL_DATA_CONTAINER}.base_type_value /= 0 then
						create {PE_TYPE_REF_TABLE_ENTRY} l_table.make_with_data (l_rs, l_value_index, l_system_index)
						l_value_index := l_pe_writer.add_table_entry (l_table)
						l_result := find ("[mscorlib]System::ValueType", Void, Void)
						if attached {CIL_CLASS} l_result.resource as l_resource then
							l_resource.set_peindex (l_value_index)
						end
					end
					if l_base_types.item & {CIL_DATA_CONTAINER}.base_type_enum /= 0 then
						create {PE_TYPE_REF_TABLE_ENTRY} l_table.make_with_data (l_rs, l_enum_index, l_system_index)
						l_enum_index := l_pe_writer.add_table_entry (l_table)
						l_result := find ("[mscorlib]System::ValueType", Void, Void)
						if attached {CIL_CLASS} l_result.resource as l_resource then
							l_resource.set_peindex (l_enum_index)
						end
					end
					l_pe_writer.set_base_classes (l_object_index, l_value_index, l_enum_index, l_system_index)
				end
					-- TODO double check
				create l_file_name.make_from_string (a_file_name)
				l_pos := a_file_name.last_index_of ('\', l_file_name.count)
				if l_pos /= 0 and then l_pos /= a_file_name.count then
					l_file_name := l_file_name.substring (1, l_pos)
				end
				l_name_index := l_pe_writer.hash_string (l_file_name)
				l_pe_writer.create_guid (module_guid)
				l_guid_index := l_pe_writer.hash_guid (module_guid)

				create {PE_MODULE_TABLE_ENTRY} l_table.make_with_data (l_name_index, l_guid_index)
				l_n := l_pe_writer.add_table_entry (l_table)

				across p_invoke_signatures as signature loop
					Result := signature.pe_dump (l_stream)
				end

				Result := working_assembly.pe_dump (l_stream)
				working_assembly.compile (l_stream)
				Result := l_pe_writer.write_file (core_flags, l_stream)
			end
		end

	obj_out: BOOLEAN
		do
			to_implement ("Add Implementation")
		end

end
