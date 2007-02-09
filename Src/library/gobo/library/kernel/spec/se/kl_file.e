indexing

	description:

		"Files"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class KL_FILE

inherit

	KI_FILE






	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all




		end

	KL_IMPORTED_STRING_ROUTINES
		export
			{NONE} all




		end

	KL_IMPORTED_ANY_ROUTINES
		export
			{NONE} all




		end


	FILE_TOOLS
		rename
			delete as old_delete,
			is_readable as old_is_readable,
			tmp_string as old_tmp_string
		export
			{NONE} all
		undefine
			file_exists
		end

	KL_GREGORIAN_CALENDAR
		export
			{NONE} all
		end






























feature {NONE} -- Initialization

	make (a_name: like name) is
			-- Create a new file named `a_name'.
			-- (`a_name' should follow the pathname convention
			-- of the underlying platform. For pathname conversion
			-- use KI_FILE_SYSTEM.pathname_from_file_system.)
		do
			name := a_name

			if a_name.count > 0 then
				string_name := STRING_.as_string (a_name)
			else
				string_name := Empty_name
			end
			old_make








		end

feature -- Access

	name: STRING
			-- File name;
			-- Note: If `name' is a UC_STRING or descendant, then
			-- the bytes of its associated UTF unicode encoding will
			-- be used.

	time_stamp: INTEGER is
			-- Time stamp (number of seconds since 1 January 1970
			-- at 00:00:00 UTC) of last modification to current file;
			-- Return -1 if the time stamp was not available, if the
			-- file did not exist for example, or if the time stamp
			-- didn't fit into an INTEGER. (Use DT_DATE_TIME.make_from_epoch
			-- to convert this time stamp to a human readable format.)
		local
			rescued: BOOLEAN

			basic_time: TIME
			y, m, d: INTEGER
			h, mi, s: INTEGER
			local_time: TIME
			old_is_local: BOOLEAN







		do
			Result := -1
			if not rescued then
				if string_name /= Empty_name then

					if file_exists (string_name) then
						basic_time := last_change_of (string_name)
						old_is_local := basic_time.is_local_time
						basic_time.set_universal_time
						y := basic_time.year
						m := basic_time.month
						d := basic_time.day
						h := basic_time.hour
						mi := basic_time.minute
						s := basic_time.second
						Result := epoch_days (y, m, d) * Seconds_in_day + h * Seconds_in_hour + mi * Seconds_in_minute + s
						if old_is_local then
							basic_time.set_local_time
						end
						if Result < 0 then
							Result := -1
						end
					end


















































				end
			end
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

feature -- Measurement

	count: INTEGER is
			-- Number of bytes in current file;
			-- Return -1 if the number of bytes was not available,
			-- if the file did not exist for example.
		local
			rescued: BOOLEAN
		do
			Result := -1
			if not rescued then
				if string_name /= Empty_name then

					if file_exists (string_name) then
						Result := size_of (string_name)
					end





				end
			end
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

feature -- Status report

	exists: BOOLEAN is
			-- Does file physically exist on disk?
			-- (Note that with SmartEiffel this routine
			-- actually returns `is_readable'.)
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if string_name /= Empty_name then




					Result := is_readable




				end
			else
				Result := False
			end
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

	is_readable: BOOLEAN is
			-- Can file be opened in read mode?
		do
			if string_name /= Empty_name then




				tmp_file2.reset (string_name)
				Result := tmp_file2.is_readable




			end
		end

	is_closed: BOOLEAN is
			-- Is file closed?
		do

			Result := not is_open



		end

	same_physical_file (other_name: STRING): BOOLEAN is
			-- Are current file and file named `other_name'
			-- the same physical file? Return False if one 
			-- or both files don't exist. (Return True if
			-- it was impossible to determine whether the
			-- files were physically the same files.)
			-- (`other_name' should follow the pathname convention
			-- of the underlying platform. For pathname conversion
			-- use KI_FILE_SYSTEM.pathname_from_file_system.)
		local
			absolute_name1, absolute_name2: STRING
			canonical_name1, canonical_name2: STRING
			a_name, saved_string_name: STRING
			string_other_name: STRING
			i: INTEGER
			rescued: BOOLEAN



		do
			if not rescued then
				saved_string_name := string_name
				string_other_name := STRING_.as_string (other_name)
				if string_name /= Empty_name and string_other_name.count > 0 then
					if exists then
						tmp_file1.reset (string_other_name)
						if tmp_file1.exists then
							if string_name.same_string (string_other_name) then
								Result := True









								elseif tmp_file1.count /= count then
									-- Result := False
								elseif tmp_file1.time_stamp /= time_stamp then
									-- Result := False
								else 
									absolute_name1 := file_system.absolute_pathname (name)
									absolute_name2 := file_system.absolute_pathname (other_name)
									if STRING_.same_string (absolute_name1, absolute_name2) then
										Result := True
									else
										canonical_name1 := file_system.canonical_pathname (absolute_name1)
										canonical_name2 := file_system.canonical_pathname (absolute_name2)
										if STRING_.same_string (canonical_name1, canonical_name2) then
											Result := True
										else
											from
												i := 1
												a_name := "gobotmp" + i.out
												tmp_file1.reset (a_name)
											until
												not tmp_file1.exists
											loop
												i := i + 1
												a_name := "gobotmp" + i.out
												tmp_file1.reset (a_name)
											end

											rename_to (string_name, a_name)




											if not exists then
												tmp_file1.reset (string_other_name)
												Result := not tmp_file1.exists

												rename_to (a_name, string_name)





											else
													-- We don't know.
													-- Return True for safety reason.
												Result := True
											end
										end
									end



							end
						end
					end
				end
			else
				string_name := saved_string_name
				Result := True
			end
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

feature -- Basic operations

	close is
			-- Close current file if it is closable,
			-- let it open otherwise.
		local
			rescued: BOOLEAN
		do
			if not rescued then
				old_close
			end
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

	change_name (new_name: STRING) is
			-- Rename current file as `new_name'.
			-- Do nothing if the file could not be renamed, if
			-- it did not exist or if `new_name' is physically
			-- the same file as current file. Overwrite `new_name'
			-- if it already existed. If renaming was successful,
			-- then `name' is set to `new_name'.
			-- (`new_name' should follow the pathname convention
			-- of the underlying platform. For pathname conversion
			-- use KI_FILE_SYSTEM.pathname_from_file_system.)
		local
			rescued: BOOLEAN
			string_new_name: STRING
			saved_string_name: STRING
		do
			if not rescued then
				saved_string_name := string_name
				string_new_name := STRING_.as_string (new_name)
				if string_name /= Empty_name and string_new_name.count > 0 then
					if exists then
						if not same_physical_file (string_new_name) then

							rename_to (string_name, string_new_name)




							tmp_file1.reset (string_name)
							if not tmp_file1.exists then
								name := new_name
								string_name := string_new_name
							end
						end
					end
				end
			else
				string_name := saved_string_name
			end
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

	copy_file (new_name: STRING) is
			-- Copy current file to `new_name'.
			-- Do nothing if the file could not be copied, if it
			-- did not exist or if `new_name' is physically
			-- the same file as current file. Overwrite `new_name'
			-- if it already existed.
			-- (`new_name' should follow the pathname convention
			-- of the underlying platform. For pathname conversion
			-- use KI_FILE_SYSTEM.pathname_from_file_system.)
		local
			old_file: KL_BINARY_INPUT_FILE
			new_file: KL_BINARY_OUTPUT_FILE
			string_new_name: STRING
		do
			string_new_name := STRING_.as_string (new_name)
			if string_name /= Empty_name and string_new_name.count > 0 then
				if exists then
					if not same_physical_file (string_new_name) then
						create old_file.make (string_name)
						old_file.open_read
						if old_file.is_open_read then
							create new_file.make (string_new_name)
							new_file.open_write
							if new_file.is_open_write then
								from
									old_file.read_string (512)
								until
									old_file.end_of_file
								loop
									new_file.put_string (old_file.last_string)
									old_file.read_string (512)
								end
								new_file.close
							end
							old_file.close
						end
					end
				end
			end
		end

	concat (a_filename: STRING) is
			-- Copy content of file `a_filename' to the end of current file.
			-- Do nothing if file `a_filename' does not exist. Create
			-- current file if it does not exist yet. If file `a_filename'
			-- is physically the same as current file, then a copy of
			-- the file is appended to itself. Do nothing if current
			-- file could not be open in append mode or if file `a_filename'
			-- could not be opened in read mode.
			-- (`a_filename' should follow the pathname convention
			-- of the underlying platform. For pathname conversion
			-- use KI_FILE_SYSTEM.pathname_from_file_system.)
		local
			a_source_file: KL_BINARY_INPUT_FILE
			a_target_file: KL_BINARY_OUTPUT_FILE
			a_string_filename: STRING
			a_string: STRING
			nb: INTEGER
		do
			a_string_filename := STRING_.as_string (a_filename)
			if string_name /= Empty_name and a_string_filename.count > 0 then
				create a_source_file.make (a_string_filename)
				nb := a_source_file.count
				a_source_file.open_read
				if a_source_file.is_open_read then
					create a_target_file.make (string_name)
					a_target_file.open_append
					if a_target_file.is_open_write then
						from
							if nb >= 512 then
								a_source_file.read_string (512)
							elseif nb > 0 then
								a_source_file.read_string (nb)
							end
						until
							nb <= 0 or else
							a_source_file.end_of_file
						loop
							a_string := a_source_file.last_string
							a_target_file.put_string (a_string)
							nb := nb - a_string.count
							if nb >= 512 then
								a_source_file.read_string (512)
							elseif nb > 0 then
								a_source_file.read_string (nb)
							end
						end
						a_target_file.close
					end
					a_source_file.close
				end
			end
		end

	delete is
			-- Delete current file.
			-- Do nothing if the file could not be
			-- deleted or if it did not exist.
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if string_name /= Empty_name then

					old_delete (string_name)






				end
			end
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

feature {NONE} -- Implementation

	Empty_name: STRING is "empty_name"
			-- Empty name place-holder

	tmp_file1: KL_TEXT_INPUT_FILE is
			-- Temporary file object
		once
			create Result.make (dummy_name)
		ensure
			file_not_void: Result /= Void
			file_closed: Result.is_closed
		end

	dummy_name: STRING is "dummy"
			-- Dummy name


	string_name: STRING
			-- Name of file (STRING version)

	old_make is
			-- The new created object is not connected.
		deferred
		ensure
			is_closed: not is_open
		end

	old_close is
			-- Close file.
		require
			not_closed: is_open
		deferred
		end



	tmp_file2: KL_TEXT_INPUT_FILE is
			-- Temporary file object
		once
			create Result.make (dummy_name)
		ensure
			file_not_void: Result /= Void
			file_closed: Result.is_closed
		end




































































































































invariant


	string_name_not_void: string_name /= Void

	string_name_is_string: ANY_.same_types (string_name, "")

end
