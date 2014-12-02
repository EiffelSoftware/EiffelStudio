note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	WIKI_TO_XHTML

inherit
	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			args: ARGUMENTS_32
			fn: detachable READABLE_STRING_32
			p: PATH
			wi: WIKI_INDEX
			wp: WIKI_PAGE
			i,n: INTEGER
			vis: WIKI_VISITOR
			l_to_stdout: BOOLEAN
			l_append_to_file: detachable READABLE_STRING_GENERAL
			l_save_to_file: detachable READABLE_STRING_GENERAL
			s: STRING
			l_files: ARRAYED_LIST [READABLE_STRING_32]
			l_header_tpl, l_footer_tpl: detachable READABLE_STRING_GENERAL
			tpl: STRING
			is_help: BOOLEAN
		do
			create args
			if attached args.argument_array as arr then
				create l_files.make (arr.count)
				from
					i := arr.lower + 1
					n := arr.upper
				until
					i > n
				loop
					if arr[i].starts_with ("-") then
						if arr[i].same_string_general ("--stdout") then
							l_to_stdout := True
						elseif
							arr[i].same_string_general ("--to-file") or
							arr[i].same_string_general ("-f")
						then
							i := i + 1
							if arr.valid_index (i) then
								l_save_to_file := arr[i]
							end
						elseif
							arr[i].same_string_general ("--append-to-file") or
							arr[i].same_string_general ("-a")
						then
							i := i + 1
							if arr.valid_index (i) then
								l_append_to_file := arr[i]
							end
						elseif arr[i].same_string_general ("--header") then
							i := i + 1
							if arr.valid_index (i) then
								l_header_tpl := arr[i]
							end
						elseif arr[i].same_string_general ("--footer") then
							i := i + 1
							if arr.valid_index (i) then
								l_footer_tpl := arr[i]
							end
						else
						end
					elseif
						arr[i].same_string_general ("--help") or
						arr[i].same_string_general ("-h")
					then
						is_help := True
					else
						l_files.force (arr[i])
					end
					i := i + 1
				end
				if l_save_to_file = Void and l_append_to_file = Void then
					l_to_stdout := True
				end

				if is_help then
					print ("usage: wiki2xhtml {options} files ..%N")
					print ("  --stdout                    : output to console%N")
					print ("  -f%N  --to-file a_filename        : output into file %"a_filename%"%N")
					print ("  -a%N  --append-to-file a_filename : output appended into file %"a_filename%"%N")
					print ("%N")
					print ("  --header a_filename : use header template file %"a_filename%"%N")
					print ("  --footer a_filename : use footer template file %"a_filename%"%N")
					print ("%N")
					print ("  --help or -h : display this help.%N")
				else
					across
						l_files as c
					loop
						fn := c.item
						create p.make_from_string (fn)
						io.error.put_string ("Analyze " + p.utf_8_name + "%N")

						if fn.ends_with_general (".index") then
							create {WIKI_DEBUG_VISITOR} vis.make
							create wi.make ("Book", p)
							wi.analyze
							if attached wi.book as b then
								b.process (vis)
							end
						elseif attached p.extension as ext then
							create s.make (1024)
							create {WIKI_XHTML_GENERATOR} vis.make (s)
							if attached p.entry as e then
								create wp.make_with_title (e.utf_8_name)
							else
								create wp.make_with_title ("Index")
							end

							wp.get_structure (p)
							debug
								wp.process (create {WIKI_DEBUG_VISITOR}.make);
							end
							wp.process (vis)

							if l_header_tpl /= Void then
								tpl := text_from_file (l_header_tpl)
								if not tpl.is_empty then
									tpl.replace_substring_all ("$WIKIPAGENAME", wp.title)
								end
								s.prepend (tpl)
							end
							if l_footer_tpl /= Void then
								tpl := text_from_file (l_footer_tpl)
								if not tpl.is_empty then
									tpl.replace_substring_all ("$WIKIPAGENAME", wp.title)
								end
								s.append (tpl)
							end

							if l_append_to_file /= Void then
								append_text_to (s, create {PATH}.make_from_string (l_append_to_file))
								io.error.put_string ("Appended HTML to file " + l_append_to_file.as_string_8 + "%N")
							end
							if l_save_to_file /= Void then
								save_text_to (s, create {PATH}.make_from_string (l_save_to_file))
								io.error.put_string ("Saved HTML to file " + l_save_to_file.as_string_8 + "%N")
							end
							if l_to_stdout then
								print (s)
							end
						end
					end
				end
			end
		end

	append_text_to (s: READABLE_STRING_8; fn: PATH)
		local
			f: RAW_FILE
		do
			create f.make_with_path (fn)
			if not f.exists or else f.is_access_writable then
				f.open_append
				f.put_string (s)
				f.close
			else
				io.error.put_string ("[ERROR] could not save to file!%N")
			end
		end

	save_text_to (s: READABLE_STRING_8; fn: PATH)
		local
			f: RAW_FILE
		do
			create f.make_with_path (fn)
			if not f.exists or else f.is_access_writable then
				f.create_read_write
				f.put_string (s)
				f.close
			else
				io.error.put_string ("[ERROR] could not save to file!%N")
			end
		end

	text_from_file (fn: READABLE_STRING_GENERAL): STRING
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make_with_name (fn)
			if f.exists and then f.is_access_readable then
				f.open_read
				from
					create Result.make (1_024)
				until
					f.exhausted
				loop
					f.read_stream_thread_aware (1_024)
					Result.append (f.last_string)
				end
				f.close
			else
				Result := ""
			end
		end


feature -- Status

feature -- Access

feature -- Change

feature {NONE} -- Implementation

invariant
--	invariant_clause: True

end
