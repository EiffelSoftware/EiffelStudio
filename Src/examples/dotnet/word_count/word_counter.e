class
	WORD_COUNTER

inherit
	STATICS

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize data structures.
		do
			create word_counter.make
		end

feature -- Access		

	total_lines, total_words, total_chars, total_bytes: INTEGER
			-- Each object of this class keeps a running total of the files its processed
			-- The following members hold this running information

	pnum_lines, pnum_words, pnum_chars, pnum_bytes: INTEGER
			-- Intermediary count values set by `count_stats'.

    word_counter: SYSTEM_COLLECTIONS_SORTEDLIST
		 	-- The set of all words seen (sorted alphabetically)

	count_stats (pathname: STRING): BOOLEAN is
			-- This method calculates the statistics for a single file.
			-- This file's info is returned via the attributes `ptotal_lines'...`ptotal_bytes'.
			-- The running total of all files is maintained in the data members
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
		do
			if not retried then
				pnum_bytes := 0
				pnum_chars := 0
				pnum_words := 0
				pnum_lines := 0
				create fs_in.make_filestream_2 (pathname, file_mode_open, file_access_read, file_share_read)
				pnum_bytes := fs_in.Length.ToInt32
				create sr.make_streamreader_3 (fs_in, encoding.Default, 4096, True)
				from
					line := sr.ReadLine
				until
					line = Void
				loop
					pnum_lines := pnum_lines + 1
					pnum_chars := pnum_chars + line.count
					from
						words := line.Split_array_System_Char (Void)
						word := 0
					until
						word >= words.count
					loop
						if words.item (word) /= "" then
							-- Don't count empty strings
							pnum_words := pnum_words + 1
							if not word_counter.ContainsKey (words.item (word)) then
								-- If we've never seen this word before, add it to the sorted list with a count of 1
								word_counter.Add (words.item (word), 1)
							else
								-- If we have seen this word before, just increment its count
								an_integer ?= word_counter.item (words.item (word)) 
								word_counter.set_item (words.item (word), an_integer + 1)
							end
						end
						word := word + 1
					end
					line := sr.ReadLine
				end
				sr.Close
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
			-- Enumerator for the words (sorted alphabetically)
		do
			Result ?= word_counter.GetEnumerator
		end

	words_by_occurence_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
			-- Enumerator for the words (sorted by occurrence)
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
				not de.MoveNext
			loop
				-- For each word, we create a new WordOccurrence object which
				-- contains the word and its occurrence value.
				-- The WordOccurrence class contains a CompareTo method which knows
				-- to sort WordOccurrence objects by occurrence value and then alphabetically by the word itself.
				value ?= de.Value
				key ?= de.Key
				sorted_list.Add (create {WORD_OCCURENCE}.make (value, key), Void)
			end
			Result := sorted_list.GetEnumerator
		end

	unique_words: INTEGER is
			-- Number of unique words processed
		do
			Result := word_counter.count
		ensure
			valid_count: Result >= 0
		end

end -- class WORD_COUNTER



