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
	METHOD_SIGNATURE

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_32; a_flags: INTEGER; a_container: detachable DATA_CONTAINER)
		do
			container := a_container
			name := a_name
			flags := a_flags
			create display_name.make_empty
			create {ARRAYED_LIST[PARAM]} params.make(0)
			create {ARRAYED_LIST[PARAM]} vararg_params.make(0)
			create {ARRAYED_LIST[CLS_TYPE]} generic.make (0)
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
			generic_empty : generic.is_empty
			display_name_empty: display_name.is_empty
		end

	internal_definitions: NATURAL
			-- definition count
feature -- Access

	method_parent: detachable METHOD_SIGNATURE
		-- the parent declaration for a call site signature with vararg
        --  params (the method_def version of the signature)

	container: detachable DATA_CONTAINER
		-- The data container.

	return_type: detachable CLS_TYPE
		-- return type.

	array_object: detachable CLS_TYPE
		-- The array object.

	name: STRING_32
		-- The name.

	display_name: STRING_32

	flags: INTEGER
		-- qualifiers.

	params: LIST [PARAM]

	vararg_params: LIST [PARAM]
			-- vararg parameters.

	ref: BOOLEAN
		-- is ref?

	pe_index: NATURAL

	pe_index_call_site: NATURAL

	pe_index_type: NATURAL

	is_external: BOOLEAN
		-- not locally defined.

	generic: LIST [CLS_TYPE]
		-- The lists of generics.

	generic_parent: detachable METHOD_SIGNATURE

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

	set_return_type (a_type: CLS_TYPE)
			-- Set `return_type` with `a_type`.	
		do
			return_type := a_type
		ensure
			attached return_type as l_type and then l_type = a_type
		end

	add_parameter (a_param: PARAM)
			-- Add a parameter `param` to the list of `params`.
		do
			if vararg_params.count > 0 then
					-- TODO add PELIB_ERROR class.
				{EXCEPTIONS}.raise ("VarargParamsAlreadyDeclared")
			end
			a_param.set_index (params.count)
			params.force (a_param)
		end

	add_vararg_param (a_param: PARAM)
			--  Add a vararg parameter `a_param`.
			--| These are NATIVE vararg parameters not
			--| C# ones.
			--| They are only added to signatures at a call site...
			--| Note: Call site I.12.4.1.1 Call site descriptors
		do
			a_param.set_index (params.count + vararg_params.count)
			vararg_params.force (a_param)
		end

	instance (a_instance: BOOLEAN)
			-- Make it an instance member.
		do
			if a_instance then
				flags := flags | {METHOD_SIGNATURE_ATTRIBUTES}.instance_flag
			else
				flags := flags & ({METHOD_SIGNATURE_ATTRIBUTES}.instance_flag.bit_not)
			end
		end

	signature_parent (a_parent: METHOD_SIGNATURE)
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
			array_object_set:  array_object = a_type
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
			flags := flags | {METHOD_SIGNATURE_ATTRIBUTES}.vararg
		end

	set_pe_index (a_index: like pe_index)
			-- Set `pe_index` to `a_index`.
		do
			pe_index := a_index
		ensure
			pe_index_set: pe_index = a_index
		end

feature -- Status Report

	get_param (i: INTEGER; by_ordinal: BOOLEAN): PARAM
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

	matches_type (a_type: CLS_TYPE; a_other: CLS_TYPE): BOOLEAN
		local
			done: BOOLEAN
		do
			if a_other.basic_type = {BASIC_TYPE}.type_var then
				-- nothing to do, it matches.
			elseif  a_other.basic_type = {BASIC_TYPE}.method_param then
				-- nothing to do, it matches.
			elseif a_type.basic_type = a_other.basic_type then

					--  this may need to deal with boxed types a little better
				if a_type.basic_type = {BASIC_TYPE}.class_ref and then
				  a_type.type_ref /= a_other.type_ref  -- TODO check how to compare DATA_CONTAINER.
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
				    a_other.pointer_level /= 1 and then a_other.basic_type /= {BASIC_TYPE}.Void_) or else
				    (a_type.array_level /= a_other.array_level)
				then
					Result := False
				else
					Result := True
				end

			end
		end

	matches (a_args: LIST [CLS_TYPE]): BOOLEAN
		local
			l_tpa: CLS_TYPE
			l_tpb: CLS_TYPE
			l_exit: BOOLEAN
			l_count: INTEGER
		do

			l_count := a_args.count
				-- this is only designed for managed functions ...
			if a_args.count = params.count or else
				( params.count > 0 and then a_args.count >= params.count -1 and then
				flags & {METHOD_SIGNATURE_ATTRIBUTES}.vararg /= 0)
			then
				across 1 |..| l_count  as ic  until l_exit loop

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
    		if ((flags & {METHOD_SIGNATURE_ATTRIBUTES}.vararg) /= 0) and then
    			not ((flags & {METHOD_SIGNATURE_ATTRIBUTES}.managed) /= 0)
    		then
    			a_file.put_string ("vararg ")
    		end
    		if (flags & {METHOD_SIGNATURE_ATTRIBUTES}.instance_flag) /= 0 then
    			a_file.put_string ("instance ")
    		end
    		if attached return_type as l_ret_type and then
    			l_ret_type.basic_type = {BASIC_TYPE}.class_ref
    		then
    			if attached l_ret_type.type_ref as l_type_ref and then (l_type_ref.flags.flags & {QUALIFIERS_ENUM}.value) /= 0  then
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
					if attached {CLS_CLASS} container as l_container and then
						not l_container.generics.is_empty
					then
						if (l_container.flags.flags & {QUALIFIERS_ENUM}.value) /= 0 then
							a_file.put_string ("valuetype ")
						else
							a_file.put_string ("class ")
						end
							-- TODO implement {QUALIFIERS}.name
						a_file.put_string ({QUALIFIERS}.name ("", l_container, False))
						a_file.put_string (l_container.adorn_generics (False))
					else
						-- TODO implement {QUALIFIERS}.name
						a_file.put_string ({QUALIFIERS}.name (name, container, False))
					end
				end
			end

			a_file.put_string (adorn_generics(a_file, false))
			a_file.put_string ("(")
			across params as it loop
				if attached {CLS_TYPE} it.type as l_type and then  l_type.basic_type = {BASIC_TYPE}.class_ref then
					if attached l_type.type_ref as l_type_ref and then
						(l_type_ref.flags.flags & {QUALIFIERS_ENUM}.value) /= 0 then
						a_file.put_string ("valuetype ")
					else
						a_file.put_string ("class ")
					end
				end
				if attached {CLS_TYPE} it.type as l_type  then
					Result := l_type.il_src_dump (a_file)
					if a_names and then l_type.basic_type /= {BASIC_TYPE}.type_var and then
						l_type.basic_type /= {BASIC_TYPE}.method_param
					then
						Result := it.il_src_dump (a_file)
					end
					if @ it.target_index + 1 < @ it.last_index then
						a_file.put_string (", ")
					end
				end
			end
			if not a_pinvoke and then (flags & {METHOD_SIGNATURE_ATTRIBUTES}.vararg /= 0) then
				if not ((flags & {QUALIFIERS_ENUM}.managed) /= 0) then
					a_file.put_string (", ...")
					if not vararg_params.is_empty then
						a_file.put_string (", ")
						across vararg_params as it loop
							if attached {CLS_TYPE} it.type as l_type then
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

	il_signature_dump (a_file: FILE_STREAM)
		do
			-- TODO implement.
		end


	pe_dump (a_stream: FILE_STREAM; as_type: BOOLEAN)
		do
			--TODO implement
		end

	adorn_generics(a_stream: FILE_STREAM; a_names: BOOLEAN): STRING_32
		do
			--TODO implement.
			create Result.make_empty
		end
end
