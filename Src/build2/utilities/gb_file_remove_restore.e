indexing
	description: "Objects that handle the removal and restoration of files from the disk."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_FILE_REMOVE_RESTORE
	
inherit
	GB_FILE_UTILITIES
		export
			{NONE} all
		end
	
	GB_CONSTANTS
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end

feature -- Access

	delete_files is
			-- Delete files associated with `orignal_id', and store contents.
		local
			full_file_name, file_location: FILE_NAME
			object: GB_OBJECT
		do
			object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_not_void: object /= Void
				object_is_top_level_object: object.is_top_level_object
			end
				-- Now actually destroy the physical files.
			create file_location.make_from_string (generated_path)
			if parent_directory /= Void then
				from
					parent_directory.start
				until
					parent_directory.off
				loop
					file_location.extend (parent_directory.item)
					parent_directory.forth
				end
				
			end
				-- Store the _IMP file.
			create full_file_name.make_from_string (file_location.string)
			full_file_name.extend ((object.name + Class_implementation_extension).as_lower + ".e")
			store_file_contents (full_file_name)
			implementation_file_contents := last_stored_string
			
				-- Store the interface file.
			create full_file_name.make_from_string (file_location.string)
			full_file_name.extend (object.name + ".e")
			store_file_contents (full_file_name)
			file_contents := last_stored_string
			
				-- Remove the files from the disk.
			delete_file (create {DIRECTORY}.make (file_location), (object.name + Class_implementation_extension).as_lower + ".e")
			delete_file (create {DIRECTORY}.make (file_location), object.name + ".e")
		end
	
	restore_files is
			-- Restore files deleted by last call to `delete_files'.
		local
			file_name: FILE_NAME
			object: GB_OBJECT
		do
			object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_not_void: object /= Void
				object_is_top_level_object: object.is_top_level_object
			end
				-- Now actually restore the physical files.
			create file_name.make_from_string (generated_path)
			if parent_directory /= Void then
				from
					parent_directory.start
				until
					parent_directory.off
				loop
					file_name.extend (parent_directory.item)
					parent_directory.forth
				end
			end
				-- Restore the implementation file.
			if implementation_file_contents /= Void then
				restore_file (create {DIRECTORY}.make (file_name), (object.name + Class_implementation_extension).as_lower + ".e", implementation_file_contents)
			end
			
				-- Restore the interface file.
			if file_contents /= Void then
				restore_file (create {DIRECTORY}.make (file_name), object.name + ".e", file_contents)
			end
		end

feature {NONE} -- Implementation

	file_contents: STRING
		-- Contents of file before deletion or Void if there was no file.
		
	implementation_file_contents: STRING
		-- Contents of IMP file after deletion
		
	original_id: INTEGER is
			-- Original id of object to be removed/restored.
		deferred
		end
		
	parent_directory: ARRAYED_LIST [STRING] is
			-- Parent directory of object associated with `original_id' before removal.
		deferred
		end

	generated_path: FILE_NAME is
			-- `Result' is generated directory for current project.
		do
			create Result.make_from_string ((create {GB_SHARED_SYSTEM_STATUS}).system_status.current_project_settings.project_location)
		ensure
			result_not_void: Result /= Void
		end
		
	store_file_contents (file_name: FILE_NAME) is
			-- Store contents of file `file_name' as text in `last_stored_string'.
		require
			file_name_not_void: file_name /= Void
		local
			file: PLAIN_TEXT_FILE
		do
			create file.make (file_name)
			if file.exists then
				file.open_read_write
				file.read_stream (file.count)
				last_stored_string := file.laststring
				file.close
			end
		end
		
	last_stored_string: STRING
		-- Last string stored as  result of a call to `store_file_contents'.

end -- class GB_FILE_REMOVE_RESTORE
