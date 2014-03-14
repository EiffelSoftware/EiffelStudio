note
	description: "Objects with an unique id."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESA_IDABLE


feature -- Access

	id: INTEGER
			-- Unique id
			-- Can be used tp represent an object in a database
		deferred
		end

feature	-- Status Report

	has_id: BOOLEAN
		do
			Result := id > 0
		end

feature -- Element Change

	set_id (a_id: INTEGER)
			-- Set `id' with `a_id'
		require
			id_positive: a_id >= 0
		deferred
		ensure
			id_set: id = a_id
		end

end
