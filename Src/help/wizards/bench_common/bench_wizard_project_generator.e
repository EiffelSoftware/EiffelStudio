indexing
	description	: "Object to generate a project."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	BENCH_WIZARD_PROJECT_GENERATOR

inherit
	WIZARD_SHARED
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_wizard_information: WIZARD_INFORMATION) is
			-- Initialize the project generator with information `a_wizard_information'.
		do
			wizard_information := a_wizard_information
		end

feature -- Basic Operations

	generate_code is
			-- Generate code for the project.
		deferred
		end

feature {NONE} -- Implementation

	copy_file (name, extension, destination: STRING) is
			-- Copy Class whose name is 'name'
		require
			name /= Void
		local
			f1,f_name: FILE_NAME
			fi: RAW_FILE
			s: STRING
		do
			create f1.make_from_string (wizard_resources_path)
			f_name := clone (f1)
			f_name.extend (name)
			f_name.add_extension (extension)
			create fi.make_open_read (f_name)
			fi.read_stream (fi.count)
			s := fi.last_string
			fi.close
			create f_name.make_from_string (destination)
			f_name.extend (name)
			f_name.add_extension (extension)
			create fi.make_open_write (f_name)
			fi.put_string (s)
			fi.close
		end

	from_template_to_project (template_path, template_name, resource_path, resource_name: STRING; map_list: LINKED_LIST [TUPLE [STRING, STRING]]) is
			-- Take a template_name (name of the file) and its template_path
			-- Then change the FL Tag with strings according to the map_list
			-- Copy the modified template in a new file resource_name in the resource_path.
		local
			tup: TUPLE [STRING, STRING]
			s, s1, s2: STRING
			fi: PLAIN_TEXT_FILE
			f_name: FILE_NAME
		do
			create fi.make_open_read_write(template_path + "\" + template_name)
			fi.read_stream (fi.count)
			s:= clone (fi.last_string)
			if map_list /= Void then
				from
					map_list.start
				until
					map_list.after
				loop
					tup:= map_list.item
					s1 ?= tup.item (1)
					s2 ?= tup.item (2)
					if s1 /= Void and s2 /= Void then
						s.replace_substring_all (s1, s2)
					end
					map_list.forth
				end
			end
			fi.close
			create f_name.make_from_string (resource_path + "\" + resource_name)
			create fi.make_open_write (f_name)
			fi.put_string (s)
			fi.close
		end

	add_common_parameters (map_list: LINKED_LIST [TUPLE [STRING, STRING]]) is
			-- Add the common parameters to the replacement pattern.
		local
			current_time: WEL_SYSTEM_TIME
			tuple: TUPLE [STRING, STRING]
			project_name: STRING
			project_name_lowercase: STRING
			project_name_uppercase: STRING
		do
				-- Add the project name.
			project_name := wizard_information.project_name
			create tuple.make
			tuple.put ("<FL_PROJECT_NAME>", 1)
			tuple.put (project_name, 2)
			map_list.extend (tuple)

				-- Add the project name (in uppercase)
			project_name_uppercase := clone (project_name)
			project_name_uppercase.to_upper
			create tuple.make
			tuple.put ("<FL_PROJECT_NAME_UPPERCASE>", 1)
			tuple.put (project_name_uppercase, 2)
			map_list.extend (tuple)

				-- Add the project name (in lowercase)
			project_name_lowercase := clone (project_name)
			project_name_lowercase.to_lower
			create tuple.make
			tuple.put ("<FL_PROJECT_NAME_LOWERCASE>", 1)
			tuple.put (project_name_lowercase, 2)
			map_list.extend (tuple)

				-- Add the project location
			create tuple.make
			tuple.put ("<FL_LOCATION>", 1)
			tuple.put (wizard_information.project_location, 2)
			map_list.extend (tuple)

				-- Add the date for indexing clause.
			create current_time.make_by_current_time
			create tuple.make
			tuple.put ("<FL_DATE>", 1)
			tuple.put (
				"$Date: "+current_time.year.out+"/"+current_time.month.out+"/"+current_time.day.out+" "+
				current_time.hour.out+":"+current_time.minute.out+":"+current_time.second.out+" $", 2)
			map_list.extend (tuple)
		end

feature {NONE} -- Implementation / private attributes

	wizard_information: WIZARD_INFORMATION
			-- Information about the project to generate.

end -- class WIZARD_PROJECT_GENERATOR

