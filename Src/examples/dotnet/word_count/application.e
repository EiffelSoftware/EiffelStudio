indexing
	description: "Application"
	external_name: "ISE.Examples.WordCount.Application"

class
	APPLICATION

inherit
	STATICS

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point"
			external_name: "Make"
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
			file_mode_create: SYSTEM_IO_FILEMODE
			file_access_write: SYSTEM_IO_FILEACCESS
			file_share_none: SYSTEM_IO_FILESHARE			
		do
			args := environment.get_command_line_args
			create ap.build
			if ap.parse (args) then
				if ap.output_filename /= Void then
					create fs_out.make_filestream_2 (ap.output_filename, file_mode_create.create_, file_access_write.write, file_share_none.none)
					create sw.make_streamwriter (fs_out)
					console.set_out (sw)
				end
				create wc.make
				console.write_line_string ("Lines%TWords%TChars%TBytes%TPathname")
					-- Write table header
				e := ap.pathname_enumerator
				from
				until
					not e.move_next
				loop
					str ?= e.get_current
					a_boolean := wc.count_stats (str)
					console.write_line_string (string.format ("{0,5}%T{1,5}%T{2,5}%T{3,5}%T{4,5}",
								<<wc.pnum_lines.to_string, wc.pnum_words.to_string, wc.pnum_chars.to_string, wc.pnum_bytes.to_string, str>>))
				end
				console.write_line_string ("-----%T-----%T-----%T-----%T---------------------")
					-- Done processing all files, show the totals
				console.write_line_string (string.format ("{0,5}%T{1,5}%T{2,5}%T{3,5}%TTotal in all files",
								<<wc.total_lines, wc.total_words, wc.total_chars, wc.total_bytes>>))
				if ap.aphabetical_usage_showed then
					-- If the user wants to see the word usage alphabetically, show it
					de := wc.words_alphabetically_enumerator
					console.write_line_string (string.format_string_object ("Word usage sorted alphabetically ({0} unique words)",
									wc.unique_words))
					from
					until
						not de.move_next
					loop
						console.write_line_string (string.format_string_object_object ("{0,5}: {1}",
										de.get_value, de.get_key))
					end
				end
				if ap.occurence_usage_showed then
					-- If the user wants to see the word usage alphabetically, show it
					de := wc.words_by_occurence_enumerator
					console.write_line_string (string.format_string_object ("Word usage sorted by occurrence ({0} unique words)",
									wc.unique_words))
					from
					until
						not de.move_next
					loop
						word_occurences ?= de.get_key
						console.write_line_string (string.format_string_object_object ("{0,5}: {1}",
										word_occurences.occurences, word_occurences.word))
					end
				end
				console.get_out.close
					-- Explicitly close the console to guarantee that the StreamWriter object (sw) is flushed
				if fs_out /= Void then
					fs_out.close
				end
			end
		end

end -- class APPLICATION


