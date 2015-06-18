note
	description: "Importer for STRING objects."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_STRING_IMPORTER

inherit
	CP_IMPORTER [STRING]

feature

	import (object: separate STRING): STRING
			-- <Precursor>
		do
			create Result.make_from_separate (object)
		end

end
