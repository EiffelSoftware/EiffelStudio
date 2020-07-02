note
	description:
		"Generates Eiffel abstraction wrappers for C union types"
	library: "Eiffel Wrapper Generator Library"
	date: "$Date$"
	revision: "$Revision$"

class
	EWG_EIFFEL_API_UNION_WRAPPER_GENERATOR


inherit
--	EWG_ABSTRACT_GENERATOR
--		redefine
--			make_internal
--		end

	EWG_SHARED_TEMPLATE_EXPANDER
		export {NONE} all end

	EWG_SHARED_C_SYSTEM
		export {NONE} all end

	EWG_RENAMER
		export {NONE} all end

	EWG_EIFFEL_API_SHARED
		redefine
			make_internal
		end

create

	make

feature {NONE} -- Initialization

	make_internal
		do
			Precursor
			make_printers
		end

	make_printers
		do
			create cast_printer.make (output_stream)
			cast_printer.enable_additional_pointer_indirection
		end


feature -- Generation

	generate (a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		local
			cs: DS_BILINEAR_CURSOR [EWG_UNION_WRAPPER]
			file_name: STRING
			file: KL_TEXT_OUTPUT_FILE
		do
			from
				cs := a_eiffel_wrapper_set.new_union_wrapper_cursor
				cs.start
			until
				cs.off
			loop
				file_name := file_system.pathname (directory_structure.eiffel_directory_name,
															  cs.item.mapped_eiffel_name.as_lower
															  + "_union_api.e")

				create file.make (file_name)
				file.recursive_open_write

				if not file.is_open_write then
					error_handler.report_cannot_write_error (file_name)
				else
					file.put_line (Generated_file_warning_eiffel_comment)
					file.put_new_line
					output_stream := file
					generate_union_wrapper (cs.item)
					file.close
				end
				cs.forth
				error_handler.tick
			end
		end

feature -- Generate Eiffel API

	generate_union_wrapper (a_union_wrapper: EWG_UNION_WRAPPER)
		local
			cs: DS_BILINEAR_CURSOR [EWG_MEMBER_WRAPPER]
		do
			output_stream.put_string ("class ")
			output_stream.put_string (a_union_wrapper.mapped_eiffel_name)
			output_stream.put_line ("_UNION_API")
			output_stream.put_new_line

				-- inheritance clause
			output_stream.put_line ("inherit")
			output_stream.put_new_line
			output_stream.put_line ("%TMEMORY_STRUCTURE")
			output_stream.put_new_line

			-- create clause
			output_stream.put_line ("create")
			output_stream.put_new_line
			output_stream.put_line ("%Tmake,")
			output_stream.put_line ("%Tmake_by_pointer")
			output_stream.put_new_line

				-- various features clause
			output_stream.put_line ("feature -- Measurement")
			output_stream.put_new_line
			output_stream.put_line ("%Tstructure_size: INTEGER ")
			output_stream.put_line ("%T%Tdo")
			output_stream.put_line ("%T%T%TResult := sizeof_external")
			output_stream.put_line ("%T%Tend")
			output_stream.put_new_line


				-- member access clause
			output_stream.put_line ("feature {ANY} -- Member Access")
			output_stream.put_new_line
			from
				cs := a_union_wrapper.members.new_cursor
				cs.start
			until
				cs.off
			loop
				generate_member (cs.item)
				cs.forth
			end

			generate_c_inline_union_wrapper (a_union_wrapper)

			output_stream.put_line ("end")
		end

	generate_member (a_union_member: EWG_MEMBER_WRAPPER)
		do
			if attached {EWG_NATIVE_MEMBER_WRAPPER} a_union_member as native_wrapper  then
				if attached {EWG_C_AST_UNION_TYPE} native_wrapper.c_declaration.type  then
					generate_native_union_wrapper_member (native_wrapper.mapped_eiffel_name,
														  native_wrapper.composite_wrapper,
														  native_wrapper.c_declaration,
														  native_wrapper.header_file_name)
				elseif attached {EWG_C_AST_STRUCT_TYPE} native_wrapper.c_declaration.type or
						attached {EWG_C_AST_STRUCT_TYPE} native_wrapper.c_declaration.type.skip_wrapper_irrelevant_types then
					generate_native_struct_wrapper_member (native_wrapper.mapped_eiffel_name,
														  native_wrapper.composite_wrapper,
														  native_wrapper.c_declaration,
														  native_wrapper.header_file_name)

				else
					generate_native_wrapped_member (native_wrapper.mapped_eiffel_name,
														  native_wrapper.composite_wrapper,
														  native_wrapper.c_declaration,
														  native_wrapper.header_file_name)
				end
			elseif attached {EWG_UNION_MEMBER_WRAPPER} a_union_member as union_wrapper then
				generate_union_wrapped_member (union_wrapper)
			elseif attached {EWG_STRUCT_MEMBER_WRAPPER} a_union_member as struct_wrapper then
				generate_struct_wrapped_member (struct_wrapper)
			else
					check
						dead_end: False
					end
			end
		end

	generate_struct_wrapped_member (a_struct_wrapper: EWG_STRUCT_MEMBER_WRAPPER)
		local
			eiffel_member_name: STRING
			l_struct_name: STRING
		do
			if attached a_struct_wrapper.c_declaration.declarator as l_declarator then
				eiffel_member_name := eiffel_parameter_name_from_c_parameter_name (l_declarator)
				l_struct_name := eiffel_class_name_from_c_type_name (a_struct_wrapper.struct_wrapper.mapped_eiffel_name)

				if has_struct_wrapper_by_name (l_struct_name) then
					output_stream.put_string ("%T")
					output_stream.put_string (escaped_struct_feature_name (a_struct_wrapper.mapped_eiffel_name))
					output_stream.put_string (": detachable ")
					output_stream.put_string (l_struct_name)
					output_stream.put_string ("_STRUCT_API ")
					output_stream.put_new_line

					output_stream.put_string ("%T%T%T-- Access member `")
					output_stream.put_string (l_declarator)
					output_stream.put_string ("`")
					output_stream.put_new_line

					output_stream.put_line ("%T%Trequire")
					output_stream.put_line ("%T%T%Texists: exists")

					output_stream.put_line ("%T%Tdo")
					output_stream.put_string ("%T%T%Tif attached c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) as l_ptr and then not l_ptr.is_default_pointer then")
					output_stream.put_line ("%T%T%T%Tcreate Result.make_by_pointer (l_ptr)")
					output_stream.put_line ("%T%T%Tend")

					output_stream.put_line ("%T%Tensure")
					output_stream.put_string ("%T%T%Tresult_void: Result = Void implies c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) = default_pointer ")

					output_stream.put_string ("%T%T%Tresult_not_void: attached Result as l_result implies l_result.item = c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) ")
					output_stream.put_line ("%T%Tend")
					output_stream.put_new_line


					if not a_struct_wrapper.c_declaration.type.skip_consts_and_aliases.is_array_type then
						-- the setter
						output_stream.put_string ("%Tset_")
						output_stream.put_string (a_struct_wrapper.mapped_eiffel_name)
						output_stream.put_string (" (a_value: ")
						output_stream.put_string (eiffel_class_name_from_c_type_name (a_struct_wrapper.struct_wrapper.mapped_eiffel_name))
						output_stream.put_string ("_STRUCT_API) ")
						output_stream.put_new_line

						output_stream.put_string ("%T%T%T-- Set member `")
						output_stream.put_string (l_declarator)
						output_stream.put_string ("`")
						output_stream.put_new_line

						output_stream.put_line ("%T%Trequire")
						output_stream.put_line ("%T%T%Ta_value_not_void: a_value /= Void")
						output_stream.put_line ("%T%T%Texists: exists")

						output_stream.put_line ("%T%Tdo")
						output_stream.put_string ("%T%T%Tset_c_")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line (" (item, a_value.item)")

						output_stream.put_line ("%T%Tensure")
						output_stream.put_string ("%T%T%T" + eiffel_member_name + "_set: attached ")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_string (" as l_value implies l_value = a_value.item")
						output_stream.put_new_line
						output_stream.put_line ("%T%Tend")
						output_stream.put_new_line
					end
				else
					output_stream.put_string ("%T")
					output_stream.put_string (escaped_struct_feature_name (a_struct_wrapper.mapped_eiffel_name))
					output_stream.put_string (": POINTER")
					output_stream.put_new_line

					output_stream.put_string ("%T%T%T-- Access member `")
					output_stream.put_string (l_declarator)
					output_stream.put_string ("`")
					output_stream.put_new_line

					output_stream.put_line ("%T%Trequire")
					output_stream.put_line ("%T%T%Texists: exists")

					output_stream.put_line ("%T%Tdo")
					output_stream.put_string ("%T%T%TResult := c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) ")

					output_stream.put_line ("%T%Tensure")
					output_stream.put_line ("%T%Tend")
					output_stream.put_new_line

					if not a_struct_wrapper.c_declaration.type.skip_consts_and_aliases.is_array_type then
									-- the setter
						output_stream.put_string ("%Tset_")
						output_stream.put_string (escaped_struct_feature_name (a_struct_wrapper.mapped_eiffel_name))
						output_stream.put_string (" (a_value: ")
						output_stream.put_string ("POINTER )")
						output_stream.put_new_line

						output_stream.put_string ("%T%T%T-- Set member `")
						output_stream.put_string (l_declarator)
						output_stream.put_string ("`")
						output_stream.put_new_line

						output_stream.put_line ("%T%Trequire")
						output_stream.put_line ("%T%T%Ta_value_not_void: a_value /= default_pointer")
						output_stream.put_line ("%T%T%Texists: exists")

						output_stream.put_line ("%T%Tdo")
						output_stream.put_string ("%T%T%Tset_c_")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line (" (item, a_value)")
						output_stream.put_line ("%T%Tensure")
						output_stream.put_string ("%T%T%T")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_string ("_set: ")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_string (" = a_value ")
						output_stream.put_line ("%T%Tend")
						output_stream.put_new_line
					end
				end
			end
		end


	generate_native_struct_wrapper_member (a_mapped_eiffel_name: STRING;
											  a_composite_wrapper: detachable EWG_COMPOSITE_WRAPPER;
											  a_c_declaration: EWG_C_AST_DECLARATION;
											  a_header_file_name: STRING)
		local
			eiffel_member_name: STRING
			escaped_mapped_eiffel_name: STRING
			l_struct_name: STRING
		do
			if attached a_c_declaration.declarator as l_declarator  then
				escaped_mapped_eiffel_name := escaped_struct_feature_name (a_mapped_eiffel_name)
				eiffel_member_name := eiffel_parameter_name_from_c_parameter_name (l_declarator)

				if attached a_c_declaration.type.name as l_name  then
					l_struct_name := l_name.twin
				else
					if attached a_c_declaration.type.skip_wrapper_irrelevant_types.name as l_name then
						l_struct_name := l_name.twin
					else
						l_struct_name := ""
					end
				end
				l_struct_name := escaped_struct_feature_name (l_struct_name)

				l_struct_name.to_upper
				if has_struct_wrapper_by_name (l_struct_name) then
					output_stream.put_string ("%T")
					output_stream.put_string (escaped_mapped_eiffel_name)
					output_stream.put_string (": ")
					output_stream.put_string (eiffel_class_name_from_c_type_name (l_struct_name))
					output_stream.put_string ("_STRUCT_API")
					output_stream.put_new_line

					output_stream.put_string ("%T%T%T-- Access member `")
					output_stream.put_string (l_declarator)
					output_stream.put_string ("`")
					output_stream.put_new_line

					output_stream.put_line ("%T%Trequire")
					output_stream.put_line ("%T%T%Texists: exists")

					output_stream.put_line ("%T%Tdo")
					output_stream.put_string ("%T%T%Tcreate Result.make_by_pointer ( c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line ("(item) )")
					output_stream.put_line ("%T%Tensure")
					output_stream.put_string ("%T%T%Tresult_not_void: Result.item = c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) ")


					output_stream.put_line ("%T%Tend")
					output_stream.put_new_line

					if not a_c_declaration.type.skip_consts_and_aliases.is_array_type then
						-- the setter
						output_stream.put_string ("%Tset_")
						output_stream.put_string (escaped_mapped_eiffel_name)
						output_stream.put_string (" (a_value: ")
						output_stream.put_string (eiffel_class_name_from_c_type_name (l_struct_name))
						output_stream.put_string ("_STRUCT_API) ")
						output_stream.put_new_line

						output_stream.put_string ("%T%T%T-- Set member `")
						output_stream.put_string (l_declarator)
						output_stream.put_string ("`")
						output_stream.put_new_line

						output_stream.put_line ("%T%Trequire")
						output_stream.put_line ("%T%T%Ta_value_not_void: a_value /= Void")
						output_stream.put_line ("%T%T%Texists: exists")

						output_stream.put_line ("%T%Tdo")
						output_stream.put_string ("%T%T%Tset_c_")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line (" (item, a_value.item)")

						output_stream.put_line ("%T%Tensure")
						output_stream.put_string ("%T%T%T" + eiffel_member_name + "_set: ")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_string (".item = a_value.item")
						output_stream.put_new_line
						output_stream.put_line ("%T%Tend")
						output_stream.put_new_line
					end
				else
					output_stream.put_string ("%T")
					output_stream.put_string (escaped_mapped_eiffel_name)
					output_stream.put_string (": POINTER")
					output_stream.put_new_line

					output_stream.put_string ("%T%T%T-- Access member `")
					output_stream.put_string (l_declarator)
					output_stream.put_string ("`")
					output_stream.put_new_line

					output_stream.put_line ("%T%Trequire")
					output_stream.put_line ("%T%T%Texists: exists")

					output_stream.put_line ("%T%Tdo")
					output_stream.put_string ("%T%T%TResult := c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) ")

					output_stream.put_line ("%T%Tensure")
					output_stream.put_line ("%T%Tend")
					output_stream.put_new_line

					if not a_c_declaration.type.skip_consts_and_aliases.is_array_type then
									-- the setter
						output_stream.put_string ("%Tset_")
						output_stream.put_string (escaped_mapped_eiffel_name)
						output_stream.put_string (" (a_value: ")
						output_stream.put_string ("POINTER )")
						output_stream.put_new_line

						output_stream.put_string ("%T%T%T-- Set member `")
						output_stream.put_string (l_declarator)
						output_stream.put_string ("`")
						output_stream.put_new_line

						output_stream.put_line ("%T%Trequire")
						output_stream.put_line ("%T%T%Ta_value_not_void: a_value /= default_pointer")
						output_stream.put_line ("%T%T%Texists: exists")

						output_stream.put_line ("%T%Tdo")
						output_stream.put_string ("%T%T%Tset_c_")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line (" (item, a_value)")
						output_stream.put_line ("%T%Tensure")
						output_stream.put_string ("%T%T%T")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_string ("_set: ")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line (" = a_value ")
						output_stream.put_line ("%T%Tend")
						output_stream.put_new_line
					end
				end
			end
		end

	generate_native_union_wrapper_member (a_mapped_eiffel_name: STRING;
											  a_composite_wrapper: detachable EWG_COMPOSITE_WRAPPER;
											  a_c_declaration: EWG_C_AST_DECLARATION;
											  a_header_file_name: STRING)
		local
			eiffel_member_name: STRING
			escaped_mapped_eiffel_name: STRING
			l_union_name: STRING
		do
			if attached a_c_declaration.declarator as l_declarator then
				escaped_mapped_eiffel_name := escaped_struct_feature_name (a_mapped_eiffel_name)
				eiffel_member_name := eiffel_parameter_name_from_c_parameter_name (l_declarator)

				if attached a_c_declaration.type.name as l_name  then
					l_union_name := l_name.twin
				elseif attached a_c_declaration.type.skip_wrapper_irrelevant_types.name as l_name then

					l_union_name := l_name.twin
				else
					l_union_name := ""
				end
				l_union_name := escaped_struct_feature_name (l_union_name)


				l_union_name.to_upper

				if has_union_wrapper_by_name (l_union_name) then
					output_stream.put_string ("%T")
					output_stream.put_string (escaped_mapped_eiffel_name)
					output_stream.put_string (": ")
					output_stream.put_string (eiffel_class_name_from_c_type_name (l_union_name))
					output_stream.put_string ("_UNION_API")
					output_stream.put_new_line

					output_stream.put_string ("%T%T%T-- Access member `")
					output_stream.put_string (l_declarator)
					output_stream.put_string ("`")
					output_stream.put_new_line

					output_stream.put_line ("%T%Trequire")
					output_stream.put_line ("%T%T%Texists: exists")

					output_stream.put_line ("%T%Tdo")

					output_stream.put_string ("%T%T%Tcreate Result.make_by_pointer ( c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line ("(item) )")
					output_stream.put_line ("%T%Tensure")
					output_stream.put_string ("%T%T%Tresult_not_void: Result.item = c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) ")

					output_stream.put_line ("%T%Tend")
					output_stream.put_new_line

					if not a_c_declaration.type.skip_consts_and_aliases.is_array_type and not a_c_declaration.type.is_const_type then
						-- the setter
						output_stream.put_string ("%Tset_")
						output_stream.put_string (escaped_mapped_eiffel_name)
						output_stream.put_string (" (a_value: ")
						output_stream.put_string (eiffel_class_name_from_c_type_name (l_union_name))
						output_stream.put_string ("_UNION_API) ")
						output_stream.put_new_line

						output_stream.put_string ("%T%T%T-- Set member `")
						output_stream.put_string (l_declarator)
						output_stream.put_string ("`")
						output_stream.put_new_line

						output_stream.put_line ("%T%Trequire")
						output_stream.put_line ("%T%T%Ta_value_not_void: a_value /= Void")
						output_stream.put_line ("%T%T%Texists: exists")

						output_stream.put_line ("%T%Tdo")
						output_stream.put_string ("%T%T%Tset_c_")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line (" (item, a_value.item)")

						output_stream.put_line ("%T%Tensure")
						output_stream.put_string ("%T%T%T" + eiffel_member_name + "_set: ")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_string (".item = a_value.item")
						output_stream.put_new_line
						output_stream.put_line ("%T%Tend")
						output_stream.put_new_line
					end
				else
					output_stream.put_string ("%T")
					output_stream.put_string (escaped_mapped_eiffel_name)
					output_stream.put_string (": POINTER")
					output_stream.put_new_line

					output_stream.put_string ("%T%T%T-- Access member `")
					output_stream.put_string (l_declarator)
					output_stream.put_string ("`")
					output_stream.put_new_line

					output_stream.put_line ("%T%Trequire")
					output_stream.put_line ("%T%T%Texists: exists")

					output_stream.put_line ("%T%Tdo")
					output_stream.put_string ("%T%T%TResult := c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) ")

					output_stream.put_line ("%T%Tensure")
					output_stream.put_line ("%T%Tend")
					output_stream.put_new_line

					if not a_c_declaration.type.skip_consts_and_aliases.is_array_type and not a_c_declaration.type.is_const_type then
							-- the setter
						output_stream.put_string ("%Tset_")
						output_stream.put_string (escaped_mapped_eiffel_name)
						output_stream.put_string (" (a_value: ")
						output_stream.put_string ("POINTER )")
						output_stream.put_new_line

						output_stream.put_string ("%T%T%T-- Set member `")
						output_stream.put_string (l_declarator)
						output_stream.put_string ("`")
						output_stream.put_new_line

						output_stream.put_line ("%T%Trequire")
						output_stream.put_line ("%T%T%Ta_value_not_void: a_value /= default_pointer")
						output_stream.put_line ("%T%T%Texists: exists")

						output_stream.put_line ("%T%Tdo")
						output_stream.put_string ("%T%T%Tset_c_")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line (" (item, a_value)")
						output_stream.put_line ("%T%Tensure")
						output_stream.put_string ("%T%T%T")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_string ("_set: ")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line (" = a_value ")
						output_stream.put_line ("%T%Tend")
						output_stream.put_new_line
					end
				end
			end
		end

	generate_union_wrapped_member (a_union_wrapper: EWG_UNION_MEMBER_WRAPPER)
		local
			eiffel_member_name: STRING
			l_union_name: STRING
		do
			if attached a_union_wrapper.c_declaration.declarator as l_declarator then
				eiffel_member_name := eiffel_parameter_name_from_c_parameter_name (l_declarator)
				l_union_name := a_union_wrapper.union_wrapper.mapped_eiffel_name

				if has_union_wrapper_by_name (l_union_name) then
					output_stream.put_string ("%T")
					output_stream.put_string (escaped_struct_feature_name (a_union_wrapper.mapped_eiffel_name))
					output_stream.put_string (": detachable ")
					output_stream.put_string (l_union_name)
					output_stream.put_string ("_UNION_API ")
					output_stream.put_new_line

					output_stream.put_string ("%T%T%T-- Access member `")
					output_stream.put_string (l_declarator)
					output_stream.put_string ("`")
					output_stream.put_new_line

					output_stream.put_line ("%T%Trequire")
					output_stream.put_line ("%T%T%Texists: exists")

					output_stream.put_line ("%T%Tdo")
					output_stream.put_string ("%T%T%Tif attached c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) as l_ptr and then not l_ptr.is_default_pointer then")
					output_stream.put_line ("%T%T%T%Tcreate Result.make_by_pointer (l_ptr)")
					output_stream.put_line ("%T%T%Tend")

					output_stream.put_line ("%T%Tensure")
					output_stream.put_string ("%T%T%Tresult_void: Result = Void implies c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) = default_pointer ")

					output_stream.put_string ("%T%T%Tresult_not_void: attached Result as l_result implies l_result.item = c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) ")
					output_stream.put_line ("%T%Tend")
					output_stream.put_new_line

					if not a_union_wrapper.c_declaration.type.skip_consts_and_aliases.is_array_type and not a_union_wrapper.c_declaration.type.is_const_type then
						-- the setter
						output_stream.put_string ("%Tset_")
						output_stream.put_string (a_union_wrapper.mapped_eiffel_name)
						output_stream.put_string (" (a_value: ")
						output_stream.put_string (a_union_wrapper.union_wrapper.mapped_eiffel_name)
						output_stream.put_string ("_UNION_API) ")
						output_stream.put_new_line

						output_stream.put_string ("%T%T%T-- Set member `")
						output_stream.put_string (l_declarator)
						output_stream.put_string ("`")
						output_stream.put_new_line

						output_stream.put_line ("%T%Trequire")
						output_stream.put_line ("%T%T%Ta_value_not_void: a_value /= Void")
						output_stream.put_line ("%T%T%Texists: exists")

						output_stream.put_line ("%T%Tdo")
						output_stream.put_string ("%T%T%Tset_c_")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line (" (item, a_value.item)")

						output_stream.put_line ("%T%Tensure")
						output_stream.put_string ("%T%T%T" + eiffel_member_name + "_set: attached ")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_string (" as l_value implies l_value = a_value.item")
						output_stream.put_new_line
						output_stream.put_line ("%T%Tend")
						output_stream.put_new_line
					end
				else
					output_stream.put_string ("%T")
					output_stream.put_string (escaped_struct_feature_name (a_union_wrapper.mapped_eiffel_name))
					output_stream.put_string (": POINTER")
					output_stream.put_new_line

					output_stream.put_string ("%T%T%T-- Access member `")
					output_stream.put_string (l_declarator)
					output_stream.put_string ("`")
					output_stream.put_new_line

					output_stream.put_line ("%T%Trequire")
					output_stream.put_line ("%T%T%Texists: exists")

					output_stream.put_line ("%T%Tdo")
					output_stream.put_string ("%T%T%TResult := c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) ")

					output_stream.put_line ("%T%Tensure")
					output_stream.put_line ("%T%Tend")
					output_stream.put_new_line

					if not a_union_wrapper.c_declaration.type.skip_consts_and_aliases.is_array_type and not a_union_wrapper.c_declaration.type.is_const_type then
									-- the setter
						output_stream.put_string ("%Tset_")
						output_stream.put_string (escaped_struct_feature_name (a_union_wrapper.mapped_eiffel_name))
						output_stream.put_string (" (a_value: ")
						output_stream.put_string ("POINTER )")
						output_stream.put_new_line

						output_stream.put_string ("%T%T%T-- Set member `")
						output_stream.put_string (l_declarator)
						output_stream.put_string ("`")
						output_stream.put_new_line

						output_stream.put_line ("%T%Trequire")
						output_stream.put_line ("%T%T%Ta_value_not_void: a_value /= default_pointer")
						output_stream.put_line ("%T%T%Texists: exists")

						output_stream.put_line ("%T%Tdo")
						output_stream.put_string ("%T%T%Tset_c_")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line (" (item, a_value)")
						output_stream.put_line ("%T%Tensure")
						output_stream.put_string ("%T%T%T")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_string ("_set: ")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line (" = a_value ")
						output_stream.put_line ("%T%Tend")
						output_stream.put_new_line
					end
				end
			end
		end


	generate_native_wrapped_member (a_mapped_eiffel_name: STRING;
											  a_composite_wrapper: detachable EWG_COMPOSITE_WRAPPER;
											  a_c_declaration: EWG_C_AST_DECLARATION;
											  a_header_file_name: STRING)
		require
			a_mapped_eiffel_name_not_void: a_mapped_eiffel_name /= Void
			a_mapped_eiffel_name_not_empty: not a_mapped_eiffel_name.is_empty
--			a_composite_wrapper_not_void: a_composite_wrapper /= Void
			a_c_declaration_not_void: a_c_declaration /= Void
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
		local
			eiffel_member_name: STRING
		do
			if attached a_c_declaration.declarator as l_declarator then
				eiffel_member_name := eiffel_parameter_name_from_c_parameter_name (l_declarator)

				-- the getter
				output_stream.put_string ("%T")
				output_stream.put_string (a_mapped_eiffel_name)
				output_stream.put_string (": ")

				-- Add detachable iff the type is STRING OR UNICODE STRING
				if is_char_pointer_type (a_c_declaration) or is_unicode_char_pointer_type (a_c_declaration) then
					output_stream.put_string (" detachable ")
				end

				if a_c_declaration.type.corresponding_eiffel_type_api.same_string ("STRING_8")  then
					output_stream.put_string ("C_STRING")
				elseif a_c_declaration.type.corresponding_eiffel_type_api.same_string ("STRING_32") then
					output_stream.put_string ("NATIVE_STRING")
				else
					output_stream.put_string (a_c_declaration.type.corresponding_eiffel_type_api )
				end
				output_stream.put_string (" ")
				output_stream.put_new_line

				output_stream.put_string ("%T%T%T-- Access member `")
				output_stream.put_string (l_declarator)
				output_stream.put_string ("`")
				output_stream.put_new_line

				output_stream.put_line ("%T%Trequire")
				output_stream.put_line ("%T%T%Texists: exists")

				output_stream.put_line ("%T%Tdo")

				if is_char_pointer_type (a_c_declaration) then
					output_stream.put_string ("%T%T%Tif attached c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) as l_ptr then")
					--output_stream.put_line ("%T%T%T%TResult := (create {C_STRING}.make_by_pointer (l_ptr)).string")
					output_stream.put_line ("%T%T%T%Tcreate Result.make_by_pointer (l_ptr)")
					output_stream.put_line ("%T%T%Tend")

					output_stream.put_line ("%T%Tensure")
					output_stream.put_string ("%T%T%Tresult_void: Result = Void implies c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) = default_pointer")
					--output_stream.put_line ("%T%T%Tresult_not_void: attached Result as l_result implies l_result.same_string ((create {C_STRING}.make_by_pointer (item)).string)")
					output_stream.put_line ("%T%T%Tresult_not_void: attached Result as l_result implies l_result.string..same_string ((create {C_STRING}.make_by_pointer (item)).string)")
					output_stream.put_line ("%T%Tend")
					output_stream.put_new_line
				elseif is_unicode_char_pointer_type (a_c_declaration) then
					output_stream.put_string ("%T%T%Tif attached c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) as l_ptr then")
					--output_stream.put_line ("%T%T%T%TResult := (create {NATIVE_STRING}.make_from_pointer (l_ptr)).string")
					output_stream.put_line ("%T%T%T%Tcreate Result.make_from_pointer (l_ptr)")
					output_stream.put_line ("%T%T%Tend")

					output_stream.put_line ("%T%Tensure")
					output_stream.put_string ("%T%T%Tresult_void: Result = Void implies c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item) = default_pointer")
					--output_stream.put_line ("%T%T%Tresult_not_void: attached Result as l_result implies l_result.same_string ((create {NATIVE_STRING}.make_from_pointer (item)).string)")
					output_stream.put_line ("%T%T%Tresult_not_void: attached Result as l_result implies l_result.string.same_string ((create {NATIVE_STRING}.make_from_pointer (item)).string)")
					output_stream.put_line ("%T%Tend")
					output_stream.put_new_line
				else
					output_stream.put_string ("%T%T%TResult := c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item)")
					output_stream.put_line ("%T%Tensure")
					output_stream.put_string ("%T%T%Tresult_correct: Result = c_")
					output_stream.put_string (eiffel_member_name)
					output_stream.put_line (" (item)")
					output_stream.put_line ("%T%Tend")
					output_stream.put_new_line
				end
				if
					not a_c_declaration.type.skip_consts_and_aliases.is_array_type and not a_c_declaration.type.is_const_type
				then
						-- the setter
					output_stream.put_string ("%Tset_")
					output_stream.put_string (a_mapped_eiffel_name)
					output_stream.put_string (" (a_value: ")
					if a_c_declaration.type.corresponding_eiffel_type_api.same_string ("STRING_8") then
						output_stream.put_string ("C_STRING")
					elseif a_c_declaration.type.corresponding_eiffel_type_api.same_string ("STRING_32") then
						output_stream.put_string ("NATIVE_STRING")
					else
						output_stream.put_string (a_c_declaration.type.corresponding_eiffel_type_api)
					end
					output_stream.put_string (") ")
					output_stream.put_new_line

					output_stream.put_string ("%T%T%T-- Change the value of member `")
					output_stream.put_string (l_declarator)
					output_stream.put_string ("` to `a_value`.")
					output_stream.put_new_line

					output_stream.put_line ("%T%Trequire")
					output_stream.put_line ("%T%T%Texists: exists")

					output_stream.put_line ("%T%Tdo")
					if a_c_declaration.type.is_char_pointer_type   then
						output_stream.put_string ("%T%T%Tset_c_")
						output_stream.put_string (eiffel_member_name)
						--output_stream.put_line (" (item, (create {C_STRING}.make (a_value)).item )")
						output_stream.put_line (" (item, a_value.item )")
					elseif a_c_declaration.type.is_unicode_char_pointer_type then
						output_stream.put_string ("%T%T%Tset_c_")
						output_stream.put_string (eiffel_member_name)
						--output_stream.put_line (" (item, (create {NATIVE_STRING}.make (a_value)).item )")
						output_stream.put_line (" (item, a_value.item )")
					else
						output_stream.put_string ("%T%T%Tset_c_")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line (" (item, a_value)")
					end
					if
						not (a_c_declaration.type.skip_consts_and_aliases.is_struct_type or
							  a_c_declaration.type.skip_consts_and_aliases.is_union_type)
					then
						output_stream.put_line ("%T%Tensure")
						output_stream.put_string ("%T%T%T")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_string ("_set: a_value = c_")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line ("(item)")
					end

					output_stream.put_line ("%T%Tend")
					output_stream.put_new_line
				end

				if a_c_declaration.type.skip_consts_and_aliases.is_callback then
					-- the function caller
					output_stream.put_line ("-- TODO: function pointers not yet callable from")
					output_stream.put_line ("--%T%Tunion, use corresponding callback class instead")
				end
			end
		end


feature -- Generate Eiffel Low level C API.

	generate_c_inline_union_wrapper (a_union_wrapper: EWG_UNION_WRAPPER)
		local
			c_declaration_printer: EWG_C_DECLARATION_PRINTER
			eiffel_to_c_cast_printer: EWG_EIFFEL_TO_C_TYPE_CAST_PRINTER
			type_name: STRING
			escaped_union_name: STRING
			cs: DS_BILINEAR_CURSOR [EWG_C_AST_DECLARATION]
			cast_with_one_pointer_indirection: STRING
		do
			create type_name.make (20)
			create c_declaration_printer.make_string (type_name)
			c_declaration_printer.print_declaration_from_type (a_union_wrapper.c_union_type, "")

			escaped_union_name := type_name.twin
			escape_type_name_to_be_c_identifier (escaped_union_name)


			output_stream.put_string ("feature {NONE} --C Implementation: ")
			output_stream.put_string (type_name)
			output_stream.put_new_line
			output_stream.put_new_line

			if a_union_wrapper.c_union_type.is_complete then
				generate_sizeof_feature (a_union_wrapper.header_file_name,
												 type_name,
												 escaped_union_name)
			else
				-- What shall I do? I simply cant find out the size of an incomplete union
				-- TODO: Either don't wrap incomplete unions, or add a notion of completeness in wrapper
				-- that will be a precondition to `sizeof_external'. Or something similar...
				-- TODO: integrate this into `generate_sizeof_feature'
				output_stream.put_line ("%Tsizeof_external: INTEGER ")
				output_stream.put_line ("%T%Tdo")
				output_stream.put_line ("%T%T%Tcheck")
				output_stream.put_line ("%T%T%T%Tsize_not_known: False")
				output_stream.put_line ("%T%T%Tend")
				output_stream.put_line ("%T%Tend")
			end
			output_stream.put_new_line

			create cast_with_one_pointer_indirection.make (20)
			create eiffel_to_c_cast_printer.make_string (cast_with_one_pointer_indirection, eiffel_compiler_mode)
			eiffel_to_c_cast_printer.print_declaration_from_type (a_union_wrapper.c_union_type, "")

			-- member access
			if attached a_union_wrapper.c_union_type.members as l_members then -- a_union_wrapper.c_union_type.is_complete
				from
					cs := l_members.new_cursor
					cs.start
				until
					cs.off
				loop
					if
						not (cs.item.type.skip_consts_and_aliases.is_composite_type and
							not cs.item.type.is_named_recursive)
					then
						-- For now we do not handle anonymous nested composite types
						generate_member_getter (cs.item,
														escaped_union_name,
														a_union_wrapper.header_file_name,
														type_name,
														cast_with_one_pointer_indirection)
						if not cs.item.type.skip_consts_and_aliases.is_array_type and not cs.item.type.is_const_type then
							generate_member_setter (cs.item,
															escaped_union_name,
															a_union_wrapper.header_file_name,
															type_name,
															cast_with_one_pointer_indirection)
						end
					end
					cs.forth
				end
			end

			output_stream.put_new_line
		end

	generate_member_getter (a_union_member: EWG_C_AST_DECLARATION;
									an_escaped_union_name: STRING;
									a_header_file_name: STRING;
									a_declaration: STRING;
									a_cast_with_one_pointer_indirection: STRING)
		require
			a_union_member_not_void: a_union_member /= Void
			an_escaped_union_name_not_void: an_escaped_union_name /= Void
			a_declaration_not_void: a_declaration /= Void
			a_cast_with_one_pointer_indirection_not_void: a_cast_with_one_pointer_indirection /= Void
		local
			eiffel_member_name: STRING
		do
			if attached a_union_member.declarator as l_declarator then
				eiffel_member_name := eiffel_parameter_name_from_c_parameter_name (l_declarator)
				output_stream.put_string ("%Tc_")
				output_stream.put_string (eiffel_member_name)
				output_stream.put_string (" (an_item: POINTER): ")
				output_stream.put_string (a_union_member.type.corresponding_eiffel_type)
				output_stream.put_line (" ")
				output_stream.put_line ("%T%Trequire")
				output_stream.put_line ("%T%T%Tan_item_not_null: an_item /= default_pointer")
				output_stream.put_line ("%T%Texternal")

				generate_inline_union_wrapper (a_header_file_name)

				output_stream.put_line ("%T%Talias")
				output_stream.put_line ("%T%T%T%"[")
				output_stream.put_string ("%T%T%T%T")
				if
					a_union_member.type.skip_consts_and_aliases.is_struct_type or
						a_union_member.type.skip_consts_and_aliases.is_union_type
				then
					output_stream.put_character ('&')
				end
				output_stream.put_string ("(")
				output_stream.put_string (a_cast_with_one_pointer_indirection)
				output_stream.put_string ("$an_item)->")
				output_stream.put_line (l_declarator)
				output_stream.put_line ("%T%T%T]%"")

				output_stream.put_line ("%T%Tend")
				output_stream.put_new_line
			end
		end

	generate_member_setter (a_union_member: EWG_C_AST_DECLARATION;
									an_escaped_union_name: STRING;
									a_header_file_name: STRING;
									a_declaration: STRING;
									a_cast_with_one_pointer_indirection: STRING)
		require
			a_union_member_not_void: a_union_member /= Void
			an_escaped_union_name_not_void: an_escaped_union_name /= Void
			a_declaration_not_void: a_declaration /= Void
			a_cast_with_one_pointer_indirection_not_void: a_cast_with_one_pointer_indirection /= Void
			not_array: not a_union_member.type.skip_consts_and_aliases.is_array_type
		local
			eiffel_member_name: STRING
			eiffel_to_c_cast_printer: EWG_EIFFEL_TO_C_TYPE_CAST_PRINTER
		do
			if attached a_union_member.declarator as l_declarator then
				eiffel_member_name := eiffel_parameter_name_from_c_parameter_name (l_declarator)
				output_stream.put_string ("%Tset_c_")
				output_stream.put_string (eiffel_member_name)
				output_stream.put_string (" (an_item: POINTER; a_value: ")
				output_stream.put_string (a_union_member.type.corresponding_eiffel_type)
				output_stream.put_line (") ")
				output_stream.put_line ("%T%Trequire")
				output_stream.put_line ("%T%T%Tan_item_not_null: an_item /= default_pointer")
				output_stream.put_line ("%T%Texternal")

				generate_inline_union_wrapper (a_header_file_name)

					-- To be updated
				output_stream.put_line ("%T%Talias")
				output_stream.put_string ("%T%T%T%"[")
				output_stream.put_string ("%N%T%T%T%T(")
				output_stream.put_string (a_cast_with_one_pointer_indirection)
				output_stream.put_string ("$an_item)->")
				output_stream.put_string (l_declarator)
				output_stream.put_string (" = ")
				output_stream.put_character (' ')
				if
					a_union_member.type.skip_consts_and_aliases.is_struct_type or
						a_union_member.type.skip_consts_and_aliases.is_union_type
				then
					output_stream.put_character ('*')
				end
				create eiffel_to_c_cast_printer.make (output_stream, eiffel_compiler_mode)
				eiffel_to_c_cast_printer.print_declaration_from_type (a_union_member.type, "")
				output_stream.put_line ("$a_value;")
				output_stream.put_line ("%T%T%T]%"")

				output_stream.put_line ("%T%Tend")
				output_stream.put_new_line
			end
		end

	generate_sizeof_feature (a_header_file_name: STRING;
									 a_type_name: STRING;
									 an_escaped_union_name: STRING)
		require
			a_header_file_name_not_void: a_header_file_name /= Void
			a_type_name_not_void: a_type_name /= Void
			an_escaped_union_name_not_void: an_escaped_union_name /= Void
		do
			output_stream.put_line ("%Tsizeof_external: INTEGER ")
			output_stream.put_line ("%T%Texternal")

			generate_inline_union_wrapper (a_header_file_name)

			output_stream.put_line ("%T%Talias")
			output_stream.put_string ("%T%T%T%"sizeof(")
			output_stream.put_string (a_type_name)
			output_stream.put_line (")%"")
			output_stream.put_line ("%T%Tend")
		end

	generate_inline_union_wrapper (a_header_file_name: STRING)
		require
			a_header_file_name_not_void: a_header_file_name /= Void
		do
			output_stream.put_string ("%T%T%T%"C inline use <")
			output_stream.put_string (a_header_file_name)
			output_stream.put_string (">%"")
			output_stream.put_new_line
		end

	cast_printer: EWG_C_TYPE_CAST_PRINTER

invariant

	cast_printer_not_void: cast_printer /= Void

end
