indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TEXT_FINDER

feature -- Initialization

	make (a_texts: like texts) is
			--
		do
			texts := a_texts
		end

feature -- Access

	texts: ARRAYED_LIST [STRING]

	texts_found: like texts

	found_indexs_in_texts : ARRAYED_LIST [INTEGER]

feature

	search (a_str: STRING) is
			--
		do

		end

invariant
	invariant_clause: True -- Your invariant here

end
