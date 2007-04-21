indexing
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	archive: "$Archive: $"

deferred class X
	inherit
		ANY
			redefine
				default_create
			end

feature {NONE}
	default_create
		do
			Precursor
			initialize
		end

	make (a_string: STRING)
		do
		end

	initialize
		do
		end
end
