indexing
	description: "Type referenced by other types (as parent or interface) to be persisted to XML"

class
	CONSUMED_REFERENCED_TYPE

create
	make

feature {NONE} -- Initialization

	make (n: STRING; id: INTEGER) is
			-- set `name' with `n'.
			-- Set `assembly_id' with `id'.
		require
			non_void_name: n /= Void
			valid_name: not n.is_empty
			valid_id: id > 0
		do
			name := n
			assembly_id := id
		ensure
			name_set: name = n
			id_set: assembly_id = id
		end

feature -- Access

	name: STRING
			-- .NET type name
	
	assembly_id: INTEGER
			-- Assembly containing type
		
end -- class CONSUMED_REFERENCE_TYPE
