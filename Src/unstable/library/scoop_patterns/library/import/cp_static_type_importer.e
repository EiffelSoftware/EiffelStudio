note
	description:
	"[
		Import an object of type G by creating a new object
		with creation procedure {CP_IMPORTABLE}.make_from_separate.
		
		Note: The type of the imported object will be the static type G,
		not the dynamic type of the original object.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_STATIC_TYPE_IMPORTER [G -> CP_IMPORTABLE create make_from_separate end]

inherit
	CP_IMPORTER [G]

feature

	import (obj: separate G): G
			-- <Precursor>
		do
			create Result.make_from_separate (obj)
		end

end
