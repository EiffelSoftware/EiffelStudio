note
	description: "Generates Eiffel Constants wrappers for C macro definitions"
	library: "Eiffel Wrapper Generator Library"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	EWG_EIFFEL_API_MACRO_WRAPPER_GENERATOR

inherit

	EWG_ABSTRACT_GENERATOR

	EWG_RENAMER
		export {NONE} all end

create

	make

feature

	generate (a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		local
			cs: DS_HASH_TABLE_CURSOR [DS_LINKED_LIST [EWG_MACRO_WRAPPER], STRING]
		do
			from
				cs := a_eiffel_wrapper_set.new_macro_wrapper_groups_cursor
				cs.start
			until
				cs.off
			loop
				generate_macro_wrappers_for_class (cs.key, cs.item)
				cs.forth
			end
		end

feature {NONE}

	generate_macro_wrappers_for_class (a_class_name: STRING;
											a_macro_declaration_list: DS_LINKED_LIST [EWG_MACRO_WRAPPER])
		require
			a_class_name_not_void: a_class_name /= Void
			a_macro_declaration_list_not_void: a_macro_declaration_list /= Void
			a_macro_declaration_list_not_empty: a_macro_declaration_list.count > 0
--			a_macro_declaration_list_not_has_void: not a_macro_declaration_list.has (Void)
		local
			cs: DS_LINKED_LIST_CURSOR [EWG_MACRO_WRAPPER]
			class_name: STRING
			file_name: STRING
			file: KL_TEXT_OUTPUT_FILE
		do
			class_name :=  a_class_name.twin + "_API"

			file_name := file_system.pathname (directory_structure.eiffel_directory_name, class_name.as_lower + ".e")
			create file.make (file_name)
			file.recursive_open_write
			if file.is_open_write then
				file.put_line (Generated_file_warning_eiffel_comment)
				file.put_line ("-- Macro wrapper")
				file.put_line ("class " + class_name)
				file.put_new_line
				file.put_new_line
				file.put_line ("feature -- Access")
				file.put_new_line
				output_stream := file
					-- High level
				from
					cs := a_macro_declaration_list.new_cursor
					cs.start
				until
					cs.off
				loop
					generate_macro_wrapper (cs.item)
					cs.forth
					error_handler.tick
				end

					-- Low level
				file.put_line ("feature {NONE} -- C externals")
				file.put_new_line
				from
					cs := a_macro_declaration_list.new_cursor
					cs.start
				until
					cs.off
				loop
					generate_low_level_macro_wrapper (cs.item)
					cs.forth
					error_handler.tick
				end
				file.put_line ("end")
				file.close
			else
				error_handler.report_cannot_write_error (file_name)
			end
		end



	generate_macro_wrapper (a_wrapper: EWG_MACRO_WRAPPER)
		local
			eiffel_member_name: STRING
		do
			eiffel_member_name := a_wrapper.mapped_eiffel_name
			eiffel_member_name.adjust
			if a_wrapper.eiffel_type.same_string_general ("CHARACTER_32") or a_wrapper.eiffel_type.same_string_general ("STRING") then
				output_stream.put_string ("%T")
				output_stream.put_string (eiffel_member_name)
				output_stream.put_string (": ")
				output_stream.put_string (a_wrapper.eiffel_type)
				if a_wrapper.eiffel_value.is_empty then
					output_stream.put_line ("%T%Tdo")
						-- STRING
					if a_wrapper.eiffel_type.same_string_general ("STRING") then
						output_stream.put_string ("%T%T%TResult := (create {C_STRING}.make_by_pointer (")
						output_stream.put_string ("c_")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line (")).string")
					end

					if a_wrapper.eiffel_type.same_string_general ("CHARACTER_32") then
						output_stream.put_string ("%T%T%TResult :=")
						output_stream.put_string ("c_")
						output_stream.put_string (eiffel_member_name)
						output_stream.put_line (".to_character_32")
					end
					output_stream.put_line ("%T%Tend")
				else
					output_stream.put_string (" = ")
					if a_wrapper.eiffel_type.same_string_general ("CHARACTER_32") then
						output_stream.put_string ("'")
						output_stream.put_string (a_wrapper.eiffel_value)
						output_stream.put_string ("'")
					end
					if a_wrapper.eiffel_type.same_string_general ("STRING") then
						if a_wrapper.eiffel_value.has_substring ("%N") then
							output_stream.put_string ("%"[%N")
							output_stream.put_string (a_wrapper.eiffel_value)
							output_stream.put_string ("%N]%"")

						else
							output_stream.put_string ("%"")
							output_stream.put_string (a_wrapper.eiffel_value)
							output_stream.put_string ("%"")
						end
					end
					output_stream.put_new_line
				end
				output_stream.put_new_line
			elseif a_wrapper.eiffel_type.same_string_general ("UNKOWN") then
				output_stream.put_line (" ")
				output_stream.put_string ("-- The constant ")
				output_stream.put_string (eiffel_member_name)
				output_stream.put_line ("-- needs to be wrapped by hand ")
				output_stream.put_string ("-- Check the definition at ")
				output_stream.put_string ("-- ")
				output_stream.put_string (a_wrapper.header_file_name)
				output_stream.put_new_line
				output_stream.put_new_line
			else
					-- INTEGER_64, REAL_64, INTEGER
				output_stream.put_string ("%T")
				output_stream.put_string (eiffel_member_name)
				output_stream.put_string (": ")
				output_stream.put_string (a_wrapper.eiffel_type)

				if a_wrapper.eiffel_value.is_empty then
					output_stream.put_new_line
					output_stream.put_line ("%T%Texternal")
					output_stream.put_string ("%T%T%T%"C inline use <")
					output_stream.put_string (directory_structure.config_system.header_file_name)
					output_stream.put_string (">%"")
					output_stream.put_new_line
					output_stream.put_string ("%T%Talias")
					output_stream.put_new_line
					output_stream.put_string ("%T%T%T%"")
					output_stream.put_string (a_wrapper.constant_name)
					output_stream.put_string ("%"")
					output_stream.put_new_line
					output_stream.put_string ("%T%Tend")
				else
					output_stream.put_string (" = ")
					output_stream.put_line (a_wrapper.eiffel_value)
				end
				output_stream.put_new_line
			end
		end

	generate_low_level_macro_wrapper (a_wrapper: EWG_MACRO_WRAPPER)
		local
			eiffel_member_name: STRING
		do
			eiffel_member_name := a_wrapper.mapped_eiffel_name
			if (a_wrapper.eiffel_type.same_string_general ("CHARACTER_32") or a_wrapper.eiffel_type.same_string_general ("STRING")) and then
				(a_wrapper.eiffel_value.is_empty) then

				output_stream.put_string ("%T")
				output_stream.put_string ("c_")
				output_stream.put_string (eiffel_member_name)
				output_stream.put_string (": ")
				if a_wrapper.eiffel_type.same_string_general ("CHARACTER_32") then
					output_stream.put_line ("INTEGER_32")
				end
				if a_wrapper.eiffel_type.same_string_general ("STRING") then
					output_stream.put_line ("POINTER")
				end

				output_stream.put_new_line
				output_stream.put_line ("%T%Texternal")

				output_stream.put_string ("%T%T%T%"C inline use <")
				output_stream.put_string (directory_structure.config_system.header_file_name)
				output_stream.put_string (">%"")
				output_stream.put_new_line
				output_stream.put_string ("%T%Talias")
				output_stream.put_new_line
				output_stream.put_string ("%T%T%T%"")
				output_stream.put_string (a_wrapper.constant_name)
				output_stream.put_string ("%"")
				output_stream.put_new_line
				output_stream.put_string ("%T%Tend")
				output_stream.put_new_line
				output_stream.put_new_line
			end
		end



	end
