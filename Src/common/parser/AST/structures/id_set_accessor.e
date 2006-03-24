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
		ensure
			id_set_not_void: Result /= Void
		end

feature -- Update

	set_id_set (an_id_set: ID_SET) is
			-- Set the id_set.
		require
			an_id_set_not_void: an_id_set /= Void
		do
			first := an_id_set.first
			if an_id_set.count > 1 then
				area := an_id_set.area.twin
			end
		end


end
