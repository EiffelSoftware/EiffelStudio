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
			title.set_text ("FINAL STEP")
			message.set_text ("%TThis is the final state of the generation...%
								%%N%NClick on Finish to generate your project !!!%
								%%N%NThe wizard will copy the useful files and launch the compilation%
								%%N%NYou will then be able to open the project throught ebench to modify it.%
								%%N%N%N%NHappy Eiffeling !!!")
		end

	final_message: STRING is "All files have been successfully Generated !!!"

	build_finish is 
			-- Build user entries.
		local
			h1: EV_HORIZONTAL_BOX
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
			if wizard_information.generate_facade then	
				total := total + 8
			if is_oracle then
				total := total - 1
			end
			end
			if wizard_information.example then
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
			generate_ace_file
			if wizard_information.generate_facade then
				generate_basic_facade
			end
			if wizard_information.example then
				generate_example
			end
			progress_text.set_text(" Preparing for Compilation ....")		
				if wizard_information.is_oracle then
				create ebench_launcher.make ("ace_mswin_oracle.ace", wizard_information.location, wizard_information.project_name)
			else
				create ebench_launcher.make ("ace_mswin_odbc.ace", wizard_information.location, wizard_information.project_name)
			end
				if to_compile then
				first_window.minimize
				ebench_launcher.launch
				ebench_launcher.display
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
			s.replace_substring_all(" ","_")
			notify_user("generating class "+s)
			create rep.make(s)
			rep.load
			repositories.extend(rep)
			create f_name.make_from_string(wizard_information.location)
			s1 := clone(s)
			s1.to_lower
			normalize (s1)
			f_name.extend(s1)
			f_name.add_extension("e")
			create f.make_open_write(f_name)
			rep.generate_class(f)
			f.close
			create f.make_open_read_write(f_name)
			f.read_stream (f.count)
			s_f:= clone (f.last_string)
			specific_code (s_f)
			f.close
			f.wipe_out

			create f.make_open_read_write(f_name)
			f.put_string (s_f)
			f.close
		end

	specific_code (s: STRING) is
		local
			i1, i2, i3, i4, j1, j2: INTEGER
			new_begin_code, new_end_code, squeleton: STRING
			fi: PLAIN_TEXT_FILE
		do
			create fi.make_open_read_write(wizard_resources_path + "/" + "table_squeleton_class.e")
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

	normalize (s: STRING) is
		do
			if s.has ('$') then
				s.replace_substring_all ("$", "")
			end
		end

	generate_basic_facade is
			-- Generate basic facade.
		do
			generate_repositories	
			load_other_classes		
		end

	generate_repositories is
			-- Generate 'repositories' relative to the 
			-- user database.
		local
			f: PLAIN_TEXT_FILE
			f_name: FILE_NAME
			s,s2,repository_name: STRING
		do
			notify_user("generating Class REPOSITORIES ...")
			create f_name.make_from_string(wizard_information.location)
			f_name.extend("repositories")
			f_name.add_extension("e")
			s := "indexing%N%Tdescription:%"Module which contains all the repositories information%""
			s.append("%N%Nclass%N%TREPOSITORIES%N%N")
			s.append("feature -- Access%N")
			from
				repositories.start
			until
				repositories.after
			loop
				s2 := clone(repositories.item.repository_name)
				repository_name := clone(s2)
				repository_name.to_lower
				repository_name.replace_substring_all(" ","_")
				s.append("%N%T"+repository_name+"_repository: DB_REPOSITORY is")
				s.append("%N%T%T%T-- Load the repository '"+repository_name+"'")
				s.append("%N%T%Tonce%N%T%T%Tcreate Result.make (%""+s2+"%")")
				s.append("%N%T%T%TResult.load%N%T%Tensure%N%T%T%Tloaded: Result.loaded%N%T%Tend%N")
				repositories.forth
			end
			s.append("%N%Nend -- Class Repositories")
			create f.make_open_write(f_name)
			f.put_string(s)
			f.close
		end

	load_other_classes is
			-- Load remaining classes
		local
			f1,f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
			s: STRING
		do
			notify_user ("Importing database_manager ...")
			copy_database_manager
			notify_user ("Importing db_action ...")
			copy_class ("db_action")
			notify_user ("Importing db_shared ...")
			copy_class("db_shared")
			notify_user ("Importing db_action_dyn ...")
			copy_class ("db_action_dyn")
			notify_user ("Importing parameter_hdl ...")
			copy_file ("parameter_hdl", "e", wizard_information.location)
			if is_odbc then
				notify_user ("Importing store_odbc.lib ...")
				copy_file ("odbc_store", "lib", wizard_information.location)
			end
			if wizard_information.example then
				copy_class("estore_example")
				copy_class("estore_root")
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
			create f1.make_from_string(wizard_resources_path)
			f_name := clone(f1)
			f_name.extend(name)
			f_name.add_extension("Ace")
			create fi.make_open_read(f_name)
			fi.read_stream(fi.count)
			s := fi.last_string
			new_s := clone (s)
			new_s.replace_substring_all("<FL_PATH>", path_root_class)
			fi.close
			create f_name.make_from_string(wizard_information.location)
			f_name.extend(name)
			f_name.add_extension("Ace")
			create fi.make_open_write(f_name)
			fi.put_string(new_s)
			fi.close
		end

	generate_ace_file is
			-- Generate the selected Ace File
		local
			f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
		do
			notify_user("Generating Ace File...")
			if wizard_information.is_oracle then
				copy_ace("Ace_mswin_oracle", wizard_information.location)
			else
				copy_ace("Ace_mswin_odbc", wizard_information.location)
			end
		end

	generate_example is
			-- Generate example of use.
		local
			f1,f_name: FILE_NAME
			fi: PLAIN_TEXT_FILE
			s: STRING
			example_generator: EXAMPLE_GENERATOR 
			root_generator: ROOT_GENERATOR
		do
			notify_user("Generating Example...")
			create example_generator.make(repositories)
			s := example_generator.result_string
			create f1.make_from_string(wizard_information.location)
			f_name := clone(f1)
			f_name.extend("estore_example")
			f_name.add_extension("e")
			create fi.make_open_read_append(f_name)
			fi.put_string(s)
			fi.close
			
			notify_user("Generating Root Class...")
			create f1.make_from_string(wizard_information.location)
			f_name := clone(f1)
			f_name.extend("estore_root")
			f_name.add_extension("e")
			create fi.make_open_read(f_name)
			fi.read_stream(fi.count)
			s := fi.last_string
			fi.close
			create root_generator.make(example_generator,s,
					wizard_information.username,
					wizard_information.password,
					wizard_information.data_source)
			s := root_generator.result_string
			create fi.make_open_write(f_name)
			fi.put_string(s)
			fi.close
		end

			
feature -- Implementation


	repositories: LINKED_LIST[DB_REPOSITORY]
		-- Repositories relative to Current DB.

	to_compile: BOOLEAN
		-- is the project will be compile ?

end -- class DB_FINISH
