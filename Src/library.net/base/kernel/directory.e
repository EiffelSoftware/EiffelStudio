indexing

	description:
		"Directories, in the Unix sense, with creation and exploration features"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class DIRECTORY

inherit
	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end

create

	make, make_open_read

feature -- Initialization

	make (dn: STRING) is
			-- Create directory object for the directory
			-- of name `dn'.
		require
			string_exists: dn /= Void
		do
			name := dn
			mode := Close_directory
		end

	make_open_read (dn: STRING) is
			-- Create directory object for the directory
			-- of name `dn' and open it for reading.
		require
			string_exists: dn /= Void
		do
			make (dn)
			open_read
		end

	create_dir is
			-- Create a physical directory.
		require
			physical_not_exists: not exists
		local
			l_name: SYSTEM_STRING
			di: DIRECTORY_INFO
		do
			l_name := name.to_cil
			di := feature {SYSTEM_DIRECTORY}.create_directory (l_name)
		end

feature -- Access

	readentry is
			-- Read next directory entry
			-- make result available in `lastentry'.
			-- Make result void if all entries have been read.
		require
			is_opened: not is_closed
		local
			ent: NATIVE_ARRAY [SYSTEM_STRING]
			l_name: SYSTEM_STRING
		do
			l_name := name.to_cil
			ent := feature {SYSTEM_DIRECTORY}.get_file_system_entries (l_name)
			if search_index >= ent.count then
				lastentry := Void
			else
				create lastentry.make_from_cil (ent.item (search_index))
				search_index := search_index + 1
			end
		end

	name: STRING
			-- Directory name

	has_entry (entry_name: STRING): BOOLEAN is
			-- Has directory the entry `entry_name'?
			-- The use of `dir_temp' is required not
			-- to change the position in the current
			-- directory entries list.
		require
			string_exists: entry_name /= Void
		local
			ent: NATIVE_ARRAY [SYSTEM_STRING]
			l_name: SYSTEM_STRING
			en: SYSTEM_STRING
			i: INTEGER
			c: INTEGER
		do
			l_name := name.to_cil
			ent := feature {SYSTEM_DIRECTORY}.get_file_system_entries (l_name)
			en := entry_name.to_cil
			c := ent.count
			from
				
			until
				i = c or Result
			loop
				Result := en.compare_to (ent.item (i)) = 0
				i := i + 1
			end
		end

	open_read is
			-- Open directory `name' for reading.
		do
			mode := Read_directory
			search_index := 0
		end

	close is
			-- Close directory.
		require
			is_open: not is_closed
		do
			mode := Close_directory
		end

	start is
			-- Go to first entry of directory.
		require
			is_opened: not is_closed
		do
			search_index := 0
		end

	change_name (new_name: STRING) is
			-- Change file name to `new_name'
		require
			not_new_name_Void: new_name /= Void
			file_exists: exists
		local
			ext_old_name, ext_new_name: SYSTEM_STRING
		do
			ext_old_name := name.to_cil
			ext_new_name := new_name.to_cil
			feature {SYSTEM_DIRECTORY}.move (ext_old_name, ext_new_name)
			name := new_name
		ensure
			name_changed: name.is_equal (new_name)
		end

feature -- Measurement

	count: INTEGER is
			-- Number of entries in directory.
		require
			directory_exists: exists
		local
			l_name: SYSTEM_STRING
		do
			l_name := name.to_cil
			Result := feature {SYSTEM_DIRECTORY}.get_file_system_entries (l_name).count
		end

feature -- Conversion

	linear_representation: ARRAYED_LIST [STRING] is
			-- The entries, in sequential format.
		local
			ent: NATIVE_ARRAY [SYSTEM_STRING]
			i, c: INTEGER
		do
			ent := feature {SYSTEM_DIRECTORY}.get_file_system_entries (name.to_cil)
			c := ent.count
			create Result.make (c)
			from
				
			until
				i = c
			loop
				Result.extend (create {STRING}.make_from_cil (ent.item (i)))
				i := i + 1
			end
		end

feature -- Status report

	lastentry: STRING
			-- Last entry read by `readentry'

	is_closed: BOOLEAN is
			-- Is current directory closed?
		do
			Result := mode = Close_directory
		end

	is_empty: BOOLEAN is
			-- Is directory empty?
		require
			directory_exists: exists
		do
				-- count = 2, since there are "." and ".." which
				-- are symbolic representations but not effective directories.
			Result := (count = 2)
		end
	
	empty: BOOLEAN is
			-- Is directory empty?
		obsolete
			"Use `is_empty' instead"
		do
			Result := is_empty
		end

	exists: BOOLEAN is
			-- Does the directory exist?
		do
			Result := feature {SYSTEM_DIRECTORY}.exists (name.to_cil)
		end

	is_readable: BOOLEAN is
			-- Is the directory readable?
		require
			directory_exists: exists
		local
			l_name: SYSTEM_STRING
			pa: FILE_IOPERMISSION
			sa: SECURITY_ACTION
			retried: BOOLEAN
		do
			if not retried then
				create pa.make_file_iopermission_1 (feature {FILE_IOPERMISSION_ACCESS}.Read, name.to_cil)
				pa.demand
			end
			Result := not retried
		rescue
			retried := True
			retry
		end

	is_executable: BOOLEAN is
			-- Is the directory executable?
		require
			directory_exists: exists
		local
			l_name: SYSTEM_STRING
			pa: FILE_IOPERMISSION
			sa: SECURITY_ACTION
			retried: BOOLEAN
		do
			if not retried then
				create pa.make_file_iopermission_1 (feature {FILE_IOPERMISSION_ACCESS}.path_discovery, name.to_cil)
				pa.demand
			end
			Result := not retried
		rescue
			retried := True
			retry
		end

	is_writable: BOOLEAN is
			-- Is the directory writable?
		require
			directory_exists: exists
		local
			l_name: SYSTEM_STRING
			pa: FILE_IOPERMISSION
			sa: SECURITY_ACTION
			retried: BOOLEAN
		do
			if not retried then
				create pa.make_file_iopermission_1 (feature {FILE_IOPERMISSION_ACCESS}.write, name.to_cil)
				pa.demand
			end
			Result := not retried
		rescue
			retried := True
			retry
		end

feature -- Removal

	delete is
			-- Delete directory if empty
		require
			directory_exists: exists
			empty_directory: is_empty
		do
			feature {SYSTEM_DIRECTORY}.delete (name.to_cil)
		end

	delete_content is
			-- Delete all files located in current directory and its
			-- subdirectories.
		require
			directory_exists: exists
		local
			l: LINEAR [STRING]
			file_name: FILE_NAME
			file: RAW_FILE
			dir: DIRECTORY
		do
			l := linear_representation
			from
				l.start
			until
				l.after
			loop
				if
					not l.item.is_equal (".") and
					not l.item.is_equal ("..")
				then
					create file_name.make_from_string (name)
					file_name.set_file_name (l.item)
					create file.make (file_name)
					if
						file.exists and then
						not file.is_symlink and then
						file.is_directory
					then
							-- Start the recursion
						create dir.make (file_name)
						dir.recursive_delete
					else
						if file.exists and then file.is_writable then
							file.delete
						end
					end
				end
				l.forth
			end
		end

	recursive_delete is
			-- Delete directory, its files and its subdirectories.
		require
			directory_exists: exists
		do
			feature {SYSTEM_DIRECTORY}.delete_string_boolean (name.to_cil, True)
		end

	delete_content_with_action (
		action: PROCEDURE [ANY, TUPLE]
		is_cancel_requested: FUNCTION [ANY, TUPLE, BOOLEAN]
		file_number: INTEGER
) is
			-- Delete all files located in current directory and its
			-- subdirectories. 
			--
			-- `action' is called each time `file_number' files has
			-- been deleted and before the function exits.
			-- `action' may be set to Void if you don't need it.
			-- 
			-- Same for `is_cancel_requested'.
			-- Make it return `True' to cancel the operation.
			-- `is_cancel_requested' may be set to Void if you don't need it.
		require
			directory_exists: exists
			valid_file_number: file_number > 0
		local
			l: LINEAR [STRING]
			file_name: FILE_NAME
			file: RAW_FILE
			dir: DIRECTORY
			file_count: INTEGER
			deleted_files: ARRAYED_LIST [STRING]
			deleted_files_tuple: TUPLE [ARRAYED_LIST [STRING]]
			current_directory: STRING
			parent_directory: STRING
			requested_cancel: BOOLEAN
		do
			file_count := 1
			create deleted_files.make (file_number)
			create deleted_files_tuple.make

			l := linear_representation
			current_directory := "."
			parent_directory := ".."
			from
				l.start
			until
				l.after or requested_cancel
			loop
				if
					not l.item.is_equal (current_directory) and
					not l.item.is_equal (parent_directory)
				then
					create file_name.make_from_string (name)
					file_name.set_file_name (l.item)
					create file.make (file_name)
					if
						file.exists and then
						not file.is_symlink and then
						file.is_directory
					then
							-- Start the recursion
						create dir.make (file_name)
						dir.recursive_delete_with_action (action, is_cancel_requested, file_number)
					else
						if file.exists and then file.is_writable then
							file.delete
						end
					end
						-- Add the name of the deleted file to our array
						-- of deleted files.
					deleted_files.extend (file_name)
					file_count := file_count + 1

						-- If `file_number' has been reached, call `action'.
					if file_count > file_number then
						if action /= Void then
							deleted_files_tuple.put (deleted_files, 1)
							action.call (deleted_files_tuple)
						end
						if is_cancel_requested /= Void then
							requested_cancel := is_cancel_requested.item ([])
						end
						deleted_files.wipe_out
						file_count := 1
					end
				end
				l.forth
			end
				-- If there is more than one deleted file and no
				-- agent has been called, call one now.
			if file_count > 1 then
				if action /= Void then
					deleted_files_tuple.put (deleted_files, 1)
					action.call (deleted_files_tuple)
				end
				deleted_files.wipe_out
				file_count := 1
			end
		end

	recursive_delete_with_action (
		action: PROCEDURE [ANY, TUPLE]
		is_cancel_requested: FUNCTION [ANY, TUPLE, BOOLEAN]
		file_number: INTEGER
) is
			-- Delete directory, its files and its subdirectories.
			--
			-- `action' is called each time `file_number' files has
			-- been deleted and before the function exits.
		require
			directory_exists: exists
		local
			deleted_files: ARRAYED_LIST [STRING]
		do	
			delete_content_with_action (action, is_cancel_requested, file_number)
			if (is_cancel_requested = Void) or else (not is_cancel_requested.item ([])) then
				delete

					-- Call the agent with the name of the directory
				if action /= Void then
					create deleted_files.make (1)
					deleted_files.extend (name)
					action.call ([deleted_files])
				end
			end
		end

	dispose is
			-- Ensure this medium is closed when garbage collected.
		do
			if not is_closed then
				close
			end
		end

feature {DIRECTORY} -- Implementation

	search_index: INTEGER
			-- Position in the list of entries

feature {NONE} -- Implementation

	mode: INTEGER
			-- Status mode of the directory.
			-- Possible values are the following:

	Close_directory: INTEGER is unique

	Read_directory: INTEGER is unique;

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DIRECTORY



