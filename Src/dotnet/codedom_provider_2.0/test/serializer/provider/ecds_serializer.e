indexing
	description: "Serialize codedom tree to specified destination"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECDS_SERIALIZER

inherit
	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_dest_dir, a_file_title: STRING) is
			-- Set `destination_directory' with `a_dest_dir' and `file_title' with `a_file_title'.
		require
			non_void_destination_directory: a_dest_dir /= Void
			valid_destination_Directory: not a_dest_dir.is_empty
			non_void_file_title: a_file_title /= Void
			valid_file_title: not a_file_title.is_empty
		do
			destination_directory := a_dest_dir
			file_title := a_file_title
			last_error_message := "Generation not started"
			file_name := destination_directory + "\" + file_title + file_extension;
			(create {ECDS_SHARED_SETTINGS}).set_serialized_tree_location (file_name)
		ensure
			destination_directory_set: destination_directory = a_dest_dir
			file_title_set: file_title = a_file_title
		end
		
feature -- Status Report

	last_serialization_successful: BOOLEAN
			-- Was last serialization successful?

	provider_changed: BOOLEAN
			-- Was Eiffel codedom provider changed to serializer provider?

feature -- Access

	destination_directory: STRING
			-- Destination directory
	
	file_title: STRING
			-- File name (without path and extension)

	last_error_message: STRING
			-- Last error message if any
	
	file_name: STRING
			-- File name where codedom tree was serialized if any
	
	text_output: STRING
			-- Serializer output if any

feature -- Basic Operation

	serialize is
			-- Serialize codedom tree.
		deferred
		end

feature {NONE} -- Implementation

	wait_for_file is
			-- Wait for serialized codedom tree file creation.
		local
			l_watcher: SYSTEM_DLL_FILE_SYSTEM_WATCHER
			l_res: SYSTEM_DLL_WAIT_FOR_CHANGED_RESULT
			l_path: STRING
			l_seconds: INTEGER
		do
			create l_watcher.make (destination_directory, file_title + file_extension)
			create l_path.make (destination_directory.count + file_title.count + file_extension.count + 1)
			l_path.append (destination_directory)
			l_path.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			l_path.append (file_title)
			l_path.append (file_extension)
			from
				last_serialization_successful := {SYSTEM_FILE}.exists (l_path)
			until
				last_serialization_successful or l_seconds >= time_out
			loop
				l_res := l_watcher.wait_for_changed ({SYSTEM_DLL_WATCHER_CHANGE_TYPES}.created, 1000)
				last_serialization_successful := not l_res.timed_out or {SYSTEM_FILE}.exists (l_path)
				l_seconds := l_seconds + 1
			end
			if not last_serialization_successful then
				last_error_message := "Serialized codedom tree file was not created in alloted time (" + time_out.out + " seconds)"
			end
		end

	file_extension: STRING is
			-- Serialized codedom tree file extension
		deferred
		ensure
			non_void_extension: Result /= Void
			valid_extension: not Result.is_empty and then Result.item (1) = '.'
		end

	time_out: INTEGER is 180
			-- Alloted time for creation of serialized file

invariant
	non_void_destination_directory: destination_directory /= Void
	valid_destination_directory: not destination_directory.is_empty
	non_void_file_title: file_title /= Void
	valid_file_title: not file_title.is_empty
	no_error_if_successful: last_serialization_successful implies last_error_message = Void
	file_name_if_successful: last_serialization_successful implies file_name /= Void and then not file_name.is_empty
	error_message_if_failed: not last_serialization_successful implies last_error_message /= Void and then not last_error_message.is_empty

end -- class ECDS_SERIALIZER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Serializer
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------