indexing
	description: "Last page, the trace of the operation is displayed."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_FINISH


inherit
	STATE_WINDOW
		redefine
			proceed_with_current_info,
			make
		end

creation
	make

feature -- Initialization

	make (an_info: like state_information) is
			-- Initialize with 'an_info'
		do
			is_final_state := TRUE
			precursor(an_info)
		end

feature -- basic Operations

	display is 
			-- Display user entries
		do
			build
			launch_operations
		end

	build is 
			-- Build user entries.
		local
			h1: EV_HORIZONTAL_BOX
		do
			Create progress 
			progress.set_minimum_height(20)
			progress.set_minimum_width(100)
			Create progress_text
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(progress)
			main_box.disable_child_expand(progress)
			main_box.extend(progress_text)
			main_box.extend(Create {EV_HORIZONTAL_BOX})
		end

	launch_operations is
		local
			li: LINKED_LIST[CLASS_NAME]
		do
			li := state_information.table_list
			total := li.count
			if state_information.generate_facade then
				total := total + 6
			end
			if state_information.example then
				total := total + 1
			end
			Create repositories.make
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
			if state_information.generate_facade then
				generate_basic_facade
			end
			if state_information.example then
				generate_example
			end
			progress_text.set_text(" ")
		end

	proceed_with_current_info is 
			-- Process user entries
		do 
			precursor
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
		do
			s1 := clone(s)
			s.replace_substring_all(" ","_")
			notify_user("generating class "+s)
			Create rep.make(s)
			rep.load
			repositories.extend(rep)
			Create f_name.make_from_string(state_information.location)
			s1 := clone(s)
			s1.to_lower
			f_name.extend(s1)
			f_name.add_extension("e")
			Create f.make_open_write(f_name)
			rep.generate_class(f)
			f.close
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
			Create f_name.make_from_string(state_information.location)
			f_name.extend("repositories")
			f_name.add_extension("e")
			s := "indexing%N%Tdescription:%"Module which contains all the repositories information%""
			s.append("%N%Nclass%N%T%TREPOSITORIES%N%N")
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
				s.append("%N%T%Tonce%N%T%T%TCreate Result.make(%""+s2+"%")")
				s.append("%N%T%T%TResult.load%N%T%Tensure%N%T%T%Tloaded: Result.loaded%N%T%Tend%N")
				repositories.forth
			end
			s.append("%N%Nend -- Class Repositories")
			Create f.make_open_write(f_name)
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
			notify_user("Importing database_manager ...")
			copy_database_manager
			notify_user("Importing db_action ...")
			copy_class("db_action")
			notify_user("Importing db_shared ...")
			copy_class("db_shared")
			notify_user("Importing db_action_dyn ...")
			copy_class("db_action_dyn")
			if state_information.example then
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
			Create f1.make_from_string(wizard_resources_path)
			f_name := clone(f1)
			f_name.extend("database_manager")
			f_name.add_extension("e")
			Create fi.make_open_read(f_name)
			fi.read_stream(fi.count)
			s := fi.last_string
			new_s := clone (s)
			if state_information.is_oracle then
				new_s.replace_substring_all("<FL_HANDLE>", "ORACLE")
			else
				new_s.replace_substring_all("<FL_HANDLE>", "ODBC")
			end
			fi.close
			Create f_name.make_from_string(state_information.location)
			f_name.extend("database_manager")
			f_name.add_extension("e")
			Create fi.make_open_write(f_name)
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
			Create f1.make_from_string(wizard_resources_path)
			f_name := clone(f1)
			f_name.extend(name)
			f_name.add_extension("e")
			Create fi.make_open_read(f_name)
			fi.read_stream(fi.count)
			s := fi.last_string
			fi.close
			Create f_name.make_from_string(state_information.location)
			f_name.extend(name)
			f_name.add_extension("e")
			Create fi.make_open_write(f_name)
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
			Create f1.make_from_string(wizard_resources_path)
			f_name := clone(f1)
			f_name.extend(name)
			f_name.add_extension("Ace")
			Create fi.make_open_read(f_name)
			fi.read_stream(fi.count)
			s := fi.last_string
			new_s := clone (s)
			new_s.replace_substring_all("<FL_PATH>", path_root_class)
			fi.close
			Create f_name.make_from_string(state_information.location)
			f_name.extend(name)
			f_name.add_extension("Ace")
			Create fi.make_open_write(f_name)
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
			if state_information.is_oracle then
				copy_ace("Ace_mswin_oracle", state_information.location)
			else
				copy_ace("Ace_mswin_odbc", state_information.location)
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
			Create example_generator.make(repositories)
			s := example_generator.result_string
			Create f1.make_from_string(state_information.location)
			f_name := clone(f1)
			f_name.extend("estore_example")
			f_name.add_extension("e")
			Create fi.make_open_read_append(f_name)
			fi.put_string(s)
			fi.close
			
			notify_user("Generating Root Class...")
			Create f1.make_from_string(state_information.location)
			f_name := clone(f1)
			f_name.extend("estore_root")
			f_name.add_extension("e")
			Create fi.make_open_read(f_name)
			fi.read_stream(fi.count)
			s := fi.last_string
			fi.close
			Create root_generator.make(example_generator,s,
					state_information.username,
					state_information.password,
					state_information.data_source)
			s := root_generator.result_string
			Create fi.make_open_write(f_name)
			fi.put_string(s)
			fi.close
		end

feature -- Output

	notify_user(s: STRING) is
			-- Output
		require
			not_void: s /= Void
		do
			progress_text.set_text(s)
			iteration := iteration + 1
			progress.set_proportion(iteration/total)
		end
			
feature -- Implementation

	progress_text: EV_LABEL

	progress: EV_HORIZONTAL_PROGRESS_BAR

	--resource_path: STRING is "c:\development\eiffelweb_wizard\estore1\resources"

	repositories: LINKED_LIST[DB_REPOSITORY]
		-- Repositories relative to Current DB.

	total,iteration: INTEGER

end -- class DB_FINISH
