class
	WORD_OCCURENCE

inherit
	SYSTEM_ICOMPARABLE
	ANY

create
	make

feature {NONE} -- Initialization

	make (occ: INTEGER; w: STRING) is
			-- Set `occurences' with `occ' and `word' with `w'.
		require
			valid_occurences: occ >= 0
			non_void_word: w /= Void
			valid_word: w.count > 0
		do
			occurences := occ
			word := w
		ensure
			occurences_set: occurences = occ
			word_set: word = w
		end

feature -- Access

	occurences: INTEGER
			-- Number of time the word occured
	
	word: STRING
			-- Word whose occurences are being counted

feature -- Comparison

	CompareTo (obj: ANY): INTEGER is
			-- Sort two WordOccurrence objects by occurrence first, then by word.
		local
			occ: WORD_OCCURENCE
		do
			occ ?= obj
			if obj /= Void then
				Result := occurences - occ.occurences
				if Result = 0 then
					-- Both objects have the same ccurrence, sort alphabetically by word
					Result := word.compare_system_string_system_string (word, occ.word)
				end
			end
		end

end -- class WORD_OCCURENCE
