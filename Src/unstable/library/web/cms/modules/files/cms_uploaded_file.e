note
	description: "Summary description for {CMS_UPLOADED_FILE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_UPLOADED_FILE

create
	make_with_uploaded_file

feature {NONE} -- Initializaion

	make_with_uploaded_file (a_uploads_directory: PATH; uf: WSF_UPLOADED_FILE)
		do
			uploads_directory := a_uploads_directory
			uploaded_file := uf
			location := a_uploads_directory.extended (uf.safe_filename)
		end

feature -- Access

	uploaded_file: WSF_UPLOADED_FILE

	uploads_directory: PATH

	filename: STRING_32
			-- File name of Current file.
		local
			p: PATH
		do
			p := location
			if attached p.entry as e then
				Result := e.name
			else
				Result := p.name
			end
		end


	location: PATH
			-- Absolute path, or relative path to the `CMS_API.files_location'.

	owner: detachable CMS_USER
			-- Optional owner.

	upload_time: detachable DATE_TIME
			-- time when the file was uploaded

	size: detachable INTEGER_32
			-- file size

	type: detachable STRING
			-- file type

feature -- Element change

	set_owner (u: detachable CMS_USER)
			-- Set `owner' to `u'.
		do
			owner := u
		end

	set_time (a_time: detachable DATE_TIME)
			-- Set `upload_time' to `a_time'
		do
			upload_time := a_time
		end

	set_size (a_size: detachable INTEGER_32)
			-- Set `size' to `a_size'
		do
			size := a_size
		end

	set_type (a_type: detachable STRING)
			-- Set `type' to `a_type'
		do
			type := a_type
		end

	set_new_location_with_number (a_number: INTEGER_32)
			-- sets `a_number' after the name. This is done when the file was already uploaded
		local
			position: INTEGER_32
			new_name: STRING_32
			l_uploaded_file_string_representation: READABLE_STRING_32
		do
			l_uploaded_file_string_representation := uploaded_file.string_representation
			position := l_uploaded_file_string_representation.index_of ('.', 1)
			create new_name.make_empty

			new_name := l_uploaded_file_string_representation.head (position-1)
			new_name.append_string_general ("_(" + a_number.out + ")")
			new_name.append (l_uploaded_file_string_representation.substring (position, l_uploaded_file_string_representation.count))

			location := uploads_directory.extended (new_name)
		end

feature -- Basic operation

	move_to (p: PATH): BOOLEAN
		local
			retried: BOOLEAN
		do
			if retried then
				Result := False
			else
				Result := uploaded_file.move_to (p.name)
			end
		rescue
			retried := True
			retry
		end

end
