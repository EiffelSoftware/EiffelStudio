indexing

	description: 
		"Store a new eiffelcase project.";
	date: "$Date$";
	revision: "$Revision $"

class STORE_PROJECT 

inherit

	EC_COMMAND
	WARNING_CALLER
		redefine
			help_action
		end
	EXCEPTIONS
	SHARED_FILE_SERVER

creation
	make

feature -- Creation
	
	make (m: like main_window; p: like project_box) is
		do
			main_window := m
			project_box := p
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Store a project
			--| The `project_box' may be the `project_create_box'
			--| or the `project_save_as_box'
		local
			check_file: RAW_FILE;
			check_dir: DIRECTORY;
			dn: DIRECTORY_NAME;
			has_no_error : BOOLEAN
			last_character: CHARACTER

			warning: EV_WARNING_DIALOG
			com: EV_ROUTINE_COMMAND
		do
			if not has_no_error then 
				!! overwrite.make (false)
				project_name := project_box.directory
				if project_name = Void then
					Windows_manager.popup_error ("E2", Void, main_window)
				else
					if project_name.count >= 1
					then
						last_character	:= project_name.item	( project_name.count	)
						if last_character.is_equal	( environment.directory_separator	)
						then
							project_name.remove	( project_name.count	)
						end
					end
					!!project_dir.make (project_name);
					!!check_file.make (project_name);
					if project_dir.exists then
						!! dn.make_from_string (project_name);
						dn.extend (Environment.Casegen_name);
						!! check_dir.make (dn);
						!! check_file.make (dn);
						if check_dir.exists then
							if not check_file.is_writable then
								Windows_manager.popup_error ("E6", project_name, main_window)
							else
								warning := windows_manager.warning ("Wo", project_name, main_window)
								if warning /= Void then
									!! com.make (~create_project)
									!! overwrite.make (true)
									warning.show_ok_cancel_buttons
									warning.add_ok_command (com, overwrite)
									warning.show
								end
							end
						else
							create_project (Void, Void)
						end;
					else
						project_dir.create_dir		
						if project_dir.exists then
							create_project (Void, Void)
						else
							windows_manager.popup_error ("E6", project_name, main_window)
						end
					end
				end
			else
					Windows_manager.popup_error("E32","", main_window)
			end
		rescue
			has_no_error := TRUE
			retry
		end 

feature -- Properties

	main_window: MAIN_WINDOW

feature -- Settings

	set_save_as (s: like save_as) is
		do
			save_as := s
		end

feature {NONE} -- Implementation properties

	save_as: BOOLEAN

	overwrite: EV_ARGUMENT1 [BOOLEAN]

	project_box: EV_DIRECTORY_DIALOG

	project_name: STRING;

	project_dir: DIRECTORY;

feature {NONE} -- Implementation

	create_project (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- First store of project. 
		require
			project_box_exists: project_box /= Void
		local
			store: STORE;
			classes: HASH_TABLE [CLASS_DATA, INTEGER]


			file_name_source	: FILE_NAME
			file_name_destination	: FILE_NAME

			source	: PLAIN_TEXT_FILE
			destination	: PLAIN_TEXT_FILE
			
			root_cluster	: CLUSTER_DATA
			root_cluster_name	: STRING
		do
			--if save_as then
			--	classes := System.system_classes;
			--		from
			--			classes.start
			--		until
			--			classes.after
			--		loop
			--			classes.item_for_iteration.request_for_information;
			--			--classes.item_for_iteration.set_is_modified;
			--			classes.forth
			--		end;
			--else
				System.wipe_out;
			--end;
			Environment.set_project_directory (project_name)
			-- patch of Pascal
			--System.root_cluster.set_reversed_engineered_file_name (System.root_cluster.name)
			--System.root_cluster.set_file_name(System.root_cluster.name)
			--
			--Temporary_system_file_server.init (Environment.Storage_directory);
			--!! store.make (main_window)
			--if overwrite.first then
			--	store.set_overwrite_project
			--end;
			--store.set_save_as (save_as)
			--store.execute (Void, Void);
			--if not store.failed then
			--	main_window.update_title
			--	system.set_project_initialized;
				main_window.set_entity (System.root_cluster);
			--	--Windows.main_panel.arm_graph_toggle
			--else
			--	System.set_is_modified;
			--end;
			--if save_as then
			--	classes := System.system_classes;
			--	from
			--		classes.start
			--	until
			--		classes.after
			--	loop
			--		classes.item_for_iteration.free_information;;
			--		classes.forth
			--	end
			--end

			!! file_name_destination.make_from_string	( environment.project_directory	)

			root_cluster	:= system.root_cluster

			root_cluster_name	:= clone	( root_cluster.name )
			root_cluster_name.to_lower

			file_name_destination.extend	( root_cluster_name	)
			file_name_destination.add_extension	( "ecr"	)

			!! destination.make	( file_name_destination	)

			if	not destination.exists
			then

				!! file_name_source.make_from_string	( environment.eiffel_directory	)
				file_name_source.extend	( "eifinit"	)
				file_name_source.extend	( "case"	)
				file_name_source.extend	( "general"	)

				!! source.make	( file_name_source	)	
	
				if	source.exists
				then
					source.open_read
		
					destination.create_read_write

					from
						source.start
					until
						source.after
					loop
						source.read_line
	
						destination.put_string	( source.last_string	)
						destination.new_line
										
					end

					source.close
					destination.close
				end
			end
	
			Windows_manager.update_all
		end

feature {WARNING_WINDOW} -- Implementation

	ok_action is
		do
			if overwrite.first then
				create_project (Void, Void)
			else
		--		Windows.project_load_box.set_directory (project_name)
		--		Windows.project_load_box.popup
			end
		end;
		
	cancel_action is
		do
			if not overwrite.first then
				if save_as then
					project_box.show
				else
					project_box.show
				end
			end
		end

	help_action is
		local
			warning: EV_WARNING_DIALOG
		do
			!! overwrite.make (true)
			warning := windows_manager.warning ("We", project_name, main_window)
		end;

end -- class STORE_PROJECT
