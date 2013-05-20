class
	GET_REQUEST_HANDLER

inherit
	HTTP_REQUEST_HANDLER

	HTTP_SERVER_SHARED_CONFIGURATION
		undefine
			default_create
		end

	SHARED_URI_CONTENTS_TYPES
		undefine
			default_create
		end

	HTTP_CONSTANTS
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make (a_socket: TCP_STREAM_SOCKET)
		do
			default_create
			socket := a_socket
		end

feature -- Access

	socket: TCP_STREAM_SOCKET

feature -- Execution

	process
			-- process the request and create an answer
		local
			fname: STRING_8
			f: RAW_FILE
			ctype, extension: detachable STRING_8
		do
			answer.reset
			if script_name.is_equal ("/") then
				process_default
				answer.set_content_type ("text/html")
			else
				create fname.make_from_string (Document_root)
				fname.append (script_name)
				debug
					print ("URI filename: " + fname)
				end
				create f.make (real_filename (fname))
				if f.exists then
					extension := Ct_table.extension (script_name)
					ctype := Ct_table.content_types.item (extension)
					if f.is_directory then
						process_directory (f)
					else
						if ctype = Void then
							process_raw_file (f)
							answer.set_content_type ("text/html")
						else
							if ctype.is_equal ("text/html") then
								process_text_file (f)
							else
								process_raw_file (f)
							end
							answer.set_content_type (ctype)
						end
					end
				else
					answer.set_status_code (Not_found)
					answer.set_reason_phrase (Not_found_message)
					answer.set_reply_text ("Not found on this server")
				end
			end
			if attached answer.reply_text as t then
				answer.set_content_length (t.count)
			else
				answer.set_content_length (0)
			end

				--| Output the result
			socket.put_string (answer.reply_header + answer.reply_text)
		end

	process_default
			-- Return a default response
		local
			html: STRING_8
		do
			answer.set_reply_text ("")
			html := " <html> <head> <title> NINO HTTPD </title> " + "    </head>   " + "       <body>    " + " <h1> Welcome to NINO HTTPD! </h1> " + " <p>  Default page  " + " </p> " + " </body> " + " </html> "
			answer.append_reply_text (html)
		end

	process_text_file (f: FILE)
			-- send a text file reply
		require
			valid_f: f /= Void
		do
			f.open_read
			from
				answer.set_reply_text ("")
				f.read_line
			until
				f.end_of_file
			loop
				answer.append_reply_text (f.last_string)
				answer.append_reply_text (Crlf)
				f.read_line
			end
			f.close
		end

	process_raw_file (f: FILE)
			-- send a raw file reply
		require
			valid_f: f /= Void
		do
			f.open_read
			from
				answer.set_reply_text ("")
			until
				f.end_of_file
			loop
				f.read_stream_thread_aware (1024)
				answer.append_reply_text (f.last_string)
			end
			f.close
		end

	process_directory (f: FILE)
			--read the directory
		require
			is_directory: f.is_directory
		local
			l_dir: DIRECTORY
			files: ARRAYED_LIST [STRING_8]
			html1: STRING_8
			html2: STRING_8
			htmldir: STRING_8
			path: STRING_8
		do
			answer.set_reply_text ("")
			html1 := " <html> <head> <title> NINO HTTPD </title> " + "    </head>   " + "       <body>    " + " <h1> Welcome to NINO HTTPD! </h1> " + " <p>  Default page  "
			html2 := " </p> " + " </body> " + " </html> "
			path := script_name
			if path[path.count] = '/' then
				path.remove_tail (1)
			end
			create l_dir.make_open_read (f.name)
			files := l_dir.linear_representation
			from
				files.start
				htmldir := "<ul>"
			until
				files.after
			loop
				htmldir := htmldir + "<li><a href=%"" + path + "/" + files.item_for_iteration + "%">" + files.item_for_iteration + "</a> </li>%N"
				files.forth
			end
			htmldir := htmldir + "</ul>"
			answer.append_reply_text (html1 + htmldir + html2)
		end

end -- class GET_REQUEST_HANDLER

