indexing
	description: "Last page, the trace of the operation is displayed."
	author: "david s"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_FINISH

inherit
	WIZARD_FINAL_STATE_WINDOW
		rename
			command_line as last_command_line
		redefine
			proceed_with_current_info
		end

	EXECUTION_ENVIRONMENT

create
	make


feature -- basic Operations

	proceed_with_current_info is 
			-- Process user entries
		do 
			build_finish
			launch_operations
			Precursor
		end

	display_state_text is
		do
			if wizard_information.new_project then
				if wizard_information.compile_project then
					title.set_text ("GENERATION AND COMPILATION")
					message.set_text ("The EiffelStore Wizard will now generate your project.%
										%%NThen it will compile it.")
				else
					title.set_text ("GENERATION")
					message.set_text ("The EiffelStore Wizard will now generate your project.%
										%%NYou have chosen not to compile it now; you may compile it later%
										%%Nusing EiffelBench.")
				end
			else
				title.set_text ("GENERATION")
				message.set_text ("The EiffelStore Wizard will now integrate the selected tables%
									 %%Nof your database in your project.")
			end
		end

	final_message: STRING is "All files have been successfully Generated !!!"

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"

	build_finish is 
			-- Build user entries.
		do
			choice_box.wipe_out
			choice_box.set_border_width (10)
			create progress 
			progress.set_minimum_height(20)
			progress.set_minimum_width(100)
			create progress_text
			choice_box.extend(create {EV_CELL})
			choice_box.extend(progress)
			choice_box.disable_item_expand(progress)
			choice_box.extend(progress_text)
			choice_box.extend(create {EV_CELL})

			choice_box.set_background_color (white_color)
			progress.set_background_color (white_color)
			progress_text.set_background_color (white_color)

		end

	launch_operations is
			-- Generate the classes and the example. Modified by Cedric R.
		local
			li: LINKED_LIST[CLASS_NAME]
			dir: DIRECTORY
			b: BOOLEAN
		do
			if not b then
				if wizard_information.compile_project then
					to_compile := TRUE
					if wizard_information.new_project then
						create dir.make (wizard_information.location)
						dir.delete_content
					end
				end
			end

			li := wizard_information.table_list
			total := li.count
			if wizard_information.new_project then	
				total := total + 8
				if is_oracle then
					total := total - 1
				end
			end
			if wizard_information.vision_example then
				total := total + 7
			else
				total := total + 2
			end
			create repositories.make
			from
				progress.set_proportion(0)
				iteration := 0
				li.start
			until
				li.after
			loop
				generate_class(li.item.table_name)
				li.forth
			end
				-- Modified by Cedric R.
			if wizard_information.new_project then
				generate_ace_file
				load_management_classes	
				load_example_classes	
				if wizard_information.vision_example then
					generate_db_interface_class
					generate_db_connection_class
				else
					generate_repositories	
					generate_example
				end				
				if to_compile then
					progress_text.set_text(" Preparing for Compilation ....")		
					if wizard_information.is_oracle then
						create ebench_launcher.make ("ace_mswin_oracle.ace", wizard_information.location, wizard_information.project_name)
					else
						create ebench_launcher.make ("ace_mswin_odbc.ace", wizard_information.location, wizard_information.project_name)
					end
					first_window.minimize
					ebench_launcher.launch
					ebench_launcher.display
				end
			end
		rescue
			b:= TRUE
			retry 
		end


feature -- Processing

	generate_class(s: STRING) is
			-- Generate class according to class whose name is 's'.
		require
			s /= Void
		local
			rep: DB_REPOSITORY
			f: PLAIN_TEXT_FILE
			f_name: FILE_NAME
			s1: STRING
			s_f: STRING
		do
			s1 := clone(s)
			s.replace_substring_all (" ","_")
			notify_user ("generating class "+s)
			create rep.make (s)
			rep.load
			repositories.extend (rep)
			create f_name.make_from_string (wizard_information.location)
			s1 := clone (s)
			s1.to_lower
			normalize (s1)
			f_name.extend (s1)
			f_name.add_extension ("e")
			create f.make_open_write (f_name)
			rep.generate_class (f)
			f.close
			create f.make_open_read_write (f_name)
			f.read_stream (f.count)
			s_f:= clone (f.last_string)
			specific_code (s_f)
			f.close
			f.wipe_out

			create f.make_open_read_write (f_name)
			f.put_string (s_f)
			f.close
			
				-- Added by Cedric R 
			if wizard_information.new_project and wizard_information.vision_example then
				create f.make_open_read_write (f_name)
				f.read_stream (f.count)
				s_f:= clone (f.last_string)
					-- Add the inheritance from 'queryable' containing tags.
				add_get_feature (s_f)
					-- Replace tags owing to rep.
				replace_tags (s_f, rep)
				f.close
				f.wipe_out
				create f.make_open_read_write (f_name)
				f.put_string (s_f)
				f.close
			end
		end

	specific_code (s: STRING) is
		local
			i1, i2, i3, i4, j1, j2: INTEGER
			new_begin_code, new_end_code, squeleton: STRING
			fi: PLAIN_TEXT_FILE
		do
			create fi.make_open_read_write (wizard_resources_path + "/" + "table_squeleton_class.e")
			fi.read_stream (fi.count)
			squeleton:= clone (fi.last_string)
			fi.close

			i1:= squeleton.substring_index ("<FL_ANCHOR_BEGIN=YES>", 1)
			new_begin_code:= "%N%N"
			i2:= squeleton.substring_index ("<FL_ANCHOR_END=YES>", 1)
			new_end_code:= "%N%N"

			i3:= s.substring_index ("create", 1)
			i4:= s.substring_index ("end --", 1)

			if  i1 /= 0 then
				j1:= squeleton.substring_index ("</FL_ANCHOR_BEGIN>", 1)
				new_begin_code:= "%N%N" + squeleton.substring (i1 + 22, j1 - 1) + "%N"
			end
			if  i2 /= 0 then
				j2:= squeleton.substring_index ("</FL_ANCHOR_END>", 1)
				new_end_code:= "%N" + squeleton.substring (i2 + 19, j2 - 1) + "%N"
			end
			
			s.replace_substring (new_begin_code, i3 - 2, i3 - 1)
			s.replace_substring (new_end_code, i4 + new_begin_code.count - 4 , i4 + new_begin_code.count - 3)

		end

	add_get_feature (s: STRING) is
			-- Add the fields enabling to inherit from 'queryable' class. 
			-- Works on a class representing a database table. Added by Cedric R.
		local
			fi: PLAIN_TEXT_FILE
			inheritance_text, new_begin_code, new_end_code: STRING
			mi, di, ti: INTEGER
		do
			create fi.make_open_read_write (wizard_resources_path + "/" + "ev_queryable_inh.e")
			fi.read_stream (fi.count)
			inheritance_text:= clone (fi.last_string)
			fi.close

			mi:= inheritance_text.substring_index ("<FL_DECL_INH_END>", 1)
			new_begin_code:= "%N%N" + inheritance_text.substring (1, mi-1) + "%N"
			new_end_code:= "%N" + inheritance_text.substring (mi + 17, inheritance_text.count) + "%N"

			di:= s.substring_index ("create", 1)
			ti:= s.substring_index ("end --", 1)
		
			s.replace_substring (new_begin_code, di - 2, di - 1)
			s.replace_substring (new_end_code, ti + new_begin_code.count - 4, ti + new_begin_code.count - 3)
		end

	replace_tags (s: STRING; rep: DB_REPOSITORY) is
			-- Works on a class representing a database table. Added by Cedric R.
			-- Replace the tags in 's' to match the columns names in the database.
			-- 'rep' enables to get the attribute names of the loaded class.
		local
			i, type_code: INTEGER
			g_replacing_string, g_repl_string_template, g_tmp: STRING
			s_replacing_string, s_repl_string_template, s_tmp: STRING
		do
			rep.column_i_th(1).column_name.to_lower
			s.replace_substring_all ("<FIRST_ATTR_NAME>", rep.column_i_th(1).column_name)
				-- Type_code represents a code for a type: this code depends on the database.
				-- This class handles generic class 'TYPES [G]' to cope with this dependency.
			type_code:= rep.column_i_th(1).eiffel_type
				-- 'match_type' replace the tags to make the conversion from 'string' to the 
				-- attribute type.
			match_type (s, type_code)
			g_repl_string_template:= "%T%T%Telseif attr.is_equal (%"<OTHER_ATTR_NAME>%") then%N%
								%%T%T%T%TResult := <OTHER_ATTR_NAME>.out%N"
			s_repl_string_template:= "%T%T%Telseif attr.is_equal (%"<OTHER_ATTR_NAME>%") then%N%
								%<FOR_DATE_TIME%N%
								%>%T%T%T%T<OTHER_ATTR_NAME> := <VALUE><CONVERSION>%N"
			create g_replacing_string.make (10)
			create s_replacing_string.make (10)
			from
					i:= 2
				until
					i > rep.column_number
				loop
					g_tmp:= clone (g_repl_string_template)
					s_tmp:= clone (s_repl_string_template)
					rep.column_i_th(i).column_name.to_lower
					g_tmp.replace_substring_all ("<OTHER_ATTR_NAME>", rep.column_i_th(i).column_name)
					s_tmp.replace_substring_all ("<OTHER_ATTR_NAME>", rep.column_i_th(i).column_name)

						-- Type_code represents a code for a type: this code depends on the database.
						-- This class handles generic class 'TYPES [G]' to cope with this dependency.
					type_code:= rep.column_i_th(i).eiffel_type
						-- 'match_type' replace the tags to make the conversion from 'string' to the 
						-- attribute type.
					match_type (s_tmp, type_code)
					g_replacing_string.append (g_tmp) 
					s_replacing_string.append (s_tmp) 
					i:= i + 1
				end
			s.replace_substring_all ("<ELSEIF_GET>", g_replacing_string)
			s.replace_substring_all ("<ELSEIF_SET>", s_replacing_string)
		end

	normalize (s: STRING) is
		do
			if s.has ('$') then
				s.replace_substring_all ("$", "")
			end
		end

	generate_repositories is
			-- Generate 'repositories' relative to the
			-- user database.
		require
			not_void : repositories /= Void
		local
			f: PLAIN_TEXT_FILE
			f_name: FILE_NAME
			s,s2,repository_name: STRING
		do
			notify_user ("generating Class REPOSITORIES ...")
			create f_name.make_from_string (wizard_information.location)
			f_name.extend ("repositories")
			f_name.add_extension ("e")
			s:= "indexing%N%Tdescription:%"Module which contains all the repositories information%""
			s.append ("%N%Nclass%N%TREPOSITORIES%N%N")
			s.append ("feature -- Access%N")
			from
				repositories.start
			until
				repositories.after
			loop
				s2:= clone(repositories.item.repository_name)
				repository_name:= clone(s2)
				repository_name.to_lower
				repository_name.replace_substring_all (" ","_")
				s.append ("%N%T"+repository_name+"_repository: DB_REPOSITORY is")
				s.append ("%N%T%T%T-- Load the repository '"+repository_name+"'")
				s.append ("%N%T%Tonce%N%T%T%Tcreate Result.make (%""+s2+"%")")
				s.append ("%N%T%T%TResult.load%N%T%Tensure%N%T%T%Tloaded: Result.loaded%N%T%Tend%N")
				repositories.forth
			end
			s.append ("%N%Nend -- Class Repositories")
			create f.make_open_write (f_name)
			f.put_string (s)
			f.close
		end

	load_management_classes is
			-- Load classes to use EiffelStore. Modified by Cedric R.
		local
			f_name: FILE_NAME
		do
			notify_user ("Importing database_manager ...")
			copy_database_manager
			notify_user ("Importing db_action ...")
			copy_class ("db_action")
			notify_user ("Importing db_shared ...")
			copy_class ("db_shared")
			notify_user ("Importing db_action_dyn ...")
			copy_class ("db_action_dyn")
			notify_user ("Importing parameter_hdl ...")
--XXX			copy_file ("parameter_hdl", "e", wizard_information.location)
			if is_odbc then
				notify_user ("Importing store_odbc.lib ...")
				copy_file ("odbc_store", "lib", wizard_information.location)
			end
		end

	load_example_classes is
			-- Load example classes including system's root class
		do
			if wizard_information.vision_example then
				copy_class ("application")
				copy_class ("main_window")
				copy_class ("select_window")
				copy_class ("sel_res_window")
				copy_class ("insert_window")
				copy_class ("queryable")
				copy_class ("my_db_info")
				copy_class("db_connection")
			else
				copy_class ("estore_example")
				copy_class ("estore_root")
			end
		end

	copy_database_manager is
		local
			f1,f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
			new_s,s: STRING
		do
			create f1.make_from_string(wizard_resources_path)
			f_name := clone(f1)
			f_name.extend("database_manager")
			f_name.add_extension("e")
			create fi.make_open_read(f_name)
			fi.read_stream(fi.count)
			s := fi.last_string
			new_s := clone (s)
			if wizard_information.is_oracle then
				new_s.replace_substring_all("<FL_HANDLE>", "ORACLE")
			else
				new_s.replace_substring_all("<FL_HANDLE>", "ODBC")
			end
			fi.close
			create f_name.make_from_string(wizard_information.location)
			f_name.extend("database_manager")
			f_name.add_extension("e")
			create fi.make_open_write(f_name)
			fi.put_string(new_s)
			fi.close
		end

	copy_class(name: STRING) is
			-- Copy Class whose name is 'name'.
		require
			name /= Void
		local
			f1,f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
			s: STRING
		do
			create f1.make_from_string(wizard_resources_path)
			f_name := clone(f1)
			f_name.extend(name)
			f_name.add_extension("e")
			create fi.make_open_read(f_name)
			fi.read_stream(fi.count)
			s := fi.last_string
			fi.close
			create f_name.make_from_string(wizard_information.location)
			f_name.extend(name)
			f_name.add_extension("e")
			create fi.make_open_write(f_name)
			fi.put_string(s)
			fi.close
		end

	copy_ace(name: STRING; path_root_class: STRING) is
			-- Copy Class whose name is 'name'.
		require
			name /= Void
		local
			f1,f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
			new_s,s: STRING
		do
			create f1.make_from_string (wizard_resources_path)
			f_name := clone (f1)
			f_name.extend (name)
			f_name.add_extension ("ace")
			create fi.make_open_read (f_name)
			fi.read_stream(fi.count)
			s := fi.last_string
			new_s := clone (s)
			new_s.replace_substring_all ("<FL_PATH>", path_root_class)
			if wizard_information.precompiled_base then
				new_s.replace_substring_all ("<FL_TAG_PRECOMPILED>","")
			else
				new_s.replace_substring_all ("<FL_TAG_PRECOMPILED>","--")
			end			
			fi.close
			create f_name.make_from_string (wizard_information.location)
			f_name.extend (name)
			f_name.add_extension ("Ace")
			create fi.make_open_write (f_name)
			fi.put_string (new_s)
			fi.close
		end

	generate_ace_file is
			-- Generate the selected Ace File. Modified by Cedric R
		do
			notify_user ("Generating Ace File...")

				-- Switch the Ace file depending on the example to generate.
			if wizard_information.vision_example then
				if wizard_information.is_oracle then
					copy_ace ("ace_mswin_vision_oracle", wizard_information.location)
				else
					copy_ace ("ace_mswin_vision_odbc", wizard_information.location)
				end
 			else
				if wizard_information.is_oracle then
					copy_ace ("Ace_mswin_oracle", wizard_information.location)
				else
					copy_ace ("Ace_mswin_odbc", wizard_information.location)
				end
			end
		end

	generate_example is
			-- Generate the simple example of use.
		local
			f1,f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
			s: STRING
			example_generator: EXAMPLE_GENERATOR 
			root_generator: ROOT_GENERATOR
		do
			notify_user ("Generating Example...")
			create example_generator.make (repositories)
			s := example_generator.result_string
			create f1.make_from_string (wizard_information.location)
			f_name := clone (f1)
			f_name.extend ("estore_example")
			f_name.add_extension ("e")
			create fi.make_open_read_append (f_name)
			fi.put_string (s)
			fi.close
			
			notify_user ("Generating Root Class...")
			create f1.make_from_string (wizard_information.location)
			f_name := clone (f1)
			f_name.extend ("estore_root")
			f_name.add_extension ("e")
			create fi.make_open_read (f_name)
			fi.read_stream (fi.count)
			s := fi.last_string
			fi.close
			create root_generator.make (example_generator,s,
					wizard_information.username,
					wizard_information.password,
					wizard_information.data_source)
			s := root_generator.result_string
			create fi.make_open_write (f_name)
			fi.put_string (s)
			fi.close
		end
	
	generate_db_interface_class is
			-- Generate the interface class enabling the graphic HCI to access data from the database.
		local
			f1,f_name: FILE_NAME
			f: PLAIN_TEXT_FILE
			s: STRING
		do
			notify_user ("Generating DB interface...")
			create f1.make_from_string (wizard_information.location)
			f_name := clone (f1)
			f_name.extend ("my_db_info")
			f_name.add_extension ("e")
			create f.make_open_read_write (f_name)
			f.read_stream (f.count)
			s:= clone (f.last_string)
				-- Replace tags owing to wizard_information.
			replace_interface_tags (s)
			f.close
			f.wipe_out
			create f.make_open_read_write (f_name)
			f.put_string (s)
			f.close
		end
			
	replace_interface_tags (s: STRING) is
			-- Replace the tags to match the user's given information (in MY_DB_INFO). Added by Cedric R.
		local
				-- Useful to map combo_box creation
			replacing_string, repl_string_template, tmp : STRING
				-- Useful to map local declarations.
			local_rs_template, local_rs, loc_tmp : STRING
				-- To change the case
			table_class : STRING
		do
			if is_oracle then
				s.replace_substring_all ("<DATABASE_NAME>", "ORACLE")
			else
				s.replace_substring_all ("<DATABASE_NAME>", "ODBC")				
			end 
			repl_string_template:= "%N%T%T%Tcreate eli.make_with_text (%"<TAG_TABLE_NAME>%")%N%
								%%T%T%Tcreate <TAG_TABLE_NAME>_obj.make%N%
								%%T%T%Teli.set_data (<TAG_TABLE_NAME>_obj)%N%
								%%T%T%Teli.select_actions.extend (~update_active_rows_cb (%"<TAG_TABLE_NAME>%"))%N%
								%%T%T%Teli.select_actions.extend (~update_active_rows_vb (%"<TAG_TABLE_NAME>%"))%N%
								%%T%T%Ttables_cb.extend (eli)%N"
			local_rs_template:= "%T%T%T<TAG_TABLE_NAME>_obj: <TAG_TABLE_CLASS>%N"
			create replacing_string.make (10)
			create local_rs.make (10)
			from
				wizard_information.table_list.start
			until
				wizard_information.table_list.after
			loop
				tmp:= clone (repl_string_template)
				loc_tmp:= clone (local_rs_template)
				tmp.replace_substring_all ("<TAG_TABLE_NAME>", wizard_information.table_list.item.table_name)
				loc_tmp.replace_substring_all ("<TAG_TABLE_NAME>", wizard_information.table_list.item.table_name)
				table_class:= clone (wizard_information.table_list.item.table_name)
				table_class.to_upper
				loc_tmp.replace_substring_all ("<TAG_TABLE_CLASS>", table_class)
				replacing_string.append (tmp)
				local_rs.append (loc_tmp)
				wizard_information.table_list.forth
			end
			s.replace_substring_all ("<TAG_CREATION_TABLES>", replacing_string)
			s.replace_substring_all ("<TAG_LOCAL_DEFINITIONS%N>", local_rs)
		end

	generate_db_connection_class is
			-- Generate the interface class enabling the graphic HCI to access data from the database.
		local
			f1,f_name: FILE_NAME
			f: PLAIN_TEXT_FILE
			s: STRING
		do
			notify_user ("Generating DB connection mapper...")
			create f1.make_from_string (wizard_information.location)
			f_name := clone (f1)
			f_name.extend ("db_connection")
			f_name.add_extension ("e")
			create f.make_open_read_write (f_name)
			f.read_stream (f.count)
			s:= clone (f.last_string)
				-- Replace tags owing to wizard_information.
			replace_db_connection_tags (s)
			f.close
			f.wipe_out
			create f.make_open_read_write (f_name)
			f.put_string (s)
			f.close
		end

	replace_db_connection_tags (s: STRING) is
			-- Replace the tags to match the user's given information. Added by Cedric R.
			-- Works on 'db_connection' class.
		do
			s.replace_substring_all ("<TAG_USERNAME>", wizard_information.username)
			s.replace_substring_all ("<TAG_PASSWORD>", wizard_information.password)
			s.replace_substring_all ("<TAG_DATA_SOURCE>", wizard_information.data_source)
		end

feature {NONE} -- Implementation
	
	match_type (s: STRING; type_code: INTEGER) is
			-- Map a piece of the 'set_feature_value' feature of a table class to the type of the attribute.
		require
			not_void: s /= Void
		do
				-- Type_code represents a code for a type: this code depends on the database.
				-- This class handles generic class 'TYPES [G]' to cope with this dependency.
				-- 'types' inherited from class 'WIZARD_SPECIFIC'.
			if type_code = types.Integer_type_database then
				s.replace_substring_all ("<FOR_DATE_TIME%N>", "")
				s.replace_substring_all ("<VALUE>", "value")
				s.replace_substring_all ("<CONVERSION>", ".to_integer")
			elseif type_code = types.Boolean_type_database then
				s.replace_substring_all ("<FOR_DATE_TIME%N>", "")
				s.replace_substring_all ("<VALUE>", "value")
				s.replace_substring_all ("<CONVERSION>", ".to_boolean")
			elseif type_code = types.Real_type_database then
				s.replace_substring_all ("<FOR_DATE_TIME%N>", "")
				s.replace_substring_all ("<VALUE>", "value")
				s.replace_substring_all ("<CONVERSION>", ".to_double")
			elseif type_code = types.Float_type_database then
				s.replace_substring_all ("<FOR_DATE_TIME%N>", "")
				s.replace_substring_all ("<VALUE>", "value")
				s.replace_substring_all ("<CONVERSION>", ".to_double")
			elseif type_code = types.String_type_database or type_code = types.Character_type_database then
--				if col.data_length = 1 then
--				s.replace_substring_all ("<FOR_DATE_TIME%N>", "")
--				s.replace_substring_all ("<VALUE>", "value")
--				else
				s.replace_substring_all ("<FOR_DATE_TIME%N>", "")
				s.replace_substring_all ("<VALUE>", "value")
				s.replace_substring_all ("<CONVERSION>", "")
--				end
			elseif type_code = types.Date_type_database then
				s.replace_substring_all ("<FOR_DATE_TIME%N>", "%T%T%T%Tcreate dt.make_now%N%
					%%T%T%T%Tdt.make_from_string_default (value)%N")
				s.replace_substring_all ("<VALUE>", "dt")
				s.replace_substring_all ("<CONVERSION>", "")
			else
				s.replace_substring_all ("<FOR_DATE_TIME%N>", "")
				s.replace_substring_all ("<VALUE>", "value")
				s.replace_substring_all ("<CONVERSION>", "")
			end
		end
		
feature  -- Implementation

	repositories: LINKED_LIST [DB_REPOSITORY]
		-- Repositories relative to Current DB.

	to_compile: BOOLEAN
		-- Is the project to be compiled ?

end -- class DB_FINISH
