indexing
	description: "Word occurrence"
	external_name: "ISE.Examples.WordCount.WordOccurrence"
	
class
	WORD_OCCURENCE

inherit
	SYSTEM_ICOMPARABLE
	ANY

create
	make

feature {NONE} -- Initialization

	make (occ: INTEGER; w: STRING) is
		indexing
			description: "Set `occurences' with `occ' and `word' with `w'."
			external_name: "Make"
		require
			valid_occurences: occ >= 0
			non_void_word: w /= Void
			valid_word: w.get_length > 0
		do
			occurences := occ
			word := w
		ensure
			occurences_set: occurences = occ
			word_set: word = w
		end

feature -- Access

	occurences: INTEGER
		indexing
			description: "Number of time the word occured"
			external_name: "Occurrences"
		end
	
	word: STRING
		indexing
			description: "Word whose occurences are being counted"
			external_name: "Word"
		end

feature -- Comparison

	compare_to (obj: ANY): INTEGER is
		indexing
			description: "Sort two WordOccurrence objects by occurrence first, then by word."
			external_name: "CompareTo"
		local
			occ: WORD_OCCURENCE
		do
			occ ?= obj
			if obj /= Void then
				Result := occurences - occ.occurences
				if Result = 0 then
					-- Both objects have the same ccurrence, sort alphabetically by word
					Result := word.compare (word, occ.word)
				end
			end
		end

end -- class WORD_OCCURENCE

--|----------------------------------------------------------------
--| .NET: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

