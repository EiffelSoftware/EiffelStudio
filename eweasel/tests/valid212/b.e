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

	test
		do
			do_nothing
			if item = Void then
				create item.make
			end
		end
end
