indexing

	description: 
		"Retrieve an existing eiffelcase project.";
	date: "$Date$";
	revision: "$Revision $" 

class RETRIEVE_PROJECT 

inherit

	WARNING_CALLER;
	EV_COMMAND
	EXCEPTIONS;
	SHARED_FILE_SERVER

	ONCES

	CONSTANTS

creation
 	make, make_starter,make_recent

feature {NONE} -- Initialization

	make (m: like base_window; a_load_box : like project_load_box) is
		require
			has_box : a_load_box /= Void
		do
			for_recent := FALSE
			make_dummies
		
			base_window := m
			project_load_box := a_load_box
		ensure
			load_box_correctly_set : project_load_box = a_load_box
		end 

	make_starter ( st : STRING ) is
		local
			s : STRING
		do
			for_recent:= FALSE
			s := clone (st)
			from
			until
				s.count <1 or s.item(s.count)='\' or s.item(s.count)='/'
			loop
				s.remove(s.count)
			end	
		 	if s.count >0 then s.remove(s.count) end
			project_name := s
			for_starting := TRUE
		end

	make_recent (m: like base_window; s : STRING ) is
		do
			base_window := m
		
			make_dummies
			for_recent := TRUE
			!! pat.make(20)
			pat.append(s)
		end
	
feature -- Properties

	pat : STRING
		-- path chosen as recent project

	for_recent : BOOLEAN
		-- we load a recent project ?

	base_window: MAIN_WINDOW

	project_load_box: EV_FILE_OPEN_DIALOG

	project_name: STRING

	rescue_file: RAW_FILE

	for_starting : BOOLEAN

feature -- String operations

	extract_directory ( s : STRING ): STRING is
		-- extract the directory where s is contained
	local
		ind1,ind : INTEGER
		end_of_string	: BOOLEAN
	do

		end_of_string	:= false

		!! Result.make(20)
		from
			ind1:=0
			ind:=1
		until
			ind = 0	or
			end_of_string 
		loop
			if	ind1 < s.count
			then
				ind	:= s.index_of	( environment.directory_separator	, ind1+1	)
				if	ind > 0 
				then
					ind1	:= ind
				end
			else
				end_of_string	:= true
			end
		end
		-- the last position of '/' orr '\' is contained in ind1
		if ind1>0  then
			-- no problemo
			Result.append(s.substring(1,ind1-1))
		end
	end

	copy_file_resource	( s : STRING	) is
	local
			file_name_source	: FILE_NAME
			file_name_destination	: FILE_NAME

			source	: PLAIN_TEXT_FILE
			destination	: PLAIN_TEXT_FILE

	do
		!! file_name_destination.make_from_string	( s	)

		!! destination.make	( file_name_destination	)

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

	has_good_extension ( st : STRING ): BOOLEAN is
		-- check the .ecr extension
	local
		ind, ind1 : INTEGER
		s : STRING
	do
		if st.count>4 then	
			s:= st.substring(st.count-3,st.count)
			if s.is_equal (".ecr") then
				Result := TRUE
			end
		end
	end

	no_file_name	( s : STRING	) : BOOLEAN	is
		-- The String is the Path Name + The File Name
		-- String = Path Name + Directory Separator + File Name
		-- An Empty File Name is equivalent to 
		-- the Last Character of the String is the Directory Separator
	do
		if	s /= void
		then
			Result	:= is_directory_separator	( s.item	( s.count	) )
		else
			Result	:= true
		end
	end

	is_directory_separator	( c : CHARACTER	) : BOOLEAN	is
	do
		if	c /= void
		then
			Result	:= c.is_equal	( environment.directory_separator	)
		else
			Result	:= false
		end
	end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA)  is
			-- Retrieve a project.
		local
			recent_files	: RECENT_FILES_LIST

			directory: STRING
			project: STRING
		do
			rescued := False;
			rescue_file := Void;

			if not system.change_view_selected then

				if not for_recent then
					if project_load_box /= Void then
						directory := project_load_box.directory
						project := clone (directory)
						project.append (project_load_box.file_name)
					end
				else
					directory := extract_directory (pat)
					project := pat
				end

				if is_case_project (directory) and not no_file_name (project) and not for_recent 
				then
					!! recent_files.add_project_name	(project)
				end

				retrieve (project)
			else
				project_name := system.current_directory
				load_a_view
			end

			--workareas.update_drawing
			for_starting := FALSE
	end -- execute


	retrieve ( project_file_name : STRING ) is
	local
		file_name	: FILE_NAME
		file	: PLAIN_TEXT_FILE
	do
		project_name := extract_directory	( project_file_name	)
		if project_name.item (project_name.count) = Environment.directory_separator then
			project_name.head (project_name.count - 1)
		end

		if not is_case_project (project_name) or no_file_name	( project_file_name	)
		then
			--Windows.error(Windows.main_graph_window, "Er", Void)
			--Windows.warning	( Windows.main_graph_window	, Message_keys.valid_proj_name_wa	, project_file_name	, Current	)
		else
			environment.set_preference_file_name	( project_file_name	)
			system.set_current_directory (project_file_name)
			system.set_project_initialized

			!! file_name.make_from_string	( project_file_name	)
			!! file.make	( file_name	)

			if	file.empty
			then
				copy_file_resource	( project_file_name	)
			end

			load_a_view

		end
	end

feature {WARNING_WINDOW} -- Implementation

	ok_action is
		do
			--Windows.set_watch_cursor
			--if not Windows.change_view_selected then
			    if rescue_file = Void then
					--if project_load_box = Void then
					--	project_load_box := windows_manager.open_file_browser ()
					--end
					if project_load_box /= Void then
						--if project_load_box.is_popped_up then
								--project_load_box.popdown
						--end
						--project_load_box.popup  -- re-added pascalf
					end
					--project_name := Void;
				else
					retrieve_rescued_project;
					initialize_session;
				end
			--end
		--	Windows.restore_cursor
		end

	cancel_action is
		do
		--	Windows.set_watch_cursor
			if rescue_file = Void then
				if project_load_box /= Void then
					--project_load_box.popdown
				end
				project_name := Void;
			else
				load_a_view
			end;
		--	Windows.restore_cursor
		end 

feature {VIEW_SELECTOR,VIEW_PAGE} -- Implementation properties

	load_project (a_view_id: INTEGER) is
		local
			system_file: RAW_FILE;
			system_file_name: FILE_NAME;
			file: RAW_FILE;
			storage_path: DIRECTORY_NAME;
			view_file: RAW_FILE;
			view_file_name: FILE_NAME;
			can_be_rescued: BOOLEAN;
			rescue_file_name: FILE_NAME;
			tmp: STRING;
		do
			!! file.make (clone (project_name))
			if file.exists and then file.is_directory and then 
				file.is_readable and then ecr_file_exists
			then
				tmp := clone (project_name)
				tmp.extend (Environment.directory_separator)
				tmp.append (Environment.storage_relative_directory)
				!! storage_path.make_from_string (clone(tmp))
				!! system_file_name.make_from_string (tmp);
				system_file_name.set_file_name (Environment.system_name);
				!! system_file.make (system_file_name);
				if system_file.exists and then 
					system_file.is_readable 
				then
					if a_view_id = 0 then
						retrieve_from_disk (system_file, Void, storage_path);
					   	initialize_session;
					else
						if rescue_file = Void then
							tmp := clone(project_name)
							tmp.extend (Environment.directory_separator)
							tmp.append (Environment.restore_relative_directory);
							tmp.extend (Environment.directory_separator)
							tmp.append (Environment.view_name);
							tmp.append_integer (a_view_id);
							!! rescue_file_name.make_from_string (tmp);
							!! rescue_file.make (rescue_file_name);
							if rescue_file.exists and then 
								rescue_file.is_readable and then
								rescue_file.date >= system_file.date
							then
								can_be_rescued := True;
							--	Windows.warning (Windows.main_graph_window,
						--		Message_keys.rescue_proj_wa, Void, Current);
							else
								rescue_file := Void;
							end
						end;
						if not can_be_rescued then
							rescue_file := Void;
							!! view_file_name.make_from_string (project_name);
							tmp := clone (view_file_name)
							tmp.extend (Environment.directory_separator)
							tmp.append (Environment.view_relative_file_name);
							tmp.append_integer (a_view_id);
							!! view_file.make (tmp);
							if view_file.exists and then view_file.is_readable then
								retrieve_from_disk (system_file, view_file, storage_path);
								initialize_session
							else
							--	Windows.warning (Windows.main_graph_window, Message_keys.read_file_wa, view_file_name, Current)
							end
						end						

						--Workareas.refresh -- added by pascalf
					end
				else
				--	Windows.warning (Windows.main_graph_window, Message_keys.read_file_wa, system_file_name, Current)
				end
			else
			--	Windows.warning (Windows.main_graph_window, Message_keys.read_project_wa, project_name, Current)
			end	
			if base_window /= Void then
				base_window.set_entity (system.root_cluster)
			end
		end;

	set_project_name (p: like project_name) is
		do
			project_name := p
		end

feature {NONE} -- Implementation Properties

	ecr_file_exists:BOOLEAN is
			-- Check that the selected file complies to Ecase requirements
		local
			fi: PLAIN_TEXT_FILE
			fn : FILE_NAME
			st: STRING
			err: BOOLEAN
		do
			if not err then
				if pat/= Void then
					!! fn.make
					fn.extend(pat)
					!! fi.make(fn)
					fi.open_read
					if fi.exists and then fi.is_open_read then
						fi.read_line
						st := clone (fi.last_string)
						fi.close
						st.to_upper
						if st /= Void and then st.count>5 and then st.substring(1,5).is_equal("ECASE") then
							Result := TRUE
						end
					end
				else
					Result := TRUE -- Change View
				end
			end
		rescue
			err := TRUE
			retry 
		end

	is_case_project (path: STRING): BOOLEAN is
		require
			path_exists: path /= Void
		local
			dir_name: DIRECTORY_NAME
			dir: DIRECTORY
			str: STRING
		do
			!! dir_name.make_from_string (path)
			if dir_name.is_valid then
				str := clone (Environment.Casegen_name)
				dir_name.extend (str)
				if dir_name.is_valid then
					!! dir.make (dir_name)
					Result := dir.exists
				end
			end
		end

--	view_selector: VIEW_SELECTOR
			-- View selector window

feature {NONE} -- Implementation

	load_a_view is
			-- Select a specific view and pload the project
		local
			system_view_list: SYSTEM_VIEW_LIST;
			system_view_info: SYSTEM_VIEW_INFO;
			file: RAW_FILE;
			p_name: PROJECT_NAME;
			view_file_name: STRING
			view_tool: VIEW_TOOL
		do
			view_file_name := clone	(project_name)
			view_file_name.extend (Environment.directory_separator)
			view_file_name.append (Environment.View_relative_file_name)
			!! file.make (view_file_name)
			if file.exists and then file.is_readable then
				system_view_list ?= System.retrieve_view_list_with_file (file);
			end
			if system_view_list = Void or else system_view_list.empty then
				load_project (0)
			elseif system_view_list.count = 1 then
				load_project (system_view_list.first.view_id)
			else
				!! view_tool.make_selector (base_window,Current,system_view_list)
			end
		end

	rescued: BOOLEAN;

	retrieve_from_disk (file, view_file: RAW_FILE; path: STRING) is
			-- Retrieve project from disk according 
			-- to `retrieve_port'.
		require
			file_exists: file.exists;
			file_readable: file.is_readable;
			valid_path: path /= Void;
			view_file_exists: view_file /= Void implies view_file.exists;
			view_file_readable: view_file /= Void implies view_file.is_readable;
		local
			system_view: SYSTEM_VIEW
		do
			if not rescued then
				--Windows.set_watch_cursor;
				if view_file = Void then
					!! system_view.make (System);
					view_information.set_is_new_view;
					System.retrieve_project_with_view (file, path, system_view);
				else
					System.retrieve_project_with_view_file (file, view_file, path);
				end
			end
		rescue
			if original_exception = Operating_system_exception and then
				original_tag_name /= Void
			then
				--Windows.error (Windows.main_graph_window, Message_keys.retrieve_operating_system_er, original_tag_name)
			else
				--Windows.error (Windows.main_graph_window, Message_keys.retrieve_proj_er, project_name)
			end;
			--Windows.restore_cursor;
			rescued := True;
			rescue_file := Void;
			project_name := Void;
			retry
		end;

	initialize_session is
		do
			if not rescued then
					-- Able to retrieve system
				--Windows.main_graph_window.set_project_initialized;
				if rescue_file = Void then
						-- (Not retrieving rescued project).
						-- Create initial directory so that the
						-- view information can be stored
					Environment.set_project_directory (project_name);
					Temporary_system_file_server.init 	
						(Environment.Storage_directory);
					Environment.create_initial_directories;
					System.update_view_list;
						-- Eiffel Case hasn't been initialized
			--		Windows_manager.main_window.update_from(System.root_cluster)
					--Windows.main_graph_window.set_saved;
				else
					--Windows.main_graph_window.set_not_saved;
				end;
				--Windows.main_graph_window.update_title;
				--Windows.main_graph_window.set_entity (System.root_cluster);
				--Windows.update_view_window;
				--Windows.main_panel.arm_graph_toggle; -- pascalf
				--Windows.update_displayed_windows;
				project_name := Void
				Resources.initialize
			else
				--Windows.main_panel.set_title ("EiffelCase") pascalf
			end
		end;

	retrieve_rescued_project is
		require
			non_void_rescue_file: rescue_file /= Void;
			valid_rescue_file: rescue_file.exists and then	
						rescue_file.is_readable
		local
			rescue_info: RESCUE_INFO;
			storable: STORABLE;
			c_data: CLASS_DATA;
			classes: ARRAYED_LIST [CLASS_DATA]
		do
--			if not rescued then
--				--windows.main_graph_window.set_title ("Retrieving crashed project...") pascalf
--				Windows.set_watch_cursor;
--				!! storable;
--				rescue_file.open_read;
--				rescue_info ?= storable.retrieved (rescue_file);
--				check
--					valid_rescue_info: rescue_info /= Void
--				end;
--				rescue_file.close;
--				System.wipe_out;
--				Environment.set_project_directory (project_name);
--				System.update_from (rescue_info.system_data);
--				Windows.restore_cursor;
--				Temporary_system_file_server.init (Environment.Storage_directory);
--				classes := rescue_info.classes;
--				from
--					classes.start
--				until
--					classes.after
--				loop
--					c_data := classes.item;
--					if c_data /= Void then
--						Class_content_server.tmp_save_class (c_data);
--						c_data.reset_content
--					end;
--					classes.forth
--				end;
--			end
--		rescue
--			if original_exception = Operating_system_exception then
--			--	Windows.error (Windows.main_graph_window,
--			--						Message_keys.retrieve_operating_system_er,
--			--						original_tag_name)
--			else
--			--	Windows.error (Windows.main_graph_window,
--			--						Message_keys.rescue_er,
--			--						rescue_file.name)
--			end;
--			Windows.restore_cursor;
--			rescued := True;
--			rescue_file := Void
--			project_name := Void;
--			retry;
		end;


feature {NONE} -- Compatibility implementation

	--dummy_all: EXPORT_ALL_I
	--dummy_none: EXPORT_NONE_I
	--dummy_s_all: S_EXPORT_ALL_I
	--dummy_s_none: S_EXPORT_NONE_I

	--dummy_r331 : S_FEATURE_DATA_R331
	--dummy_new: S_NEW_FEATURE_DATA
	--dummy_deleted: S_DELETED_FEATURE_DATA

	make_dummies is
			--| dummies: for compatibility with 3.3.7 only;
			--| necessary for storage/retrieval
		once
		--	!! dummy_all
		--	!! dummy_none
		--	!! dummy_s_all
		--	!! dummy_s_none
--
	--		!! dummy_r331.make ("dummy_r331")
	--		!! dummy_new.make ("dummy_new")
	--		!! dummy_deleted.make ("dummy_deleted")
		end

end -- class RETRIEVE_PROJECT
