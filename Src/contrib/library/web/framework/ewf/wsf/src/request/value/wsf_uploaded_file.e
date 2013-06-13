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
	make

feature {NONE} -- Initialization	

	make (a_name: READABLE_STRING_8; n: like filename; t: like content_type; s: like size)
		do
			name := url_decoded_string (a_name)
			url_encoded_name := a_name
			filename := n
			content_type := t
			size := s
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
		do
			name := url_decoded_string (a_name)
			url_encoded_name := a_name
		ensure then
			a_name.same_string (url_encoded_name)
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

	string_representation: STRING_32
		do
			Result := filename
		end

feature -- Visitor

	process (vis: WSF_VALUE_VISITOR)
		do
			vis.process_uploaded_file (Current)
		end

feature -- Access: Uploaded File

	filename: STRING
			-- original filename

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

	tmp_basename: detachable STRING
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

feature -- Implementation		

	safe_filename: STRING
		local
			fn: like filename
			c: CHARACTER
			i, n: INTEGER
		do
			fn := filename

				--| Compute safe filename, to avoid creating impossible filename, or dangerous one
			from
				i := 1
				n := fn.count
				create Result.make (n)
			until
				i > n
			loop
				c := fn[i]
				inspect c
				when '.', '-', '_' then
					Result.extend (c)
				when 'A' .. 'Z', 'a' .. 'z', '0' .. '9' then
					Result.extend (c)
				else
					inspect c
					when '%/192/' then Result.extend ('A') -- À
					when '%/193/' then Result.extend ('A') -- Á
					when '%/194/' then Result.extend ('A') -- Â
					when '%/195/' then Result.extend ('A') -- Ã
					when '%/196/' then Result.extend ('A') -- Ä
					when '%/197/' then Result.extend ('A') -- Å
					when '%/199/' then Result.extend ('C') -- Ç
					when '%/200/' then Result.extend ('E') -- È
					when '%/201/' then Result.extend ('E') -- É
					when '%/202/' then Result.extend ('E') -- Ê
					when '%/203/' then Result.extend ('E') -- Ë
					when '%/204/' then Result.extend ('I') -- Ì
					when '%/205/' then Result.extend ('I') -- Í
					when '%/206/' then Result.extend ('I') -- Î
					when '%/207/' then Result.extend ('I') -- Ï
					when '%/210/' then Result.extend ('O') -- Ò
					when '%/211/' then Result.extend ('O') -- Ó
					when '%/212/' then Result.extend ('O') -- Ô
					when '%/213/' then Result.extend ('O') -- Õ
					when '%/214/' then Result.extend ('O') -- Ö
					when '%/217/' then Result.extend ('U') -- Ù
					when '%/218/' then Result.extend ('U') -- Ú
					when '%/219/' then Result.extend ('U') -- Û
					when '%/220/' then Result.extend ('U') -- Ü
					when '%/221/' then Result.extend ('Y') -- Ý
					when '%/224/' then Result.extend ('a') -- à
					when '%/225/' then Result.extend ('a') -- á
					when '%/226/' then Result.extend ('a') -- â
					when '%/227/' then Result.extend ('a') -- ã
					when '%/228/' then Result.extend ('a') -- ä
					when '%/229/' then Result.extend ('a') -- å
					when '%/231/' then Result.extend ('c') -- ç
					when '%/232/' then Result.extend ('e') -- è
					when '%/233/' then Result.extend ('e') -- é
					when '%/234/' then Result.extend ('e') -- ê
					when '%/235/' then Result.extend ('e') -- ë
					when '%/236/' then Result.extend ('i') -- ì
					when '%/237/' then Result.extend ('i') -- í
					when '%/238/' then Result.extend ('i') -- î
					when '%/239/' then Result.extend ('i') -- ï
					when '%/240/' then Result.extend ('o') -- ð
					when '%/242/' then Result.extend ('o') -- ò
					when '%/243/' then Result.extend ('o') -- ó
					when '%/244/' then Result.extend ('o') -- ô
					when '%/245/' then Result.extend ('o') -- õ
					when '%/246/' then Result.extend ('o') -- ö
					when '%/249/' then Result.extend ('u') -- ù
					when '%/250/' then Result.extend ('u') -- ú
					when '%/251/' then Result.extend ('u') -- û
					when '%/252/' then Result.extend ('u') -- ü
					when '%/253/' then Result.extend ('y') -- ý
					when '%/255/' then Result.extend ('y') -- ÿ
					else
						Result.extend ('-')
					end
				end
				i := i + 1
			end
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
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
