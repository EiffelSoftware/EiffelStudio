indexing

	description: 
		"Store/Save current EiffelCase project.";
	date: "$Date$";
	revision: "$Revision$"

class STORE

inherit

	EC_COMMAND;
	ONCES;
	CONSTANTS;
	STORABLE

feature -- Properties

	overwrite_project: BOOLEAN;
			-- Overwrite existing project?

	is_save_as: BOOLEAN;
			-- Is Current store saving as?

feature -- Setting

	set_overwrite_project is
			-- Set overwrite_project to True.
		do
			overwrite_project := True
		ensure
			overwrite_project: overwrite_project
		end;

	set_save_as (b: BOOLEAN) is
			-- Set save_as to `b'.
		do
			is_save_as := b;
		ensure
			is_save_as_set: is_save_as = b
		end;

feature -- Execution

	failed: BOOLEAN;
			-- Has the storage failed?

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA)  is
			-- Store a project
		do
			if not failed then
			--	Windows.set_watch_cursor;
				save_project;
				remove_restore_file;
			--	Windows.restore_cursor;
			end
		rescue
			if original_exception = Operating_system_exception then
			--	Windows.error (Windows.main_graph_window,
			--						Message_keys.store_operating_system_er,
			--						original_tag_name)
			else
			--	Windows.error (Windows.main_graph_window,
			--						Message_keys.store_proj_er,
			--						Void)
			end;
			--Windows.restore_cursor;
			failed := True;
			retry
		end;

feature {NONE} -- Implementation

	save_project is
			-- Save project to Project directory
		local
			id_file_name: STRING;
			id_file: PLAIN_TEXT_FILE;
			view_id: INTEGER
		do
			if overwrite_project then
				Environment.remove_directory (Environment.casegen_directory);
			end;
			Environment.create_initial_directories;
			id_file_name := Environment.system_id_file_name;
			!!id_file.make (id_file_name);
			id_file.open_write;
		--	id_file.putstring (Environment.eiffelcase_project_type);
			id_file.close;
			System.update_view_list;
			if is_save_as or System.is_modified then
				System.save_project (is_save_as)
			end;
		end;

	remove_restore_file is
			-- Remove the restore file after a successful save.
		require
			successful_save: not System.is_modified
		local
			file: RAW_FILE;
			file_name: FILE_NAME;
			tmp: STRING
		do
			!! file_name.make_from_string (Environment.restore_directory);
			!! tmp.make(0);
			tmp.append (Environment.view_name);
			tmp.append_integer (System.view_id);
			file_name.set_file_name (tmp);
			!! file.make (file_name);
			if file.exists then
				file.delete
			end;
		end;

end -- class STORE
