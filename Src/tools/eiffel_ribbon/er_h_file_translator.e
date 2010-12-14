note
	description: "[
					Like h2e.exe, translate a C header file (.h) to a Eiffel class
																					]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_H_FILE_TRANSLATOR

create
	make

feature {NONE} -- Initialization

	make (a_source_file, a_dest_directory, a_dest_class: STRING)
			-- Creation method
		require
			not_void: a_source_file /= Void
			not_void: a_dest_class /= Void
			not_void: a_dest_directory /= Void
			valid: not a_source_file.is_empty and not a_dest_class.is_empty and not a_dest_directory.is_empty
		do
			source_file_name := a_source_file
			dest_directory := a_dest_directory
			dest_class_name := a_dest_class

			create name_value.make (300)
		ensure
			set: source_file_name = a_source_file
			set: dest_directory = a_dest_directory
			set: dest_class_name = a_dest_class
		end

feature -- Command

	translate
			-- Translate C header file into a Eiffel class
		local
			l_file_content: STRING
			l_dest_file_name: FILE_NAME
			l_dest_file: RAW_FILE
		do
			parse_c_header_file
			l_file_content := generate_eiffel_class
			if not l_file_content.is_empty then
				create l_dest_file_name.make_from_string (dest_directory)
				l_dest_file_name.set_file_name (dest_class_name + ".e")

				create l_dest_file.make (l_dest_file_name)
				l_dest_file.create_read_write
				l_dest_file.put_string (l_file_content)
				l_dest_file.close
			end
		end

feature {NONE} -- Implementation

	parse_c_header_file
			--
		local
			l_source_file: RAW_FILE
			l_dest_file: RAW_FILE
			l_first_blank, l_second_blank: INTEGER
			l_name, l_value: STRING
		do
			create l_source_file.make (source_file_name)
			if l_source_file.exists then
				from
					name_value.wipe_out
					l_source_file.open_read
					l_source_file.start
				until
					l_source_file.after
				loop

					l_source_file.read_line
					if attached l_source_file.last_string as l_last_string then
						if l_last_string.starts_with ("#define") then
							-- Found a line need to be translated
							l_first_blank := l_last_string.index_of (' ', 1)
							l_second_blank := l_last_string.index_of (' ', l_first_blank + 1)
							check valid: l_first_blank /= 0 and l_second_blank /= 0 end
							l_name := l_last_string.substring (l_first_blank + 1, l_second_blank - 1)
							l_value := l_last_string.substring (l_second_blank + 1, l_last_string.count)

							name_value.extend ([l_name, l_value])
						end
					end
				end
			end
		end

	generate_eiffel_class: STRING
			--
		local
			l_template: FILE_NAME
			l_template_file: RAW_FILE
			l_last_string: STRING
			l_class_name: STRING
			l_eiffel_name_value: STRING
		do
			create Result.make_empty

			create l_template.make_from_string ({ER_MISC_CONSTANTS}.template)
			l_template.set_file_name ("header_file_template.e")

			create l_template_file.make (l_template)
			if l_template_file.exists then
				if not name_value.is_empty then
					l_eiffel_name_value := prepare_name_value_for_eiffel
					-- Prepare Eiffel class from template
					from
						l_template_file.open_read
						l_template_file.start
						l_class_name := dest_class_name.twin
						l_class_name.to_upper
					until
						l_template_file.after
					loop
						l_template_file.read_line
						l_last_string := l_template_file.last_string

						l_last_string.replace_substring_all ("$SOURCE_FILE", source_file_name)
						l_last_string.replace_substring_all ("$CLASS_NAME", l_class_name)
						l_last_string.replace_substring_all ("$GENERATED", l_eiffel_name_value)

						Result.append (l_last_string + "%N")
					end
				end
			end
		end

	prepare_name_value_for_eiffel: STRING
			--
		require
			valid: not name_value.is_empty
		local
			l_line: STRING
		do
			create Result.make_empty
			from
				name_value.start
			until
				name_value.after
			loop
				l_line := "%T" + name_value.item.a_name + ": INTEGER = " + name_value.item.a_value + "%N"
				Result.append (l_line)
				name_value.forth
			end
		end

	source_file_name: STRING
			-- Full path name of source C header file will be translated

	dest_directory: STRING
			-- Directory path for destination Eiffel Class

	dest_class_name: STRING
			-- Eiffel class name that will be generated (.e is not needed)

	name_value: ARRAYED_LIST [TUPLE [a_name: STRING; a_value: STRING]]
			-- All names and values parsed from C header file
end
