indexing
	description: "Objects that provide access to all Build reserved words."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BUILD_RESERVED_WORDS

feature -- Access

	build_reserved_words: ARRAYED_LIST [STRING] is
			--
		once
			create Result.make (0)
			Result.extend ("height")
			Result.compare_objects
		end
		

end -- class BUILD_RESERVED_WORDS
