indexing

	description: "File and version manager associated to the merging window";
	date: "$Date$";
	revision: "$Revision $"

class
	MERGING_WINDOW_FILE_MANAGER

inherit
	CONSTANTS

	ONCES

creation
	make

feature -- Initialization

	make (cm: like classes_merger) is
			-- Associate Current server to merging window `mwin'.
		require
			cm_exists: cm /= Void
		do
			classes_merger := cm
			!! backuped_classes.make
		ensure
			classes_merger_set: classes_merger = cm
		end

feature -- Properties

	current_class: MERGING_CLASS
			-- Name of currently processed class

	new_path: STRING is
			-- Path where the new (Case) version of the classes to merge
			-- can be found (CASEMOD path).
		require
			current_class_exists: current_class /= Void
		do
			Result := current_class.new_path
		end

	old_path: like new_path is
			-- Path where the old (Bench/code) version of the classes to merge
			-- can be found.
		require
			current_class_exists: current_class /= Void
		do
			Result := current_class.old_path
		end

feature -- Setting

	set_current_class (cc: like current_class) is
		require
			cc_exists: cc /= Void
		do
			current_class := cc
			backup_new_directory_name := clone (current_class.new_path)
			backup_new_directory_name.extend (Environment.directory_separator)
			backup_new_directory_name.append (backup_directory_name)
			backup_old_directory_name := clone (current_class.old_path)
			backup_old_directory_name.extend (Environment.directory_separator)
			backup_old_directory_name.append (backup_directory_name)
		ensure
			current_class_set: current_class = cc
		end

feature -- Directory management

	backup_new_directory_name: STRING
			-- Name of backup directory for the new (Case) version

	backup_old_directory_name: STRING
			-- Name of backup directory for the old (Case) version

	create_backup_directory (path: STRING) is
			-- Create a directory in `path', with name 
			-- `backup_directory_name'
		local
			dir: DIRECTORY
			error_fi : BOOLEAN
		do
--			if not error_fi then
--				!! dir.make (path)
--				if dir.exists then
--					dir.open_read
--				else
--					dir.create_dir
--				end
--			else
--			--	Windows.error(Windows.main_graph_window,"E44","")
--			end
--			rescue
--				Windows.add_message("Can not create backup directory",1)
--				if not error_fi then
--					error_fi := TRUE
--					retry
--				end
		end

 	make_backup_directories is
			-- Create the directories in which files are saved before
			-- any merging modification
		do
			create_backup_directory (backup_new_directory_name)
			create_backup_directory (backup_old_directory_name)
		end

	remove_backup_directories is
			-- Remove the directories in which files have been saved before
			-- any merging modification
		do
			remove_directory (backup_new_directory_name)
			remove_directory (backup_old_directory_name)
		end

	remove_directory (name: STRING) is
			-- Remove the specified directory and the files in it
			-- (and recursively its sub-directories).
		local
			file: RAW_FILE
			err : BOOLEAN
		do
--			if not err then
--				!! file.make (name)
--				if file.exists and then file.is_directory then
--					Environment.remove_directory (name)
--					file.delete
--						--| This is needed, since Environment.remove_directory
--						--| doesn't remove the directory itself (!)
--				end
--			else
--				file.close
--			end
--			rescue
--				if err=FALSE then
--					err := TRUE
--					Windows.add_message("remove_directory from merging_window_file_manager",1)
--					retry
--				end
		end

feature -- File name management

	backup_new_file_name: FILE_NAME is
			-- File name of backup file for new version of current class
		do
			check
				class_exists: current_class /= Void
			end
			!! Result.make_from_string (backup_new_directory_name)
			Result.set_file_name (class_name_to_file_name (current_class.name))
		end

	backup_old_file_name: FILE_NAME is
			-- File name of backup file for old version of current class
		do
			check
				class_exists: current_class /= Void
			end
			!! Result.make_from_string (backup_old_directory_name)
			Result.set_file_name (class_name_to_file_name (current_class.name))
		end

	current_new_file_name: FILE_NAME is
			-- File name of current class in the new (Case/CASEMOD) directory 
		local
			name: STRING
		do
			!! Result.make_from_string (new_path)
			name := class_name_to_file_name (current_class.name)
			Result.set_file_name (name)
		end

	current_old_file_name: FILE_NAME is
			-- File name of current class in the old (Bench/code) directory 
		local
			name: STRING
		do
			!! Result.make_from_string (old_path)
			name := class_name_to_file_name (current_class.name)
			Result.set_file_name (name)
		end

feature -- File management

	copy_file_by_name (source_name, dest_name: STRING) is
			-- Copy the content of file `source_name' into new 
			-- file `dest_name'
		require
			source_name_exists: source_name /= Void
			dest_name_exists: dest_name /= Void
		local
			source, dest: PLAIN_TEXT_FILE
		do
			!! source.make_open_read (source_name)
			!! dest.make_open_write (dest_name)
			source.read_stream (source.count)
			dest.put_string (source.last_string)
			source.close
			dest.close
		end

feature -- Version management

	clean_class_files (class_list: MERGING_CLASS_LIST) is
			-- Remove files (backup and new version)
			-- related to the classes in `class_list'
		do
			from
				class_list.start
			until
				class_list.off
			loop
				set_current_class (class_list.item)
				remove_directory (backup_old_directory_name)
				remove_current_new_directory
				class_list.forth
			end
		end

	clean_new_class_files (class_list: MERGING_CLASS_LIST) is
			-- Remove files corresponding to the new version of
			-- the classes in `class_list'
		do
			from
				class_list.start
			until
				class_list.off
			loop
				set_current_class (class_list.item)
				remove_current_new_directory
				class_list.forth
			end
		end

	new_class_file: PLAIN_TEXT_FILE is
			-- File containing the new version of `current_class'
		do
			!! Result.make (current_new_file_name)
		end

	old_class_file: PLAIN_TEXT_FILE is
			-- File containing the old version of `current_class'
		do
			!! Result.make (current_old_file_name)
		end

	remove_current_new_directory is
			-- Remove directory `new_path' and its content
		do
			remove_directory (new_path)
		end

	retrieve_backup_versions is
			-- Retrieve the new and old versions of current class 
			-- from their respective backup directory.
			--| Generate "clean" Eiffel code, without the difference symbols.
		local
			source, dest: FILE_NAME
			class_list: MERGING_CLASS_LIST
		do
		--	if backuped_classes.has (current_class) then
		--		source := backup_new_file_name
		--		dest := current_new_file_name
		--		copy_file_by_name (source, dest)
		--		source := backup_old_file_name
		--		dest := current_old_file_name
		--		copy_file_by_name (source, dest)
		--		backuped_classes.prune (current_class)
		--	end
		--	class_list := classes_merger.merged_classes
		--	class_list.search (current_class)
		--	if not class_list.off then
		--		class_list.remove
		--	end
		--	class_list := classes_merger.classes_to_merge
		--	if not class_list.has (current_class) then
		--		class_list.extend (current_class)
		--	end
		--	classes_merger.process_versions
		--	merging_window.show_class_diffs.format
		end

	save_backup_versions is
			-- Save the new and old versions of current class in 
			-- their respective backup directory.
			--| Generate "clean" Eiffel code, without the difference symbols.
		local
			source, dest: FILE_NAME
		do
			make_backup_directories
			if not backuped_classes.has (current_class) then
				source := current_new_file_name
				dest := backup_new_file_name
				copy_file_by_name (source, dest)
				source := current_old_file_name
				dest := backup_old_file_name
				copy_file_by_name (source, dest)
				backuped_classes.extend (current_class)
			end
		end

	save_current_new_version is
			-- Save the new version of current class in a file.
			--| Generate "clean" Eiffel code, without the difference symbols.
		local
			name: FILE_NAME
			file: PLAIN_TEXT_FILE
			error_fi : BOOLEAN
		do
--			if not error_fi then
--			check
--				modified: classes_merger.new_version_modified
--				dirty: classes_merger.new_version_dirty
--			end
--			if classes_merger.class_diffs /= Void then
--				classes_merger.prepare_new_eiffel_code_generation
--			end
--			name := current_new_file_name
--			check
--				ok: name.is_valid
--			end
--			!! file.make_open_write (name)
--			file.put_string (merging_window.left_text_representation.image)
--			file.close
--			if classes_merger.class_diffs /= Void then
--				classes_merger.end_new_eiffel_code_generation
--			end
--			classes_merger.unset_new_version_dirty
--			classes_merger.unset_new_version_modified
--			else
--			--	Windows.error(Windows.main_graph_window, "E45","")
--			end
--			rescue
--				error_fi := TRUE
--				Windows.add_message("Problem in save_current_new-version of Merging_window_file_m",1)
--				retry
		end

	save_current_old_version is
			-- Save the old version of current class in a file.
			--| Generate "clean" code, without the difference symbols.
		local
			name: FILE_NAME
			file: PLAIN_TEXT_FILE
			error_fi : BOOLEAN
		do
--			if not error_fi then
--			check
--				modified: classes_merger.old_version_modified
--				dirty: classes_merger.old_version_dirty
--			end
--			if classes_merger.class_diffs /= Void then
--				classes_merger.prepare_old_eiffel_code_generation
--			end
--			name := current_old_file_name
--			!! file.make_open_write (name)
--			file.put_string (merging_window.right_text_representation.image)
--			file.close
--			if classes_merger.class_diffs /= Void then
--				classes_merger.end_old_eiffel_code_generation
--			end
--			classes_merger.unset_old_version_dirty
--			classes_merger.unset_old_version_modified
--			else
--			--	Windows.error(Windows.main_graph_window, "E45","")
--			end
--			rescue
--				error_fi := TRUE
--				Windows.add_message("Problem in save_current_new-version of Merging_window_file_m",1)
--				retry
		end

feature {NONE} -- Implementation properties

	backup_directory_name: STRING is "BACKUP"
			-- Name of backup directories.

	backuped_classes: MERGING_CLASS_LIST
			-- List of classes whose two versions have been backuped
			-- (ie original versions before any merging have been saved)

	classes_merger: CLASSES_MERGER
			-- Classes merger

--	merging_window: MERGING_WINDOW is
	--		-- Merging window
	--	do
	--		Result := classes_merger.merging_window
	--	end

feature {NONE} -- Implementation

	class_name_to_file_name (cn: STRING): STRING is
			-- Transform class name "MY_CLASS" to file name "my_class.e"
		require
			cn_exists: cn  /= Void
		do	
			Result := clone (cn)
			Result.to_lower
			Result.append (".e")
		end

	remove_all_files_from_directory (dir: DIRECTORY) is
			-- Remove all the files of directory `dir' (NOT recursive).
		require
			dir_exists: dir /= Void
			dir_exists_physically: dir.exists
			dir_is_readable: dir.is_readable
			dir_is_writable: dir.is_writable
		local
			fname, dot_name, dot_dot_name: STRING
		do
			dot_name := "."
			dot_dot_name := ".."
			from
				dir.start
				dir.readentry
				fname := dir.lastentry
			until
				fname = Void
			loop
				if not fname.is_equal (dot_name) and then
						not fname.is_equal (dot_dot_name) then
					remove_file_by_name (dir.name, dir.lastentry)
				end
				dir.readentry
				fname := dir.lastentry
			end
		end

	remove_file_by_name (dir_name, file_name: STRING) is
			-- Remove file `file_name' from directory `dir_name'
		local
			file: PLAIN_TEXT_FILE
			long_name: FILE_NAME
		do
			!! long_name.make_from_string (dir_name)
			long_name.set_file_name (file_name)
debug ("MERGING_FILES")
			print ("%N FILE NAME: "); print (long_name); io.new_line
end
			!! file.make_open_write (long_name)
			check
				file_exists: file.exists
			end
			file.delete
			file.close
		end

invariant
	classes_merger_exists: classes_merger /= Void

end -- class MERGING_WINDOW_FILE_MANAGER
