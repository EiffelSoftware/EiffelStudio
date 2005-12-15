indexing
	description: "Objects that represent a list of identifiers"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IDENTIFIER_LIST

inherit
	CONSTRUCT_LIST [INTEGER]

create
	make

feature
	id_list: EIFFEL_LIST [ID_AS] is
			-- List to store ID_AS objects in this structure.
		do
			if internal_id_list = Void then
				create internal_id_list.make (capacity)
			end
			Result := internal_id_list
		end

feature{NONE} -- Implementation

	internal_id_list: EIFFEL_LIST [ID_AS]
			-- Internal id list
end
