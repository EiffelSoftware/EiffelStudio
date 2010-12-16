note
	description: "A general Objective-C visitor used to generate eiffel wrappers."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GENERATOR_VISITOR

inherit
	OBJC_ENTITY_DECL_VISITOR

	OBJC_NAMES_CONVERSION

	SHARED_CONFIGURATION

feature {NONE} -- Utilities

	delete_heading_underscores (a_string: STRING): STRING
			-- Return the `a_string' without the heading underscores.
		local
			current_character: CHARACTER
			i: INTEGER
		do
			create Result.make_from_string (a_string)
			from
				i := 1
				current_character := Result [i]
			until
				current_character /= '_'
			loop
				i := i + 1
				current_character := Result [i]
			end
			Result.remove_head (i - 1)
		end

	objc_type_to_eiffel_type (an_objc_type: OBJC_TYPE_DECL): STRING
			-- Return the eiffel type corresponding to the passed Objective-C type.
			-- Return `unsupported_type' if the type is not supported.
		local
			a_string: STRING
		do
			create Result.make_empty
			if attached {OBJC_ARRAY_TYPE_DECL} an_objc_type as array then
					-- Not supported
			elseif attached {OBJC_BASIC_TYPE_DECL} an_objc_type as basic_type then
				if basic_type.is_objc_bool then
					Result.append ("BOOLEAN")
				elseif basic_type.is_char or basic_type.is_unsigned_char then
					Result.append ("CHARACTER")
				elseif basic_type.is_int then
					Result.append ("INTEGER_32")
				elseif basic_type.is_short then
					Result.append ("INTEGER_16")
				elseif basic_type.is_long_long then
					Result.append ("INTEGER_64")
				elseif basic_type.is_unsigned_int then
					Result.append ("NATURAL_32")
				elseif basic_type.is_unsigned_short then
					Result.append ("NATURAL_16")
				elseif basic_type.is_unsigned_long_long then
					Result.append ("NATURAL_64")
				elseif basic_type.is_float then
					Result.append ("REAL_32")
				elseif basic_type.is_double then
					Result.append ("REAL_64")
				end
			elseif attached {OBJC_POINTER_TYPE_DECL} an_objc_type as pointer then
				if pointer.is_pointer_to_instance_object then
					a_string := pointer.name.twin
					if a_string.is_equal ("id") then
						Result.append ("NS_OBJECT")
					elseif
						a_string.starts_with ("id") and
						a_string.substring_index ("<", 1) > 0 and
						a_string.substring_index (">", 1) > 0 and
							-- We do not support types of the kind "id <Protocol1, Protocol2>". There is only
							-- on such case in the whole Cocoa framework.
						a_string.substring_index (",", 1) = 0
					then
						a_string := a_string.split ('<').last.split ('>').first
						a_string.remove_head (1)
						a_string.remove_tail (1)
						Result.append (objc_class_name_to_eiffel_style (a_string) + protocol_suffix)
					elseif
							-- We do not support types of the kind "AClassName <AProtocol>". There is only one
							-- such case in the whole Cocoa framework. Not worth supporting it yet.
						a_string.substring_index ("<", 1) = 0 and
						a_string.substring_index (">", 1) = 0 and
							-- We do not support NSDistantObject for now (it is an other root object).
						not a_string.is_equal ("NSDistantObject *") and
						not a_string.is_equal ("NSPort *") and
							-- We do not support Protocol objects because it does not make a lot of sense in eiffel.
						not a_string.is_equal ("Protocol *")
					then
						a_string.replace_substring_all (" *", "")
						Result.append (objc_class_name_to_eiffel_style (a_string))
					end
				elseif pointer.is_pointer_to_class_object then
					Result.append (configuration.objc_class_file.name.split ('/').last.split ('.').first.as_upper)
				elseif pointer.is_pointer_to_selector then
					Result.append (configuration.objc_selector_file.name.split ('/').last.split ('.').first.as_upper)
				end
			elseif attached {OBJC_STRUCT_TYPE_DECL} an_objc_type as struct then
				if struct.struct_name.is_equal ("?") then
					Result.append (objc_class_name_to_eiffel_style (struct.name))
				else
					Result.append (objc_class_name_to_eiffel_style (struct.struct_name))
				end
			elseif attached {OBJC_UNION_TYPE_DECL} an_objc_type as union then
					-- Not supported
			end
			if Result.is_empty then
				Result := unsupported_type
			end
		end

	unsupported_type: STRING = "UNSUPPORTED_TYPE"
			-- Unsupported type string.

	protocol_suffix: STRING = "_PROTOCOL"
			-- Suffix for protocol classes.

	externals_name: STRING = "Externals"
			-- Name for the externals features group.

	external_prefix: STRING = "objc_"
			-- The prefix for the name of externals.

	category_suffix: STRING = "_cat"
			-- Suffix for categories.

end
