indexing
	description: "Object identification used in server storage"
	date: "$Date$"
	revision: "$Revision$"

deferred class IDABLE

inherit
	COMPILER_EXPORTER

feature

	id: INTEGER
			-- Object id

	set_id (i: INTEGER) is
			-- Set `id' to `i'
		do
			id := i
		ensure
			id_set: id = i
		end

end -- class IDABLE
