note
	description: "[
			the type of a field or value
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_TYPE

inherit

	REFACTORING_HELPER

create
	make,
	make_with_pointer_level,
	make_with_container

feature {NONE} --Initialization

	make (a_type: CIL_BASIC_TYPE)
		do
			make_with_pointer_level (a_type, 0)
		end

	make_with_pointer_level (a_type: CIL_BASIC_TYPE; a_pointer_level: INTEGER)
		do
			basic_type := a_type
			if basic_type = {CIL_BASIC_TYPE}.type_var or else basic_type = {CIL_BASIC_TYPE}.method_param then
				var_num := a_pointer_level
			else
				pointer_level := a_pointer_level
			end
		ensure
			basic_type_set: basic_type = a_type
			pointer_level_set: not (basic_type = {CIL_BASIC_TYPE}.type_var or else basic_type = {CIL_BASIC_TYPE}.method_param) implies pointer_level = a_pointer_level
			pointer_level_defaul: (basic_type = {CIL_BASIC_TYPE}.type_var or else basic_type = {CIL_BASIC_TYPE}.method_param) implies pointer_level = 0
			array_level_set: array_level = 0
			by_ref_set: not by_ref
			type_ref_void: type_ref = Void
			method_ref_void: method_ref = Void
			pe_index_set: pe_index = 0
			pinned_set: not pinned
			show_type_set: not show_type
			var_num_default: not (basic_type = {CIL_BASIC_TYPE}.type_var or else basic_type = {CIL_BASIC_TYPE}.method_param) implies var_num = 0
			var_num_set: (basic_type = {CIL_BASIC_TYPE}.type_var or else basic_type = {CIL_BASIC_TYPE}.method_param) implies var_num = a_pointer_level
			mod_opt_void: mod_opt = Void
		end

	make_with_container (a_container: CIL_DATA_CONTAINER)
		do
			basic_type := {CIL_BASIC_TYPE}.class_ref
			type_ref := a_container
		ensure
			tp_set: basic_type = {CIL_BASIC_TYPE}.class_ref
			pointer_level_set: pointer_level = 0
			array_level_set: array_level = 0
			by_ref_set: not by_ref
			type_ref_set: attached type_ref as l_type_ref and then l_type_ref = a_container
			method_ref_void: method_ref = Void
			pe_index_set: pe_index = 0
			pinned_set: not pinned
			show_type_set: not show_type
			var_num_set: var_num = 0
		end

feature -- Access

	pinned: BOOLEAN

	pointer_level: INTEGER
			-- pointre indirection count.

	var_num: INTEGER
			-- generic variable number

	by_ref: BOOLEAN
			-- is a reference?

	array_level: INTEGER

	basic_type: CIL_BASIC_TYPE
			--The type of the CLS_TYPE object

	type_ref: detachable CIL_DATA_CONTAINER
			-- The class reference for class type objects.
			--|In the C++ library it the method GetClass.

	method_ref: detachable CIL_METHOD_SIGNATURE
			-- The signature reference for method type objects
			--| In the C++ library is the method GetMethod.

	mod_opt: detachable CIL_TYPE

	pe_index: NATURAL_64

	show_type: BOOLEAN assign set_show_type

feature -- Status Report

	matches (a_other: CIL_TYPE): BOOLEAN
			-- Current type and `a_other` are an exact match?
		local
			n1, n2: INTEGER
			l_transfer: BOOLEAN
		do
			Result := True
			if not (basic_type = a_other.basic_type) then
				Result := False
			end
			if Result and then
				array_level /= a_other.array_level
			then
				Result := False
			end
			if Result and then
				pointer_level /= a_other.pointer_level
			then
				Result := False
			end
			if Result and then
				by_ref /= a_other.by_ref
			then
				Result := False
			end
			if Result and then
				basic_type = {CIL_BASIC_TYPE}.class_ref and then
				not matches_type_ref (a_other.type_ref)
			then
				if attached {CIL_DATA_CONTAINER} type_ref as l_type_ref and then
					attached {CIL_DATA_CONTAINER} a_other.type_ref as l_other_type_ref
				then
					n1 := l_type_ref.name.substring_index ("_empty", 1)
					n2 := l_other_type_ref.name.substring_index ("_empty", 1)
					if n1 /= 0 or else n2 /= 0 then
						l_transfer := False
						if n1 = 0 then
							n1 := l_type_ref.name.substring_index ("_array_", 1)
						else
							l_transfer := True
							n2 := l_other_type_ref.name.substring_index ("_array_", 1)
						end
						if n1 /= n2 then
							Result := False
						end
						if Result and then
							l_type_ref.name.substring (1, n1) /= l_other_type_ref.name.substring (1, n2)
						then
							Result := False
						end
						if Result and then
							l_transfer
						then
							type_ref := a_other.type_ref -- TODO add a setter so we can add a postcondition.
						end
					end
				end
			end
		end

	matches_type_ref (a_other: detachable CIL_DATA_CONTAINER): BOOLEAN
			-- TODO double check this implementation
		do
			if
				attached type_ref as l_type_Ref and then
				attached a_other as l_other
			then
					-- TODO need to check how to
					-- compare DATA_CONTAINER instances.
				Result := l_type_ref.is_equal (l_other)
			else
				if type_ref = Void and then
					a_other = Void
				then
					Result := True
				else
					Result := False
				end
			end
		end

feature -- Element Change

	set_show_type (a_val: BOOLEAN)
			-- Set `show_type` with `a_val`.
		do
			show_type := a_val
		ensure
			show_type_set: show_type = a_val
		end

	set_pointer_level (a_val: INTEGER)
			-- Set `pointer_level` with `a_val`
			--| Pointer indirection count
		do
			pointer_level := a_val
		ensure
			pointer_level_set: pointer_level = a_val
		end

	set_pinned (a_val: BOOLEAN)
			-- Set `pinned` with `a_val`.
		do
			pinned := a_val
		ensure
			pinned_set: pinned = a_val
		end

	set_var_num (a_val: INTEGER_32)
			-- Set `var_num` with `a_val`.
		do
			var_num := a_val
		ensure
			var_num_set: var_num = a_val
		end

	set_by_ref (a_val: BOOLEAN)
			-- Set `by_ref` with `a_val`.
		do
			by_ref := a_val
		ensure
			by_ref_set: by_ref = a_val
		end

	set_array_level (a_val: INTEGER_32)
			-- Set `array_level` with `a_val`.
		do
			array_level := a_val
		ensure
			array_level_set: array_level = a_val
		end

	set_basic_type (a_type: like basic_type)
			-- Set `basic_type` with `a_type`.
		do
			basic_type := a_type
		ensure
			basic_type_set: basic_type = a_type
		end

	set_pe_index (a_val: NATURAL_64)
			-- Set `pe_index` with `a_val`.
		do
			pe_index := a_val
		ensure
			pe_index_set: pe_index = a_val
		end

	set_mod_opt (a_type: like mod_opt)
			--Set `mod_opt` with `a_type`.
		do
			mod_opt := a_type
		ensure
			mod_opt_set: mod_opt = a_type
		end

feature -- Status Report

	is_void: BOOLEAN
		do
			Result := basic_type = {CIL_BASIC_TYPE}.Void_ and then pointer_level = 0
		end

feature --Access Instance Free

	type_names: ARRAYED_LIST [STRING]
		once
			create Result.make_from_array (<<
					"", "", "", "", "void", "bool", "char",
					"int8", "uint8", "int16", "uint16", "int32",
					"uint32", "int64", "uint64", "native int", "native unsigned int",
					"float32", "float64", "object", "string"
				>>)
		ensure
			instance_free: class
		end

feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		local
			l_name: STRING_32
			l_npos: INTEGER
		do
			if basic_type = {CIL_BASIC_TYPE}.class_ref then
				if show_type then
					if attached type_ref as l_type_ref and then
						(l_type_ref.flags.flags & {CIL_QUALIFIERS_ENUM}.value) /= 0
					then
						a_file.put_string (" valuetype ")
					else
						a_file.put_string (" class ")
					end
				end
				if attached {CIL_CLASS} type_ref as l_type_ref then
					l_name := {CIL_QUALIFIERS}.name ("", l_type_ref, True)

					if l_name [1] /= '[' then
						a_file.put_string ("'")
						a_file.put_string (l_name)
						a_file.put_string ("'")
						a_file.put_string (l_type_ref.adorn_generics (False))
					else
						l_npos := l_name.index_of (']', 1)
						if l_npos /= 0 and then l_npos /= l_name.count then
							a_file.put_string (l_name.substring (1, l_npos + 1))
							a_file.put_string ("'")
							a_file.put_string (l_name.substring (l_npos + 1, l_name.count))
							a_file.put_string ("'")
							a_file.put_string (l_type_ref.adorn_generics (False))
						else
							a_file.put_string ("'")
							a_file.put_string (l_name)
							a_file.put_string ("'")
						end
					end
				end
			elseif basic_type = {CIL_BASIC_TYPE}.type_var then
				a_file.put_string ("!")
				a_file.put_integer (var_num)
			elseif basic_type = {CIL_BASIC_TYPE}.method_param then
				a_file.put_string ("!!")
				a_file.put_integer (var_num)
			elseif basic_type = {CIL_BASIC_TYPE}.method_ref then
				a_file.put_string ("method ")
				if attached method_ref as l_method_ref then
					Result := l_method_ref.il_src_dump (a_file, false, true, true)
				end
			else
				a_file.put_string (type_names.at ({CIL_BASIC_TYPE}.index_of (basic_type) + 1))
			end
			if array_level = 1 then
				a_file.put_string (" []")
			elseif array_level /= 0 then
					-- TODO double check code with Type.cpp code
				a_file.put_string (" [")
				across 0 |..| (array_level - 1) as i loop
					if i /= 0 then
						a_file.put_string (", 0...")
					else
						a_file.put_string ("0...")
					end
				end
				a_file.put_string ("]")
			end
			if pointer_level > 0 then
				across 0 |..| (pointer_level - 1) as i loop
					a_file.put_string (" *")
				end
			end
			if by_ref then
				a_file.put_string ("&")
			end
			if pinned then
				a_file.put_string (" pinned")
			end
			Result := True
		end

	render (a_stream: FILE_STREAM; a_bytes: detachable SPECIAL [NATURAL_8]): NATURAL_8
		do
			to_implement ("Add implementation")
		end

end
