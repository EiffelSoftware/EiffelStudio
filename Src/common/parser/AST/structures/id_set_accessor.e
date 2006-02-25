indexing
	description: "ID_SET accessor."
	date: "$Date$"
	revision: "$Revision$"

class
	ID_SET_ACCESSOR

inherit
	ID_SET

feature -- Access

	id_set: ID_SET is
			-- Access the id set.
		do
			Result := Current
		end

feature -- Update

	set_id_set (an_id_set: ID_SET) is
			-- Set the id_set.
		do
			first := an_id_set.first
			if an_id_set.count > 0 then
				area := an_id_set.area.twin
			end
		end


end
