note
	description: "[
			the type of a field or value
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CLS_TYPE

create
	make,
	make_with_pointer_level,
	make_with_container

feature {NONE} --Initialization

	make (a_type: BASIC_TYPE)
		do
			make_with_pointer_level (a_type, 0)
		end

	make_with_pointer_level (a_type: BASIC_TYPE; a_pointer_level: INTEGER)
		do
			basic_type := a_type
			if basic_type = {BASIC_TYPE}.type_var or else basic_type = {BASIC_TYPE}.method_param then
				var_num := a_pointer_level
			else
				pointer_level := a_pointer_level
			end
		ensure
			basic_type_set: basic_type = a_type
			pointer_level_set: not (basic_type = {BASIC_TYPE}.type_var or else basic_type = {BASIC_TYPE}.method_param ) implies pointer_level = a_pointer_level
			pointer_level_defaul: (basic_type = {BASIC_TYPE}.type_var or else basic_type = {BASIC_TYPE}.method_param ) implies pointer_level = 0
			array_level_set: array_level = 0
			by_ref_set: not by_ref
			type_ref_void:  type_ref = Void
			method_ref_void: method_ref = Void
			pe_index_set: pe_index = 0
			pinned_set: not pinned
			show_type_set: not show_type
			var_num_default: not (basic_type = {BASIC_TYPE}.type_var or else basic_type = {BASIC_TYPE}.method_param ) implies var_num = 0
			var_num_set: basic_type = (basic_type = {BASIC_TYPE}.type_var or else basic_type = {BASIC_TYPE}.method_param ) implies var_num = a_pointer_level

		end

	make_with_container (a_container: DATA_CONTAINER)
		do
			basic_type := {BASIC_TYPE}.class_ref
			type_ref := a_container
		ensure
			tp_set: basic_type = {BASIC_TYPE}.class_ref
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

	var_num: INTEGER

	by_ref: BOOLEAN

	array_level: INTEGER

	basic_type: BASIC_TYPE
		--The type of the CLS_TYPE object

	type_ref: detachable DATA_CONTAINER
		-- The class reference for class type objects.

	method_ref: detachable METHOD_SIGNATURE
		-- The signature reference for method type objects

	pe_index: NATURAL

	show_type: BOOLEAN assign set_show_type



feature -- Element Change

	set_show_type (a_val: BOOLEAN)
		do
			show_type := a_val
		ensure
			show_type_set: show_type = a_val
		end

	set_pointer_level (a_val: INTEGER)
			-- Pointer indirection count
		do
			pointer_level := a_val
		ensure
			pointer_level_set: pointer_level= a_val
		end

feature -- Status Report

	is_void: BOOLEAN
		do
			Result := basic_type = {BASIC_TYPE}.Void_ and then pointer_level = 0
		end

feature --Access Instance Free

	type_names: ARRAYED_LIST[STRING]
		once
			create Result.make_from_array (<<
					"",        "",        "", "", "void",   "bool",       "char",
                    "int8",    "uint8",   "int16",  "uint16",     "int32",
                    "uint32",  "int64",   "uint64", "native int", "native unsigned int",
                    "float32", "float64", "object", "string"
			>>)
		ensure
			instance_free: class
		end

feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		local
			l_name: STRING_32
		do
			if basic_type = {BASIC_TYPE}.class_ref then
				if show_type then
					if attached type_ref as l_type_ref and then
						(l_type_ref.flags.flags & {QUALIFIERS_ENUM}.value) /= 0
					then
						a_file.put_string (" valuetype ")
					else
						a_file.put_string (" class ")
					end
				end
				if attached type_ref as l_type_ref then
					l_name := {QUALIFIERS}.name ("", l_type_ref, True)

					if l_name[1] /= "[" then
						a_file.put_string ("'")
						a_file.put_string (l_name)
						a_file.put_string ("'")
						a_file.put_string (l_type_ref.adorn_generics(False))
					else
						-- TODO implement.
					end
				end
			elseif basic_type = {BASIC_TYPE}.type_var then
				a_file.put_string ("!")
				a_file.put_integer (var_num)
			elseif basic_type = {BASIC_TYPE}.method_param then
				a_file.put_string ("!!")
				a_file.put_integer (var_num)
			elseif basic_type = {BASIC_TYPE}.method_ref then
				a_file.put_string ("method ")
				if attached method_ref as l_method_ref then
					Result := l_method_ref.il_src_dump (a_file, false, true, true)
				end
			else
				a_file.put_string (type_names.at (basic_type.index + 1))
			end
			if array_level = 1 then
				a_file.put_string (" []")
			elseif array_level /= 0 then
				a_file.put_string (" [")
				across 0 |..| (array_level - 1) as  i loop
					if i /= 0 then
						a_file.put_string (", 0...")
					else
						a_file.put_string ("0...")
					end
				end
				a_file.put_string ("]")
			end
			if pointer_level > 0 then
				across 0 |..| (pointer_level-1) as  i loop
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

end
