note
	description: "[
					{WSF_UPLOADED_FILE} represents an uploaded file from form parameters.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_UPLOADED_FILE

inherit
	WSF_VALUE
		redefine
			debug_output
		end

create
	make,
	make_with_percent_encoded_values

feature {NONE} -- Initialization	

	make (a_name: READABLE_STRING_GENERAL; a_filename: READABLE_STRING_GENERAL; a_content_type: like content_type; a_size: like size)
		do
			name := a_name.as_string_32
			url_encoded_name := url_encoded_string (a_name)
			filename := a_filename.as_string_32
			content_type := a_content_type
			size := a_size
		end

	make_with_percent_encoded_values (a_encoded_name: READABLE_STRING_8; a_filename: READABLE_STRING_GENERAL; a_content_type: like content_type; a_size: like size)
		do
			name := url_decoded_string (a_encoded_name)
			url_encoded_name := a_encoded_name
			filename := a_filename.as_string_32
			content_type := a_content_type
			size := a_size
		end

feature -- Access

	name: READABLE_STRING_32

	url_encoded_name: READABLE_STRING_8

feature -- Status report

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := Precursor
			if
				exists and then
				attached tmp_path as p
			then
				Result.append_character (' ')
				Result.append_character ('%"')
				Result.append (p.name)
				Result.append_character ('%"')
			end
			Result.append (" filename=%"")
			Result.append (filename)
			Result.append ("%"")

			Result.append (" content-type=%"")
			Result.append (content_type)
			Result.append ("%"")

			Result.append (" size=%"")
			Result.append_integer (size)
			Result.append ("%"")
		end

feature -- Element change

	change_name (a_name: like name)
			-- <Precursor>
		do
			name := a_name
			url_encoded_name := url_encoded_string (a_name)
		end

feature -- Status report

	is_string: BOOLEAN = False
			-- Is Current as a WSF_STRING representation?	

	is_empty: BOOLEAN
			-- Is Current empty?
		do
			Result := size = 0
		end

feature -- Conversion

	string_representation: READABLE_STRING_32
		do
			Result := filename
		end

feature -- Visitor

	process (vis: WSF_VALUE_VISITOR)
		do
			vis.process_uploaded_file (Current)
		end

feature -- Access: Uploaded File

	filename: STRING_32
			-- original filename

	safe_filename: STRING
			-- Safe name version of `filename'.
			-- i.e: removing whitespace, accent, unicode characters ...
		local
			ut: WSF_FILE_UTILITIES [RAW_FILE]
		do
			create ut
			Result := ut.safe_filename (filename)
		end

	content_type: STRING
			-- Content type

	size: INTEGER
			-- Size of uploaded file

	tmp_path: detachable PATH
			-- Filename of tmp file

	tmp_name: detachable READABLE_STRING_GENERAL
		do
			if attached tmp_path as p then
				Result := p.name
			end
		end

	tmp_basename: detachable READABLE_STRING_GENERAL
			-- Basename of tmp file

feature -- Conversion

	append_content_to_string (a_target: STRING)
			-- Append the content of the uploaded file to `a_target'.
		local
			f: RAW_FILE
			s: STRING
			done: BOOLEAN
			retried: BOOLEAN
		do
			if not retried and attached tmp_name as fn then
				create f.make_with_name (fn)
				if f.exists then
					f.open_read
					from
					until
						done
					loop
						f.read_stream_thread_aware (1_024)
						s := f.last_string
						if s.is_empty then
							done := True
						else
							a_target.append (s)
							done := f.exhausted or f.end_of_file
						end
					end
					f.close
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Basic operation

	move_to (a_destination: READABLE_STRING_GENERAL): BOOLEAN
			-- Move current uploaded file to `a_destination'
			--| Violates CQS principle.
		require
			a_destination_not_empty: not a_destination.is_empty
			has_no_error: not has_error
		local
			f: RAW_FILE
		do
			if attached tmp_path as p then
				create f.make_with_path (p)
				if f.exists then
					f.rename_file (a_destination)
					Result := True
				end
			end
		ensure
			removed: not exists
			moved: old exists implies (create {FILE_UTILITIES}).file_exists (a_destination)
		end

feature --  Status

	has_error: BOOLEAN
			-- Has error during uploading
		do
			Result := error /= 0
		end

	error: INTEGER
			-- Eventual error code
			--| no error => 0

	exists: BOOLEAN
		local
			f: PLAIN_TEXT_FILE
		do
			if attached tmp_path as p then
				create f.make_with_path (p)
				Result := f.exists
			end
		end

feature -- Element change

	set_error (e: like error)
			-- Set `error' to `e'
		do
			error := e
		end

	set_tmp_path (p: like tmp_path)
		do
			tmp_path := p
		end

	set_tmp_name (n: like tmp_name)
			-- Set `tmp_name' to `n'
		do
			if n /= Void then
				set_tmp_path (create {PATH}.make_from_string (n))
			else
				set_tmp_path (Void)
			end
		end

	set_tmp_basename (n: like tmp_basename)
			-- Set `tmp_basename' to `n'
		do
			tmp_basename := n
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
