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
			send_errors
			Precursor
				-- FIXME: `Precursor' should be used but there is a bug in EiffelVision2.
	--		entries_changed := False
	--		current_application.destroy
				--
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

	pixmap_icon_location: FILE_NAME is 
			--
		do
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end

	build_finish is 
			-- Build user entries.
		do
			choice_box.wipe_out
			choice_box.set_border_width (10)
			create progress 
			progress.set_minimum_height (20)
			progress.set_minimum_width (100)
			create progress_text
			choice_box.extend (create {EV_CELL})
			choice_box.extend (progress)
			choice_box.disable_item_expand (progress)
			choice_box.extend (progress_text)
			choice_box.extend (create {EV_CELL})

			choice_box.set_background_color (white_color)
			progress.set_background_color (white_color)
			progress_text.set_background_color (white_color)
			choice_box.show
		end

	launch_operations is
			-- Generate the classes and the example. Modified by Cedric R.
		local
			li: ARRAYED_LIST [CLASS_NAME]
			b: BOOLEAN
			class_number: INTEGER
			s: STRING
			rep: DB_REPOSITORY
		do
			if not b then
				if wizard_information.compile_project then
					to_compile := True
					if wizard_information.new_project then
						setup_directory
					end
				end
			end

			li := wizard_information.table_list
				-- 2 classes are generated for a db table.
			total := li.count
			if wizard_information.new_project then	
				total := total + 8
				if is_oracle (wizard_information.dbms_code) then
					total := total - 1
				end
			end
			if wizard_information.vision_example then
				total := total + 7
			else
				total := total + 2
			end
			create repositories.make (10)
			create table_class_generator
			initialize_table_constraints_generator
			template_db_table_content := retrieve_resource_file_content (Template_db_table_name)
			template_db_table_descr_content := retrieve_resource_file_content (Template_db_table_descr_name)
			from
				progress.set_proportion (0)
				iteration := 0
				li.start
				class_number := 1
			until
				li.after
			loop
				s := clone (li.item.table_name)
				s.replace_substring_all (" ","_")
				notify_user ("generating class " + s)
				create rep.make (s)
				rep.load
				if rep.exists then
					repositories.extend (rep)
					generate_class (rep, class_number, Container_type)
					generate_class (rep, class_number, Description_type)
					class_number := class_number + 1
				end
				li.forth
			end
			generate_access_class
			copy_class ("db_specific_tables_access_use")
			
				-- Modified by Cedric R.
			if wizard_information.new_project then
				generate_ace_file
				load_management_classes	
				load_example_classes	
				if wizard_information.vision_example then
					generate_db_interface_class
				else
					generate_repositories	
					generate_example
				end				
				if to_compile then
					progress_text.set_text (" Preparing for Compilation ...")		
					if is_oracle (wizard_information.dbms_code) then
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


feature {NONE} -- Processing

	setup_directory is
			-- Setup directory to create the project.
			-- Delete EIFGEN directory and *.epr files.
		local
			fn: DIRECTORY_NAME
			dir: DIRECTORY
			rescued: BOOLEAN
		do
			if not rescued then
				create fn.make_from_string (wizard_information.location)
				fn.extend ("EIFGEN")
				create dir.make (fn)
				if dir.exists then
					dir.delete_content
					dir.delete
				end
			else
				to_compile := False
				add_error ("The project directory cannot be correctly set up %Nto compile your project. Please compile your %
						%project manually.%N")
			end
		rescue
			rescued := True
			retry
		end

	add_error (mess: STRING) is
			-- Inform the user of a problem that occured
			-- during operations.
		require
			not_void: mess /= Void
		do
			if warning_list = Void then
				create warning_list.make (5)
			end
			warning_list.extend (mess)
		end

	warning_list: ARRAYED_LIST [STRING]
			-- Warning messages list.

	send_errors is
			-- Sends a report on the errors occured to the user.
		local
			dialog: EV_WARNING_DIALOG
			mess: STRING
		do
			if warning_list /= Void and then not warning_list.is_empty then
				mess := "Errors occured during the process.%NPlease read the following error report:%N%N"
				from
					warning_list.start
				until
					warning_list.after
				loop
					mess.append ("* " + warning_list.item + "%N")
					warning_list.forth
				end
				create dialog.make_with_text (mess)
				dialog.show_modal_to_window (first_window)
			end
		end

	initialize_table_constraints_generator is
			-- Initialize `table_constraints_generator'.
		local
			li: ARRAYED_LIST [CLASS_NAME]
			scope_tables: ARRAYED_LIST [STRING]
			tmp: STRING
		do
			create table_constraints_generator.make (wizard_information.dbms_code)
			li := wizard_information.table_list
			from
				li.start
				create scope_tables.make (li.count)
			until
				li.after
			loop
				tmp := clone (li.item.table_name)
				tmp.to_upper
				scope_tables.extend (tmp)
				li.forth
			end
			table_constraints_generator.set_scope_tables (scope_tables)
		end

	generate_access_class is
			-- Generate class enabling to access database table class descriptions.
		local
			access_class_generator: DB_ACCESS_CLASS_GENERATOR
				-- Tool used to generate class giving access to database table
				-- description classes.
			template_db_table_access_content: STRING
				-- Content of the resource template for the class enabling access
				-- to database table descriptions.
		do
			create access_class_generator
			template_db_table_access_content := retrieve_resource_file_content (Template_db_table_access_name)
			if template_db_table_access_content /= Void then
				access_class_generator.set_template_content (template_db_table_access_content)
				access_class_generator.set_table_names (repositories)
				access_class_generator.generate_file
				generate_file (Template_db_table_access_name, access_class_generator.generated_file_content)
			else
				-- Add error handling.
			end
		end
		
	generate_class (rep: DB_REPOSITORY; class_number: INTEGER; generation_type: INTEGER) is
			-- Generate class according to class whose name is `s'.
		require
			repository_not_void: rep /= Void
		local
			filename: STRING
			generated_class_content: STRING
			template, suffix: STRING
		do
			if generation_type = Container_type then
				template := template_db_table_content
				suffix := Db_table_suffix
			elseif generation_type = Description_type then
				template := template_db_table_descr_content
				suffix := Db_table_descr_suffix
			else
				check
					valid_generation_type: False
				end
			end
			table_class_generator.set_template_content (template)
			table_class_generator.set_table_description (rep)
			table_class_generator.generate_file
			if table_class_generator.is_ok then
				generated_class_content := table_class_generator.generated_file_content
				generated_class_content.replace_substring_all (Class_number_tag, class_number.out)
				if generation_type = Description_type then
					table_constraints_generator.set_repository (rep)
					table_constraints_generator.generate
					generated_class_content.replace_substring_all (Id_code_tag, table_constraints_generator.id_name)
					generated_class_content.replace_substring_all (To_create_htable_tag, table_constraints_generator.to_create_htable)
					generated_class_content.replace_substring_all (To_delete_htable_tag, table_constraints_generator.to_delete_htable)
				end
				filename := clone (rep.repository_name)
				filename.to_lower
				filename.append (suffix)
				generate_file (filename, generated_class_content)
			end
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
			rescued: BOOLEAN
		do
			if not rescued then
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
					s2:= clone (repositories.item.repository_name)
					repository_name:= clone (s2)
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
			else
				add_error ("Cannot generate repository class.%N")
			end
		rescue
			rescued := True
			retry
		end

	load_management_classes is
			-- Load classes to use EiffelStore. Modified by Cedric R.
		do
			if not wizard_information.vision_example then
				notify_user ("Importing db_shared ...")
				copy_db_shared
			end
			if is_odbc (wizard_information.dbms_code) then
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
				copy_class ("table_window")
				copy_class ("status_window")
				copy_class ("specific_factory")
				copy_class ("shared")
			else
				copy_class ("estore_example")
				copy_class ("estore_root")
			end
		end

	copy_db_shared is
		local
			f1,f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
			new_s,s: STRING
			rescued: BOOLEAN
		do
			if not rescued then
				create f1.make_from_string (wizard_resources_path)
				f_name := clone (f1)
				f_name.extend ("db_shared")
				f_name.add_extension ("e")
				create fi.make_open_read (f_name)
				fi.read_stream (fi.count)
				s := fi.last_string
				new_s := clone (s)
				if is_oracle (wizard_information.dbms_code) then
					new_s.replace_substring_all ("<FL_HANDLE>", "ORACLE")
				else
					new_s.replace_substring_all ("<FL_HANDLE>", "ODBC")
				end
				fi.close
				create f_name.make_from_string (wizard_information.location)
				f_name.extend ("db_shared")
				f_name.add_extension ("e")
				create fi.make_open_write (f_name)
				fi.put_string (new_s)
				fi.close
			else
				add_error ("Could not generate 'db_shared.e' class.")
			end
		rescue
			rescued := True
			retry
		end

	copy_class (name: STRING) is
			-- Copy Class whose name is 'name'.
		require
			name /= Void
		local
			f1,f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
			s: STRING
			rescued: BOOLEAN
		do
			if not rescued then
				create f1.make_from_string (wizard_resources_path)
				f_name := clone (f1)
				f_name.extend (name)
				f_name.add_extension ("e")
				create fi.make_open_read (f_name)
				fi.read_stream (fi.count)
				s := fi.last_string
				fi.close
				create f_name.make_from_string (wizard_information.location)
				f_name.extend (name)
				f_name.add_extension ("e")
				create fi.make_open_write (f_name)
				fi.put_string (s)
				fi.close
			else
				add_error ("Class '" + name + "' could not be generated.")
			end
		rescue
			rescued := True
			retry
		end

	copy_ace (name: STRING; path_root_class: STRING) is
			-- Copy Class whose name is 'name'.
		require
			name /= Void
		local
			f1,f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
			new_s,s: STRING
			rescued: BOOLEAN
		do
			if not rescued then
				create f1.make_from_string (wizard_resources_path)
				f_name := clone (f1)
				f_name.extend (name)
				f_name.add_extension ("ace")
				create fi.make_open_read (f_name)
				fi.read_stream (fi.count)
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
			else
				add_error ("File '" + name + "' could not be generated.")
			end
		rescue
			rescued := True
			retry
		end

	generate_ace_file is
			-- Generate the selected Ace File. Modified by Cedric R
		do
			notify_user ("Generating Ace File...")

				-- Switch the Ace file depending on the example to generate.
			if wizard_information.vision_example then
				if is_oracle (wizard_information.dbms_code) then
					copy_ace ("ace_mswin_vision_oracle", wizard_information.location)
				elseif is_odbc (wizard_information.dbms_code) then
					copy_ace ("ace_mswin_vision_odbc", wizard_information.location)
				end
 			else
				if is_oracle (wizard_information.dbms_code) then
					copy_ace ("Ace_mswin_oracle", wizard_information.location)
				elseif is_odbc (wizard_information.dbms_code) then
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
			rescued: BOOLEAN
		do
			if not rescued then
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
			else
				add_error ("Could not generate simple example classes.%N")
			end
		rescue
			rescued := True
			retry
		end
	
	generate_db_interface_class is
			-- Generate the interface class enabling the graphic HCI to access data from the database.
		local
			f1,f_name: FILE_NAME
			f: PLAIN_TEXT_FILE
			s: STRING
			rescued: BOOLEAN
		do
			if not rescued then
				notify_user ("Generating SHARED class...")
				create f1.make_from_string (wizard_information.location)
				f_name := clone (f1)
				f_name.extend ("shared")
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
			else
				add_error ("Could not generate SHARED class%N")
			end
		rescue
			rescued := True
			retry
		end
			
	replace_interface_tags (s: STRING) is
			-- Replace the tags to match the user's given information (in MY_DB_INFO). Added by Cedric R.
		local
				-- Useful to map combo box creation.
			replacing_string, repl_string_template, tmp : STRING
				-- Useful to map local declarations.
			local_rs_template, local_rs, loc_tmp : STRING
				-- To change the case
			table_class : STRING
		do
			if is_oracle (wizard_information.dbms_code) then
				s.replace_substring_all ("<FL_HANDLE>", "ORACLE")
			elseif is_odbc (wizard_information.dbms_code) then
				s.replace_substring_all ("<FL_HANDLE>", "ODBC")				
			end 
			replace_db_connection_tags (s)
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

	repositories: ARRAYED_LIST [DB_REPOSITORY]
		-- Repositories relative to Current DB.

	to_compile: BOOLEAN
		-- Is the project to be compiled ?

	Template_db_table_name: STRING is "template_db_table.e"
		-- Name of the resource template for the class storing information
		-- on a table row (of a specific database table).

	Template_db_table_descr_name: STRING is "template_db_table_descr.e"
		-- Name of the resource template for the class containing information
		-- on a specific database table.

	Template_db_table_access_name: STRING is "db_specific_tables_access.e"
		-- Name of the resource template for the class enabling access
		-- to database table descriptions.

	template_db_table_content: STRING
		-- Content of the resource template for the class storing information
		-- on a table row (of a specific database table).

	template_db_table_descr_content: STRING
		-- Content of the resource template for the class containing information
		-- on a specific database table.

	Db_table_suffix: STRING is ".e"
		-- Suffix for the class storing information
		-- on a table row (of a specific database table).

	Db_table_descr_suffix: STRING is "_description.e"
		-- Suffix for the class containing information
		-- on a specific database table.

	Class_number_tag: STRING is "<CI>"
		-- Tag representing class number.

	Id_code_tag: STRING is "<IC>"
		-- Tag representing ID code.
		
	To_create_htable_tag: STRING is "<CH>"
		-- Tag representing content of hash table enabling
		-- to create table rows.
		
	To_delete_htable_tag: STRING is "<DH>"
		-- Tag representing content of hash table enabling
		-- to delete table rows.
		
	Container_type: INTEGER is 1
		-- Type of generation for `generate_class':
		-- class to generate carries values of corresponding database table rows.

	Description_type: INTEGER is 2
		-- Type of generation for `generate_class':
		-- class to generate carries description and access features of
		-- corresponding database table.

	table_class_generator: DB_TABLE_CLASS_GENERATOR
		-- Generates classes related to a specific database table.

	table_constraints_generator: TABLE_CONSTRAINTS_GENERATOR
		-- Generates specific table constraints description.
		
	retrieve_resource_file_content (file_name: STRING): STRING is
			-- Return content of resource file named `file_name'.
		require
			not_void: file_name /= Void
		local
			f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
			rescued: BOOLEAN
		do
			if not rescued then
				create f_name.make_from_string (wizard_resources_path)
				f_name.set_file_name (file_name)
				create fi.make (f_name)
				if fi.exists and then fi.is_readable then
					fi.open_read
					fi.read_stream (fi.count)
					Result := clone (fi.last_string)
					fi.close
				else
					add_error ("File '" + file_name + "' does not exist or is unreadable.%N")
				 	Result := ""
				end
			else
				add_error ("Cannot retrieve content of file: " + file_name + "%N")
			end
		ensure
			Result_not_void: Result /= Void
		rescue
			rescued := True
			retry
		end
		
	generate_file (file_name, file_content: STRING) is
			-- Generate `file_name' at location indicated by the
			-- user. Fill file with `file_content'.
		local
			f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
			rescued: BOOLEAN
		do
			if not rescued then
				create f_name.make_from_string (wizard_information.location)
				f_name.set_file_name (file_name)
				create fi.make (f_name)
				if fi.exists then
					fi.wipe_out
					fi.open_write
				else
					fi.open_append
				end
				fi.putstring (file_content)
				fi.close
			else
				add_error ("Cannot generate file: " + file_name + "%N")
			end
		rescue
			rescued := True
			retry
		end
		
	copy_file (name, extension, destination: STRING) is
			-- Copy resource class whose name is `name' and `extension'
			-- to `destination'.
		require
			name_exists: name /= Void
		local
			f1, f_name: FILE_NAME
			fi: RAW_FILE
			s: STRING
			rescued: BOOLEAN
		do
			if not rescued then
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
			else
				add_error ("Cannot generate file: " + name + "%N")
			end
		rescue
			rescued := True
			retry
		end

end -- class DB_FINISH
