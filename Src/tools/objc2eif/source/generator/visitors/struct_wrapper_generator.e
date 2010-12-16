note
	description: "A visitor used to generate wrappers for Objective-C structs."
	date: "$Date$"
	revision: "$Revision$"

class
	STRUCT_WRAPPER_GENERATOR

inherit
	GENERATOR_VISITOR
		redefine
			visit_type_decl
		end

create
	make

feature {NONE} -- Initialization

	make (a_aliases: HASH_TABLE [STRING, STRING]; a_struct_types: HASH_TABLE [OBJC_STRUCT_TYPE_DECL, STRING])
			-- Initialize Current with `a_aliases'.
		do
			create struct_classes.make (0)
			aliases := a_aliases
			struct_types := a_struct_types
		ensure
			aliases_set: aliases = a_aliases
			struct_types_set: struct_types = a_struct_types
		end

feature -- Generation

	generate_wrappers
			-- Generage struct wrappers.
		do
			from
				struct_types.start
			until
				struct_types.after
			loop
--					-- Debug
--				print ("Type: " + struct_types.item_for_iteration.name + "%N")
--				if attached struct_types.item_for_iteration.encoding as encoding then
--					print ("Encoding: " + encoding + "%N")
--				end
--				print ("Reconstructed: " + struct_types.item_for_iteration.debug_output + "%N%N")
				generate_wrapper (struct_types.item_for_iteration)
				struct_types.forth
			end
		end

feature -- Access

	struct_classes: HASH_TABLE [EIFFEL_CLASS_DECL, STRING]
			-- A table of eiffel classes to wrap Objective-C structs, indexed by class name.

feature -- Operations

	visit_type_decl (t: OBJC_TYPE_DECL)
			-- Visit a type declaration.
		local
			fields: ARRAYED_LIST [OBJC_TYPE_DECL]
			key_to_use: STRING
			ignore_struct: BOOLEAN
		do
			if attached {OBJC_STRUCT_TYPE_DECL} t as struct then
				create key_to_use.make_empty
				if struct.struct_name.is_equal ("?") then
					if not struct.name.is_equal ("?") then
						key_to_use.append (struct.name)
					else
						ignore_struct := True
					end
				else
					key_to_use.append (struct.struct_name)
				end
				if not ignore_struct then
					if
						attached struct_types.item (key_to_use) as existing_struct and then
						(existing_struct.fields.count = 0 and struct.fields.count > 0 or
						 not struct.name.is_equal (existing_struct.struct_name))
					then
						struct_types.force (struct, key_to_use)
					else
						struct_types.put (struct, key_to_use)
					end
				end
				fields := struct.fields
				from
					fields.start
				until
					fields.after
				loop
					visit_type_decl (fields.item)
					fields.forth
				end
			elseif attached {OBJC_ARRAY_TYPE_DECL} t as array then
				if attached array.pointed_type as pointed_type then
					visit_type_decl (pointed_type)
				else
					check pointed_type_not_void: False end
				end
			elseif
				attached {OBJC_POINTER_TYPE_DECL} t as pointer and then
				not (pointer.is_pointer_to_c_string or
					 pointer.is_pointer_to_class_object or
					 pointer.is_pointer_to_instance_object or
					 pointer.is_pointer_to_selector)
			then
				if attached pointer.pointed_type as pointed_type then
					visit_type_decl (pointed_type)
				else
					check pointed_type_not_void: False end
				end
			elseif attached {OBJC_UNION_TYPE_DECL} t as union then
				fields := union.fields
				from
					fields.start
				until
					fields.after
				loop
					visit_type_decl (fields.item)
					fields.forth
				end
			end
		end

feature -- Implementation

	aliases: HASH_TABLE [STRING, STRING]
			-- A table of type aliases indexed by the pointed type.
			-- E.g. Key: CGRect, Value: NSRect (alias).

	struct_types: HASH_TABLE [OBJC_STRUCT_TYPE_DECL, STRING]
			-- A table of structs types that have been visited indexed by their name.

	generate_wrapper (struct: OBJC_STRUCT_TYPE_DECL)
			-- Generate a wrapper for `struct'.
		local
			eiffel_class: EIFFEL_CLASS_DECL
			eiffel_class_name: STRING
			creation_procedures_groups: ARRAY [TUPLE [export_statuses: ARRAY [STRING]; names: ARRAY [STRING]]]
			a_feature: EIFFEL_FEATURE_DECL
			features: ARRAY [EIFFEL_FEATURE_DECL]
			body: STRING
			fields: ARRAYED_LIST [OBJC_TYPE_DECL]
			field_index: STRING
			field_type: OBJC_TYPE_DECL
			original_type_name: STRING
			original_struct_name: STRING
			original_type_to_use: STRING
			struct_name: STRING
			struct_struct_name: STRING
			type: STRING
			value: STRING
			struct_field_struct_name: STRING
			struct_field_name: STRING
			converted_type: STRING
			fields_count: INTEGER
		do
			fields := struct.fields
			fields_count := fields.count
				-- Ignore opaque structs (i.e. structs without fields)
			if fields_count > 0 then
				original_type_name := struct.name
				original_struct_name := struct.struct_name
				struct_name := delete_heading_underscores (struct.name)
				struct_struct_name := delete_heading_underscores (struct.struct_name)
				struct.name := struct_name
				struct.struct_name := struct_struct_name
				if not struct_name.is_equal (struct_struct_name) and not struct_struct_name.is_equal ("?") then
					aliases.put (objc_class_name_to_eiffel_style (struct_name), objc_class_name_to_eiffel_style (struct_struct_name))
				end
	--			if struct_struct_name.is_equal ("?") then
					eiffel_class_name := objc_class_name_to_eiffel_style (struct_name)
					original_type_to_use := original_type_name
	--			else
	--				eiffel_class_name := objc_class_name_to_eiffel_style (struct_struct_name)
	--				original_type_to_use := original_struct_name
	--			end
				create eiffel_class.make (eiffel_class_name, "structs")
				create features.make_empty
					-- Inheritance declarations
				eiffel_class.inheritance_declarations.put (<<
					["redefine", <<"out", "is_equal">>]>>,
					"MEMORY_STRUCTURE")
				eiffel_class.inheritance_declarations.put (<<
					["redefine", <<"out", "is_equal">>]>>,
					"DEBUG_OUTPUT")
					-- Creation procedures
				creation_procedures_groups := eiffel_class.creation_procedures_groups
				creation_procedures_groups.force ([<<>>, <<"make", "make_by_pointer">>], creation_procedures_groups.upper + 1)
					-- Comparison
				create features.make_empty
				body := "[
							-- Is `other' attached to an object considered
							-- equal to current object?
						do
							Result := item.memory_compare (other.item, structure_size)
						end
					]"
				create a_feature.make ("is_equal", <<["other", "like Current"]>>, body)
				a_feature.return_type := "BOOLEAN"
				features.force (a_feature, features.upper + 1)
				eiffel_class.features_groups.put ([<<>>, features], "Comparison")
					-- Settings features
				create features.make_empty
				from
					fields.start
				until
					fields.after
				loop
					field_index := fields.index.out
					body := "[
								-- Set `field$FIELD_INDEX' with 'a_field$FIELD_INDEX'.
							do
								c_set_field$FIELD_INDEX (item, a_field$FIELD_INDEX$DOT_ITEM)
							ensure
								field$FIELD_INDEX_set: field$FIELD_INDEX ~ a_field$FIELD_INDEX
							end
						]"
					body.replace_substring_all ("$FIELD_INDEX", field_index)
					if attached {OBJC_BASIC_TYPE_DECL} fields.item then
						body.replace_substring_all ("$DOT_ITEM", "")
					else
						body.replace_substring_all ("$DOT_ITEM", ".item")
					end
					converted_type := objc_type_to_eiffel_type (fields.item)
					create a_feature.make ("set_field" + field_index, <<["a_field" + field_index, converted_type]>>, body)
					a_feature.is_commented := converted_type.is_equal (unsupported_type)
					features.force (a_feature, features.upper + 1)
					fields.forth
				end
				eiffel_class.features_groups.put ([<<>>, features], "Settings")
					-- Access features
				create features.make_empty
				from
					fields.start
				until
					fields.after
				loop
					field_index := fields.index.out
					body := "[
								-- Return the struct field.
							do
								$CREATION_CODE
							end
						]"
					field_type := fields.item
					if attached {OBJC_BASIC_TYPE_DECL} field_type then
						body.replace_substring_all ("$CREATION_CODE", "Result := c_field" + field_index + " (item)")
					else
						body.replace_substring_all ("$CREATION_CODE", "create Result.make%N%Tc_copy_field" + field_index + " (item, Result.item)")
					end
					create a_feature.make ("field" + field_index, <<>>, body)
					converted_type := objc_type_to_eiffel_type (fields.item)
					a_feature.return_type := converted_type
					a_feature.is_commented := converted_type.is_equal (unsupported_type)
					a_feature.setter := "set_field" + field_index
					features.force (a_feature, features.upper + 1)
					fields.forth
				end
				eiffel_class.features_groups.put ([<<>>, features], "Access")
					-- Implementation
					-- Structure Size
				body := "[
							-- Size to allocate (in bytes).
						external
							"C inline use <$FRAMEWORK/$FRAMEWORK.h>"
						alias
							"return sizeof($TYPE);"
						end
					]"
				body.replace_substring_all ("$TYPE", original_type_to_use)
				body.replace_substring_all ("$FRAMEWORK", configuration.framework_name)
				create a_feature.make ("structure_size", <<>>, body)
				a_feature.return_type := "INTEGER"
				create features.make_empty
				features.force (a_feature, features.upper + 1)
					-- Field values
				from
					fields.start
				until
					fields.after
				loop
					field_index := fields.index.out
					field_type := fields.item
					if attached {OBJC_BASIC_TYPE_DECL} field_type then
						body := "[
									-- Return the field value.
								external
									"C inline use <$FRAMEWORK/$FRAMEWORK.h>"
								alias
									"return ((($TYPE *) $a_struct_pointer)->field$FIELD_INDEX);"
								end
							]"
						create a_feature.make ("c_field" + field_index, <<["a_struct_pointer", "POINTER"]>>, body)
						converted_type := objc_type_to_eiffel_type (fields.item)
						a_feature.return_type := converted_type
						a_feature.is_commented := converted_type.is_equal (unsupported_type)
					else
						body := "[
									-- Return the address of a copy of the field.
								external
									"C inline use <$FRAMEWORK/$FRAMEWORK.h>"
								alias
									"$LB
										size_t size = sizeof((($TYPE *) $a_struct_pointer)->field$FIELD_INDEX);
										memcpy($result_pointer, &((($TYPE *) $a_struct_pointer)->field$FIELD_INDEX), size);
									$RB"
								end
							]"
						body.replace_substring_all ("$LB", "[")
						body.replace_substring_all ("$RB", "]")
						create a_feature.make ("c_copy_field" + field_index, <<["a_struct_pointer", "POINTER"], ["result_pointer", "POINTER"]>>, body)
						a_feature.is_commented := objc_type_to_eiffel_type (field_type).is_equal (unsupported_type)
					end
					body.replace_substring_all ("$FRAMEWORK", configuration.framework_name)
					body.replace_substring_all ("$TYPE", original_type_to_use)
					body.replace_substring_all ("$FIELD_INDEX", field_index)
					features.force (a_feature, features.upper + 1)
					fields.forth
				end
					-- C field settings
				from
					fields.start
				until
					fields.after
				loop
					field_index := fields.index.out
					body := "[
								-- Set the corresponding C struct field with `a_c_field$FIELD_INDEX'.
							external
								"C inline use <$FRAMEWORK/$FRAMEWORK.h>"
							alias
								"(($TYPE *) $a_struct_pointer)->field$FIELD_INDEX = $VALUE;"
							end
						]"
					field_type := fields.item
					converted_type := objc_type_to_eiffel_type (fields.item)
					if attached {OBJC_BASIC_TYPE_DECL} field_type then
						type := converted_type
						value := "$a_c_field$FIELD_INDEX"
					else
						type := "POINTER"
						value := "*(($CAST *) $a_c_field$FIELD_INDEX)"
						if attached {OBJC_STRUCT_TYPE_DECL} field_type as struct_field then
							struct_field_name := struct_field.name
							struct_field_struct_name := struct_field.struct_name
							if struct_field_struct_name.is_equal ("?") then
								value.replace_substring_all ("$CAST", struct_field_name)
							else
								value.replace_substring_all ("$CAST", struct_field_struct_name)
							end
						else
							value.replace_substring_all ("$CAST", field_type.name)
						end

					end
					create a_feature.make ("c_set_field" + field_index, <<["a_struct_pointer", "POINTER"],
																		  ["a_c_field" + field_index, type]>>, body)
					body.replace_substring_all ("$VALUE", value)
					body.replace_substring_all ("$FRAMEWORK", configuration.framework_name)
					body.replace_substring_all ("$TYPE", original_type_to_use)
					body.replace_substring_all ("$FIELD_INDEX", field_index)
					a_feature.is_commented := converted_type.is_equal (unsupported_type)
					features.force (a_feature, features.upper + 1)
					fields.forth
				end
				eiffel_class.features_groups.put ([<<"NONE">>, features], "Implementation")
					-- Debug Output
				body := "[
							-- String that should be displayed in debugger to represent `Current'.
						do
					]"
				body.append ("%N")
--				if fields_count > 0 then
				body.append ("%TResult := %"{%" +%N")
				from
					fields.start
				until
					fields.after
				loop
					field_index := fields.index.out
					body.append ("%T%T")
					if objc_type_to_eiffel_type (fields.item).is_equal (unsupported_type) then
						body.append ("--")
					end
					body.append ("%T%"field" + field_index + ": %" + field" + field_index + ".out + %", %" +%N")
					fields.forth
				end
				body.remove_tail (8)
				body.append ("%N%T%T%"}%"%N")
--				else
--					body.append ("%TResult := %"{}%"%N")
--				end
				body.append ("end")
				create a_feature.make ("out, debug_output", <<>>, body)
				a_feature.return_type := "STRING"
				eiffel_class.features_groups.put ([<<>>, <<a_feature>>], "Debug Output")
				struct_classes.put (eiffel_class, eiffel_class_name)
			end
		end

end
