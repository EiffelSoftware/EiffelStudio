class
	APPLICATION

inherit
	STATICS

create
	make

feature {NONE} -- Initialization

	make is
			-- Entry point.
		local
			ap: WORD_COUNT_ARG_PARSER
			fs_out: SYSTEM_IO_FILESTREAM
			sw: SYSTEM_IO_STREAMWRITER
			wc: WORD_COUNTER
			str: STRING
			de: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR
			word_occurences: WORD_OCCURENCE
			args: ARRAY [STRING]
			e: SYSTEM_COLLECTIONS_IENUMERATOR
			a_boolean: BOOLEAN
		do
			args := Environment.GetCommandLineArgs
			create ap.build
			if ap.parse (args) then
				if ap.output_filename /= Void then
					create fs_out.make_filestream_2 (ap.output_filename, file_mode_create, file_access_write, file_share_none)
					create sw.make_streamwriter (fs_out)
					Console.SetOut (sw)
				end
				create wc.make
				Console.WriteLine_system_string ("Lines%TWords%TChars%TBytes%TPathname")
					-- Write table header
				e := ap.pathname_enumerator
				from
				until
					not e.MoveNext
				loop
					str ?= e.Current_
					a_boolean := wc.count_stats (str)
					Console.WriteLine_system_string (String.Format_System_String_array_System_Object ("{0,5}%T{1,5}%T{2,5}%T{3,5}%T{4,5}",
								<<wc.pnum_lines.ToString, wc.pnum_words.ToString, wc.pnum_chars.ToString, wc.pnum_bytes.ToString, str>>))
				end
				Console.WriteLine_system_string ("-----%T-----%T-----%T-----%T---------------------")
					-- Done processing all files, show the totals
				Console.WriteLine_system_string ( String.Format_System_String_Array_System_Object ("{0,5}%T{1,5}%T{2,5}%T{3,5}%TTotal in all files",
								<<wc.total_lines, wc.total_words, wc.total_chars, wc.total_bytes>>))
				if ap.aphabetical_usage_showed then
					-- If the user wants to see the word usage alphabetically, show it
					de := wc.words_alphabetically_enumerator
					Console.WriteLine_system_string (String.Format_System_String_System_Object ("Word usage sorted alphabetically ({0} unique words)",
									wc.unique_words))
					from
					until
						not de.MoveNext
					loop
						Console.WriteLine_system_string (String.Format_System_String_System_Object_System_Object ("{0,5}: {1}",
										de.Value, de.Key))
					end
				end
				if ap.occurence_usage_showed then
					-- If the user wants to see the word usage alphabetically, show it
					de := wc.words_by_occurence_enumerator
					Console.WriteLine_system_string (String.Format_System_String_System_Object ("Word usage sorted by occurrence ({0} unique words)",
									wc.unique_words))
					from
					until
						not de.MoveNext
					loop
						word_occurences ?= de.Key
						Console.WriteLine_system_string (String.Format_System_String_System_Object_System_Object ("{0,5}: {1}",
										word_occurences.occurences, word_occurences.word))
					end
				end
				Console.Out.Close
					-- Explicitly close the console to guarantee that the StreamWriter object (sw) is flushed
				if fs_out /= Void then
					fs_out.Close
				end
			end
		end

end -- class APPLICATION


