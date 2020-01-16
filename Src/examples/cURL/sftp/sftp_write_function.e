note
	description: "Summary description for {SFTP_WRITE_FUNCTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	SFTP_WRITE_FUNCTION

inherit

	CURL_DEFAULT_FUNCTION
		redefine
			write_function
		end
create
	make

feature -- Access

	file_to_write: detachable FILE

	set_file_to_write (a_file: FILE)
		do
			file_to_write := a_file
		end
	write_function (a_data_pointer: POINTER; a_size, a_nmemb: INTEGER; a_object_id: POINTER): INTEGER
		local
			l_c_string: C_STRING
		do
				-- Returns the number of bytes actually saved into object identified by `a_object_id'
			if attached file_to_write as l_file then
				Result := a_size * a_nmemb
				create l_c_string.make_shared_from_pointer_and_count (a_data_pointer, Result)
				l_file.put_string (l_c_string.string)
			end
		end
end
