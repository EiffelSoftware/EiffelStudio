note
	description: "[
				 The signature for a method, has a return type and a list of params.  Params can be either named or unnamed
			     If the signature is not managed it is PINVOKE
			     There are two types of vararg protocols supported.
			     When performing a PINVOKE, the native CIL vararg mechanism is used because that is how things are marshalled.
			     But if varars are used in the arguments to a managed function, the argument list will end with
			     an argument which is an szarray of objects.  It will be tagged appropriately so that other .Net assemblies e.g. 
			     C# programs know how to use it as a param list, including the ability to specify an arbitrary number of params.
			     When these are passed about in a program you generate you may need to box
			     simple values to fit them in the array...
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_METHOD_SIGNATURE

inherit

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_32; a_flags: INTEGER; a_container: detachable CIL_DATA_CONTAINER)
		do
			container := a_container
			name := a_name
			flags := a_flags
			create display_name.make_empty
			create {ARRAYED_LIST [CIL_PARAM]} params.make (0)
			create {ARRAYED_LIST [CIL_PARAM]} vararg_params.make (0)
			create {ARRAYED_LIST [CIL_TYPE]} generic.make (0)
			create display_name.make_empty
		ensure
			container_set: attached container as l_container implies l_container = a_container
			name_set: name = a_name
			flags_set: flags = a_flags
			return_type_void: return_type = Void
			ref_set: not ref
			pe_index_set: pe_index = 0
			pe_index_call_site_set: pe_index_call_site = 0
			method_parent_void: method_parent = Void
			array_object_void: array_object = Void
			external_set: not is_external
			definitions_set: definitions = 0
			generic_parent_void: generic_parent = Void
			generic_param_count_set: generic_param_count = 0
			params_empty: params.is_empty
			vararg_params_empty: vararg_params.is_empty
			generic_empty: generic.is_empty
			display_name_empty: display_name.is_empty
		end

	internal_definitions: NATURAL
			-- definition count
feature -- Access

	method_parent: detachable CIL_METHOD_SIGNATURE
			-- the parent declaration for a call site signature with vararg
			--  params (the method_def version of the signature)

	container: detachable CIL_DATA_CONTAINER
			-- The data container.

	return_type: detachable CIL_TYPE
			-- return type.

	array_object: detachable CIL_TYPE
			-- The array object.

	name: STRING_32
			-- The name.

	display_name: STRING_32

	flags: INTEGER
			-- qualifiers.

	params: LIST [CIL_PARAM]

	vararg_params: LIST [CIL_PARAM]
			-- vararg parameters.

	ref: BOOLEAN
			-- is ref?

	pe_index: NATURAL_64

	pe_index_call_site: NATURAL_64

	pe_index_type: NATURAL_64

	is_external: BOOLEAN
			-- not locally defined.

	generic: LIST [CIL_TYPE]
			-- The lists of generics.

	generic_parent: detachable CIL_METHOD_SIGNATURE

	generic_param_count: INTEGER

	definitions: NATURAL
			-- Return definitions count.
		do
			Result := internal_definitions // 2;
		end

feature -- Element change

	increment_definitions
			-- Increment definitions count.
		do
			internal_definitions := internal_definitions + 1
		ensure
			definitions_incremented: old internal_definitions + 1 = internal_definitions
		end

	set_return_type (a_type: like return_type)
			-- Set `return_type` with `a_type`.
		do
			return_type := a_type
		ensure
			return_type_set: return_type = a_type
		end

	add_parameter (a_param: CIL_PARAM)
			-- Add a parameter `param` to the list of `params`.
		do
			if vararg_params.count > 0 then
					-- TODO add PELIB_ERROR class.
				{EXCEPTIONS}.raise ("VarargParamsAlreadyDeclared")
			end
			a_param.set_index (params.count)
			params.force (a_param)
		end

	add_vararg_param (a_param: CIL_PARAM)
			--  Add a vararg parameter `a_param`.
			--| These are NATIVE vararg parameters not
			--| C# ones.
			--| They are only added to signatures at a call site...
			--| Note: Call site I.12.4.1.1 Call site descriptors
		do
			a_param.set_index (params.count + vararg_params.count)
			vararg_params.force (a_param)
		end

	set_instance (a_instance: BOOLEAN)
			-- Make it an instance member.
		do
			if a_instance then
				flags := flags | {CIL_METHOD_SIGNATURE_ATTRIBUTES}.instance_flag
			else
				flags := flags & ({CIL_METHOD_SIGNATURE_ATTRIBUTES}.instance_flag.bit_not)
			end
		end

	signature_parent (a_parent: CIL_METHOD_SIGNATURE)
			-- the parent declaration `a_parent` for a call site signature with vararg
			-- params (the methoddef version of the signature)
		do
			method_parent := a_parent
		ensure
			method_parent_set: attached method_parent as l_method_parent implies l_method_parent = a_parent
		end

	set_container (a_container: like container)
			-- Set `container` with `a_container`
		do
			container := a_container
		ensure
			container_set: container = a_container
		end

	set_name (a_name: STRING_32)
			-- Set `name` with `a_name`.
		do
			name := a_name
		ensure
			name_set: name = a_name
		end

	set_array_object (a_type: like array_object)
			-- Set `array_object` with `a_type`
		do
			array_object := a_type
		ensure
			array_object_set: array_object = a_type
		end

	set_generic_parent (a_sig: like generic_parent)
			-- Set `generic_parent` with `a_sig`
		do
			generic_parent := a_sig
		ensure
			generic_parent_set: generic_parent = a_sig
		end

	set_vararg_flag
			-- Make it a vararg signature.
		do
			flags := flags | {CIL_METHOD_SIGNATURE_ATTRIBUTES}.vararg
		end

	set_pe_index (a_index: like pe_index)
			-- Set `pe_index` to `a_index`.
		do
			pe_index := a_index
		ensure
			pe_index_set: pe_index = a_index
		end

	set_is_external (a_val: BOOLEAN)
			-- Set `is_external` with `a_val`.
		do
			is_external := a_val
		ensure
			is_external_set: is_external = a_val
		end

	set_ref (a_val: BOOLEAN)
			-- Set `ref` with `a_val`.
		do
			ref := a_val
		ensure
			ref_set: ref = a_val
		end

	set_generic_param_count (a_count: INTEGER)
			-- Set `generic_param_count` with `a_count`
		do
			generic_param_count := a_count
		ensure
			generic_param_count_set: generic_param_count = a_count
		end

feature -- Status Report

	param_count: NATURAL_64
			-- Return parameter count.
		do
			Result := params.count.to_natural_64
		end

	vararg_param_count: NATURAL_64
		do
			Result := vararg_params.count.to_natural_64
		end

	instance: BOOLEAN
			-- Is an instance member?
		do
			Result := not not (flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.instance_flag /= 0)
		end

	get_param (i: INTEGER; by_ordinal: BOOLEAN): CIL_PARAM
			-- Get a parameter.
		require
			valid_index: i > 0 and then i <= params.count
		do
			Result := params [i]
-- TODO check
--			if by_ordinal then
--				Result := params.at (i)
--			else
--				across params as ic until found loop
--					if ic.index = i then
--						found := True
--						Result := ic
--					end
--				end
--			end
		end

	matches_type (a_type: CIL_TYPE; a_other: CIL_TYPE): BOOLEAN
		local
			done: BOOLEAN
		do
			if a_other.basic_type = {CIL_BASIC_TYPE}.type_var then
					-- nothing to do, it matches.
			elseif a_other.basic_type = {CIL_BASIC_TYPE}.method_param then
					-- nothing to do, it matches.
			elseif a_type.basic_type = a_other.basic_type then

					--  this may need to deal with boxed types a little better
				if a_type.basic_type = {CIL_BASIC_TYPE}.class_ref and then
					a_type.type_ref /= a_other.type_ref -- TODO check how to compare DATA_CONTAINER.
				then
					done := True
					Result := False
				end
			else
				done := True
				Result := False
			end
			if not done then
				if (a_type.pointer_level /= a_other.pointer_level and then
						a_other.pointer_level /= 1 and then a_other.basic_type /= {CIL_BASIC_TYPE}.Void_) or else
					(a_type.array_level /= a_other.array_level)
				then
					Result := False
				else
					Result := True
				end

			end
		end

	matches (a_args: LIST [CIL_TYPE]): BOOLEAN
		local
			l_tpa: CIL_TYPE
			l_tpb: CIL_TYPE
			l_exit: BOOLEAN
			l_count: INTEGER
		do

			l_count := a_args.count
				-- this is only designed for managed functions ...
			if a_args.count = params.count or else
				(params.count > 0 and then a_args.count >= params.count - 1 and then
					flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.vararg /= 0)
			then
				across 1 |..| l_count as ic until l_exit loop

						-- TODO double check this implementation.
					if attached params.at (ic).type as l_type then
						l_tpb := l_type
						l_tpa := a_args [ic]

						if not matches_type (l_tpa, l_tpb) then
							l_exit := True
							Result := False
						end
					else
						l_exit := True
						Result := False
					end
				end
				if not l_exit then
					Result := True
				end
			else
				Result := False
			end
		end

feature -- Output

	il_src_dump (a_file: FILE_STREAM; a_names: BOOLEAN; a_type: BOOLEAN; a_pinvoke: BOOLEAN): BOOLEAN
		do
				-- this usage of vararg is for C style varargs
				-- occil uses C# style varags except in pinvoke and generates
				-- the associated object array argument
			if ((flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.vararg) /= 0) and then
				not ((flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed) /= 0)
			then
				a_file.put_string ("vararg ")
			end
			if (flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.instance_flag) /= 0 then
				a_file.put_string ("instance ")
			end
			if attached return_type as l_ret_type and then
				l_ret_type.basic_type = {CIL_BASIC_TYPE}.class_ref
			then
				if attached l_ret_type.type_ref as l_type_ref and then (l_type_ref.flags.flags & {CIL_QUALIFIERS_ENUM}.value) /= 0 then
					a_file.put_string ("valuetype ")
				else
					a_file.put_string ("class ")
				end
			end
			if attached return_type as l_ret_type then
				Result := l_ret_Type.il_src_dump (a_file)
			end
			a_file.put_string (" ")
			if a_type then
				a_file.put_string (" *")
			elseif not name.is_empty then
				if attached array_object as l_array_obj then
					Result := l_array_obj.il_src_dump (a_file)
					a_file.put_string ("::'")
					a_file.put_string (name)
					a_file.put_string ("'")
				elseif a_names then
					a_file.put_string ("'")
					a_file.put_string (name)
					a_file.put_string ("'")
				else
					if attached {CIL_CLASS} container as l_container and then
						not l_container.generics.is_empty
					then
						if (l_container.flags.flags & {CIL_QUALIFIERS_ENUM}.value) /= 0 then
							a_file.put_string ("valuetype ")
						else
							a_file.put_string ("class ")
						end
							-- TODO implement {CIL_QUALIFIERS}.name
						a_file.put_string ({CIL_QUALIFIERS}.name ("", l_container, False))
						a_file.put_string (l_container.adorn_generics (False))
					else
							-- TODO implement {CIL_QUALIFIERS}.name
						a_file.put_string ({CIL_QUALIFIERS}.name (name, container, False))
					end
				end
			end

			a_file.put_string (adorn_generics (a_file, false))
			a_file.put_string ("(")
			across params as it loop
				if attached {CIL_TYPE} it.type as l_type and then l_type.basic_type = {CIL_BASIC_TYPE}.class_ref then
					if attached l_type.type_ref as l_type_ref and then
						(l_type_ref.flags.flags & {CIL_QUALIFIERS_ENUM}.value) /= 0 then
						a_file.put_string ("valuetype ")
					else
						a_file.put_string ("class ")
					end
				end
				if attached {CIL_TYPE} it.type as l_type then
					Result := l_type.il_src_dump (a_file)
					if a_names and then l_type.basic_type /= {CIL_BASIC_TYPE}.type_var and then
						l_type.basic_type /= {CIL_BASIC_TYPE}.method_param
					then
						Result := it.il_src_dump (a_file)
					end
					if @ it.target_index + 1 < @ it.last_index then
						a_file.put_string (", ")
					end
				end
			end
			if not a_pinvoke and then (flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.vararg /= 0) then
				if not ((flags & {CIL_QUALIFIERS_ENUM}.managed) /= 0) then
					a_file.put_string (", ...")
					if not vararg_params.is_empty then
						a_file.put_string (", ")
						across vararg_params as it loop
							if attached {CIL_TYPE} it.type as l_type then
								Result := l_type.il_src_dump (a_file)
							end
							if @ it.target_index + 1 < @ it.last_index then
								a_file.put_string (", ")
							end
						end
					end
				end
			end
			a_file.put_string (")")
			Result := True
		end

	il_signature_dump (a_stream: FILE_STREAM)
		local
			l_result: BOOLEAN
		do
			if attached return_type as l_return_type then
				l_result := l_return_type.il_src_dump (a_stream)
			end
			a_stream.put_string (" ")
			if attached {CIL_CLASS} container as l_class and then
				not l_class.generics.is_empty
			then
				if l_class.flags.flags & {CIL_QUALIFIERS_ENUM}.value /= 0 then
					a_stream.put_string ("valuetype ")
				else
					a_stream.put_string ("class ")
				end
				a_stream.put_string ({CIL_QUALIFIERS}.name ({STRING_32} "", container, False))
				a_stream.put_string (l_class.adorn_generics (false))
				a_stream.put_string ("::'")
				a_stream.put_string (name)
				a_stream.put_string ("'(") -- double check
			else
				a_stream.put_string ({CIL_QUALIFIERS}.name (name, container, False))
			end
			a_stream.put_string ("(")
			across params as param loop
				if attached {CIL_TYPE} param.type as l_type and then
					attached {CIL_DATA_CONTAINER} l_type.type_ref as l_class and then
					l_class.flags.flags & {CIL_QUALIFIERS_ENUM}.value /= 0
				then
					a_stream.put_string ("valuetype ")
				else
					a_stream.put_string ("class ")
				end
				if attached {CIL_TYPE} param.type as l_type then
					l_result := l_type.il_src_dump (a_stream)
				end
				if @ param.target_index + 1 < @ param.last_index then
					a_stream.put_string (", ")
				end
			end
			a_stream.put_string (")")
		end

	pe_dump (a_stream: FILE_STREAM; as_type: BOOLEAN): BOOLEAN
		local
			l_sz: CELL [NATURAL_64]
			l_sig: ARRAY [NATURAL_8]
			l_method_signature: NATURAL_64
			l_method_ref: PE_METHOD_DEF_OR_REF
			l_table: PE_TABLE_ENTRY_BASE
			l_function: NATURAL_64
			l_cls: CIL_CLASS
			l_member_ref: PE_MEMBER_REF_PARENT
			l_parent_index: NATURAL_64
			l_method_ref_type: INTEGER
			l_buf: SPECIAL [NATURAL_8]
			l_dis: NATURAL_64
			l_parent: NATURAL_64
			l_exit: BOOLEAN
		do
			if attached container as l_container and then l_container.in_assembly_ref then
				if pe_index_call_site = 0 then
					Result := l_container.pe_dump (a_stream)
					if attached return_type as l_return_type and then l_return_type.basic_type = {CIL_BASIC_TYPE}.class_ref then
						if attached {CIL_DATA_CONTAINER} l_return_type.type_ref as l_class and then l_class.in_assembly_ref then
							Result := l_class.pe_dump (a_stream)
						end
					end
					if attached return_type as l_return_type and then attached {CIL_TYPE} l_return_type.mod_opt as l_mod_opt and then
						l_mod_opt.basic_type = {CIL_BASIC_TYPE}.class_ref then
						if attached {CIL_DATA_CONTAINER} l_mod_opt.type_ref as l_class and then l_class.in_assembly_ref then
							Result := l_class.pe_dump (a_stream)
						end
					end

					across params as param loop

						if attached {CIL_TYPE} param.type as l_type and then l_type.basic_type = {CIL_BASIC_TYPE}.class_ref then
								-- NOTE: original called PEDump unconditionally, which leads to
								-- rendering of the same class and its methods more than once!
								-- If this is not called at all, not all referenced classes are considered
								-- in the meta tables, e.g. Display.FrameMsg in System.Recall, which is only used as param type.
								-- This lead to nil tokens in typerefs and assemblies which are only read up to this token by Mono!
							if attached {CIL_CLASS} l_type.type_ref as l_class and then l_class.in_assembly_ref and then l_class.pe_index = 0 then
								Result := l_class.pe_dump (a_stream)
							end
						end
					end
					create l_sz.put (0)
					if not generic.is_empty then
						if attached generic_parent as l_generic_parent then
							Result := l_generic_parent.pe_dump (a_stream, False)
							l_sig :=  {PE_SIGNATURE_GENERATOR_HELPER}.method_spec_sig (Current, l_sz)
								-- TODO what to do if pe_writer is Void
							if attached {PE_WRITER} a_stream.pe_writer as l_writer  then
								l_method_signature := l_writer.hash_blob (l_sig, l_sz.item)
								create l_method_ref.make_with_tag_and_index ({PE_METHOD_DEF_OR_REF}.memberref,
									if attached generic_parent as ll_generic_parent then ll_generic_parent.pe_index_call_site else {NATURAL_64}0 end)
								create {PE_METHOD_SPEC_TABLE_ENTRY} l_table.make_with_data (l_method_ref, l_method_signature)
								pe_index_call_site := l_writer.add_table_entry (l_table)
							end
						end
					else
						if attached {PE_WRITER} a_stream.pe_writer as l_writer then
							l_function := l_writer.hash_string (name)
						end
						if attached {CIL_CLASS} container as l_class then
							l_cls := l_class
						end
						l_sig := {PE_SIGNATURE_GENERATOR_HELPER}.method_ref_sig (Current, l_sz)
						if attached {PE_WRITER} a_stream.pe_writer as l_writer then
							l_method_signature := l_writer.hash_blob (l_sig, l_sz.item)
						end
						if attached l_cls then
							create l_member_ref.make_with_tag_and_index (
								if not l_cls.generics.is_empty then {PE_MEMBER_REF_PARENT}.typespec else {PE_MEMBER_REF_PARENT}.typeref end,
								if attached container as ll_container then ll_container.pe_index		else {NATURAL_64}0 end)

						else
							create l_member_ref.make_with_tag_and_index (
													0,
													if attached container as ll_container then ll_container.pe_index else {NATURAL_64}0 end)

						end
						create {PE_MEMBER_REF_TABLE_ENTRY} l_table.make_with_data (l_member_ref, l_function, l_method_signature)
						if attached {PE_WRITER} a_stream.pe_writer as l_writer then
							pe_index_call_site := l_writer.add_table_entry (l_table)
						end
					end
				end
			elseif as_type then
				if pe_index_type /= 0 then
					create l_sz.put (0)
					l_sig := {PE_SIGNATURE_GENERATOR_HELPER}.method_ref_sig (Current, l_sz)
					if attached {PE_WRITER} a_stream.pe_writer as l_writer then
						l_method_signature := l_writer.hash_blob (l_sig, l_sz.item)
						create {PE_STANDALONE_SIG_TABLE_ENTRY} l_table.make_with_data (l_method_signature)
						pe_index_type := l_writer.add_table_entry (l_table)
					end
				end
			elseif (flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.vararg /= 0) and then
				not (flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.managed /= 0) then
					create l_sz.put (0)
					if attached {PE_WRITER} a_stream.pe_writer as l_write then
						l_function := l_write.hash_string (name)
						l_parent_index := if attached method_parent as l_method_parent then l_method_parent.pe_index_type else {NATURAL_64}0 end
						l_sig := {PE_SIGNATURE_GENERATOR_HELPER}.method_ref_sig (Current, l_sz)
						l_method_signature := l_write.hash_blob (l_sig, l_sz.item)
						pe_index_call_site := l_write.add_table_entry (
														create {PE_MEMBER_REF_TABLE_ENTRY}.make_with_data
																	(create {PE_MEMBER_REF_PARENT}.make_with_tag_and_index ({PE_MEMBER_REF_PARENT}.methoddef, l_parent_index)
																	, l_function, l_method_signature))

					end
			elseif pe_index_call_site = 0 then
				l_method_ref_type := {PE_MEMBER_REF_PARENT}.typeref
				create l_sz.put (0)
				if attached {PE_WRITER} a_stream.pe_writer as l_writer then
					 l_function := l_writer.hash_string (name)
					 if attached return_type as l_return_type and then
					 	l_return_type.basic_type = {CIL_BASIC_TYPE}.class_ref
					 then
					 	if attached l_return_type.type_ref as l_class and then l_class.in_assembly_ref then
					 		Result := l_class.pe_dump (a_stream)
					 	end
					 end
					 if attached {CIL_TYPE} return_type as l_return_type and then attached {CIL_TYPE} l_return_type.mod_opt as l_mod_opt and then
					 	l_mod_opt.basic_type = {CIL_BASIC_TYPE}.class_ref
					 then
					 	if attached l_mod_opt.type_ref as l_class and then l_class.in_assembly_ref then
					 		Result := l_class.pe_dump (a_stream)
					 	end
					 end
					 if attached {CIL_TYPE} array_object as l_array_object then
					 	l_method_ref_type := {PE_MEMBER_REF_PARENT}.TypeSpec
						create l_buf.make_filled (0, 16)
						-- TODO double check offset
						l_dis :=  l_array_object.render (a_stream, l_buf, 0)
						l_parent := l_array_object.pe_index
					 elseif attached {CIL_DATA_CONTAINER} container as l_container then
					     if l_container.pe_index = 0 then
							Result := l_container.pe_dump (a_stream)
					     end
					     l_parent := l_container.pe_index
					     if attached {CIL_CLASS} container as l_class then
					     	if not l_class.generics.is_empty and then
					     		l_class.generics.first.basic_type /= {CIL_BASIC_TYPE}.type_var then
					     			l_method_ref_type := {PE_MEMBER_REF_PARENT}.typespec
					     	end
					     end
					 else
					 	l_exit := True
					 	Result := False
					 end
					if not l_exit then
						create l_member_ref.make_with_tag_and_index (l_method_ref_type, l_parent)
						l_sig := {PE_SIGNATURE_GENERATOR_HELPER}.method_def_sig (Current, l_sz)
						l_method_signature := l_writer.hash_blob (l_sig, l_sz.item)
						create {PE_MEMBER_REF_TABLE_ENTRY}l_table.make_with_data (l_member_ref, l_function, l_method_signature)
						pe_index_call_site := l_writer.add_table_entry (l_table)
					end
	 			end
			end
			Result := True
		end

	adorn_generics (a_stream: FILE_STREAM; a_names: BOOLEAN): STRING_32
		local
			l_type: CIL_TYPE
			l_file: FILE_STREAM
			bool: BOOLEAN
		do
			create l_file.make_temp
			create Result.make_empty
			if not generic.is_empty then
				Result.append ("<")
				across generic as it loop
					if a_names and then it.basic_type = {CIL_BASIC_TYPE}.type_var then
						Result.append_character ('A' + (it.var_num // 26))
						Result.append_character ('A' + (it.var_num \\ 26))
					else
						l_type := it
						l_type.show_type := True
						bool := l_type.il_src_dump (l_file)
					end
					if @ it.target_index + 1 /= @ it.last_index then
						l_file.put_string (",")
					else
						l_file.put_string (">")
					end
				end
			end
			Result := l_file.text
			l_file.close
		end

end
