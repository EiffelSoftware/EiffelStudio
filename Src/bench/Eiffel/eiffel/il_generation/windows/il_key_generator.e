indexing
	description: "To generate private key for .NET systems."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_KEY_GENERATOR

create
	default_create
	
feature -- Initialization

	generate_key (a_filename: STRING) is
			-- Generate a new key pair with 'a_filename' as filename
		require
			filename_not_void: a_filename /= Void
			filename_not_empty: not a_filename.is_empty	
		local
			l_result, key_size: INTEGER
			a_file: RAW_FILE
			public_key: POINTER
			retried: BOOLEAN
			l_status: INTEGER
		do
			if not retried then
				status := No_error
				if (create {MD_STRONG_NAME}).present then
					l_result := feature {MD_STRONG_NAME}.strong_name_key_gen (default_pointer,
						0, $public_key, $key_size)
					if l_result /= 1 then
						status := Could_not_generate_key
					else
						create a_file.make (a_filename)
						l_status := 2
						a_file.open_write
						l_status := 3
						a_file.put_data (public_key, key_size)
						l_status := 4
						a_file.close
						l_status := 5
						feature {MD_STRONG_NAME}.strong_name_free_buffer (public_key)
					end
				else
					status := Could_not_load_mscorsn_dll
				end
			end
		rescue
			retried := True
			inspect status
			when 0 then status := No_error
			when 1 then status := Could_not_generate_key
			when 2 then status := Could_not_open_in_write_mode
			when 3 then status := Could_not_write_to_file
			when 4 then status := Could_not_close_file	
			when 5 then status := Could_not_free_data
			else
				status := Unknown_error
			end
			retry
		end

feature -- Status report

	successful: BOOLEAN is
			-- Was call to `generate_key' successful?
		do
			Result := status = No_error
		end

	error_message: STRING is
			-- Associated error message if not successful.
		do
			inspect
				status
			when No_error then Result := "No error."
			when Could_not_generate_key then Result := "Key could not be generated."
			when Could_not_close_file then Result := "Key file could not be closed."
			when Could_not_free_data then Result := "Key data could not be freed."
			when Could_not_load_mscorsn_dll then Result := "Could not load `mscorsn.dll' in memory."
			when Could_not_open_in_write_mode then Result := "Could not open key file in write mode."
			when Could_not_write_to_file then Result := "Could not write to key file."
			else
				Result := "Unknown error."
			end
		ensure
			error_message_not_void: Result /= Void
		end

feature {NONE} -- Access		

	status: INTEGER

feature {NONE} -- Constants

	No_error: INTEGER is 0
	Could_not_generate_key: INTEGER is 1
	Could_not_open_in_write_mode: INTEGER is 2
	Could_not_write_to_file: INTEGER is 3
	Could_not_close_file: INTEGER is 4
	Could_not_free_data: INTEGER is 5
	Could_not_load_mscorsn_dll: INTEGER is 6
	Unknown_error: INTEGER is 7
			-- Status after call to `generate_key'.

end -- class IL_KEY_GENERATOR
