indexing
	description: "Word counter"
	external_name: "ISE.Examples.WordCount.WordCounter"

class
	WORD_COUNTER

inherit
	STATICS

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize data structures."
			external_name: "Make"
		do
			create word_counter.make
		ensure
			non_void_word_counter: word_counter /= Void
		end

feature -- Access		

	total_lines: INTEGER
		indexing
			description: "[Each object of this class keeps a running total of the files its processed%
					%The following member holds this running information]"
			external_name: "TotalLines"
		end
		
	total_words: INTEGER
		indexing
			description: "[Each object of this class keeps a running total of the files its processed%
					%The following member holds this running information]"
			external_name: "TotalWords"
		end
		
	total_chars: INTEGER
		indexing
			description: "[Each object of this class keeps a running total of the files its processed%
					%The following member holds this running information]"
			external_name: "TotalChars"
		end
		
	total_bytes: INTEGER
		indexing
			description: "[Each object of this class keeps a running total of the files its processed%
					%The following member holds this running information]"
			external_name: "TotalBytes"
		end
		
	pnum_lines: INTEGER
		indexing
			description: "Intermediary count value set by `count_stats'"
			external_name: "PnumLines"
		end
		
	pnum_words: INTEGER
		indexing
			description: "Intermediary count value set by `count_stats'"
			external_name: "PnumWords"
		end
		
	pnum_chars: INTEGER
		indexing
			description: "Intermediary count value set by `count_stats'"
			external_name: "PnumChars"
		end
		
	pnum_bytes: INTEGER
		indexing
			description: "Intermediary count value set by `count_stats'"
			external_name: "PnumBytes"
		end

    	word_counter: SYSTEM_COLLECTIONS_SORTEDLIST
		 indexing
		 	description: "The set of all words seen (sorted alphabetically)"
		 	external_name: "WordCounter"
		 end

	count_stats (pathname: STRING): BOOLEAN is
		indexing
			description: "[This method calculates the statistics for a single file.%
						%This file's info is returned via the attributes `ptotal_lines'...`ptotal_bytes'.%
						%The running total of all files is maintained in the data members]"
			external_name: "CountStats"
		require
			non_void_pathname: pathname /= Void
		local
			fs_in: SYSTEM_IO_FILESTREAM
			sr: SYSTEM_IO_STREAMREADER
			word: INTEGER
			line: STRING
			retried: BOOLEAN
			words: ARRAY [STRING]
			an_integer: INTEGER
			file_mode_open: SYSTEM_IO_FILEMODE
			file_access_read: SYSTEM_IO_FILEACCESS
			file_share_read: SYSTEM_IO_FILESHARE
			convert: SYSTEM_CONVERT
		do
			if not retried then
				pnum_bytes := 0
				pnum_chars := 0
				pnum_words := 0
				pnum_lines := 0
				create fs_in.make_filestream_2 (pathname, file_mode_open, file_access_read, file_share_read)
				pnum_bytes := convert.to_int32_int64 (fs_in.get_length)
				create sr.make_streamreader_4 (fs_in, encoding.get_default, True, 4096)
				from
					line := sr.read_line
				until
					line = Void
				loop
					pnum_lines := pnum_lines + 1
					pnum_chars := pnum_chars + line.get_length
					from
						words := line.split (Void)
						word := 0
					until
						word >= words.count
					loop
						if words.item (word) /= "" then
							-- Don't count empty strings
							pnum_words := pnum_words + 1
							if not word_counter.contains_key (words.item (word)) then
								-- If we've never seen this word before, add it to the sorted list with a count of 1
								word_counter.add (words.item (word), 1)
							else
								-- If we have seen this word before, just increment its count
								an_integer ?= word_counter.get_item (words.item (word)) 
								word_counter.set_item (words.item (word), an_integer + 1)
							end
						end
						word := word + 1
					end
					line := sr.read_line
				end
				sr.close
				total_lines := total_lines + pnum_lines
				total_words := total_words + pnum_words
				total_chars := total_chars + pnum_chars
				total_bytes := total_bytes + pnum_bytes
			end
			Result := not retried
		rescue
			if not retried then
				retried := True
				retry
			end
		end

	words_alphabetically_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		indexing
			description: "Enumerator for the words (sorted alphabetically)"
			external_name: "WordsAlphabeticallyEnumerator"
		do
			Result ?= word_counter.get_enumerator_idictionary_enumerator
		end

	words_by_occurence_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		indexing
			description: "Enumerator for the words (sorted by occurrence)"
			external_name: "WordsByOccurrenceEnumerator"
		local
			sorted_list: SYSTEM_COLLECTIONS_SORTEDLIST
			de: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR
			value: INTEGER
			key: STRING
		do
			de := words_alphabetically_enumerator
			from
				create sorted_list.make
			until
				not de.move_next
			loop
				-- For each word, we create a new WordOccurrence object which
				-- contains the word and its occurrence value.
				-- The WordOccurrence class contains a CompareTo method which knows
				-- to sort WordOccurrence objects by occurrence value and then alphabetically by the word itself.
				value ?= de.get_value
				key ?= de.get_key
				sorted_list.add (create {WORD_OCCURENCE}.make (value, key), Void)
			end
			Result := sorted_list.get_enumerator_idictionary_enumerator
		end

	unique_words: INTEGER is
		indexing
			description: "Number of unique words processed"
			external_name: "UniqueWords"
		do
			Result := word_counter.get_count
		ensure
			valid_count: Result >= 0
		end

end -- class WORD_COUNTER



