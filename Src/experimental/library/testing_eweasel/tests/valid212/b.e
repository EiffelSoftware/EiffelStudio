indexing
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	archive: "$Archive: $"

class B [G -> X create make end]

inherit
	A
		rename
			item as item_renamed
		end

feature

	item: G

	s: STRING

	string_function: STRING
		do
		end

	test
		do
			do_nothing
			if item = Void then
				create item.make ("3")
				create item.make (s)
				create item.make (s.out)
				create item.make (string_function)
			end
		end
end
