indexing
	description: "Type referenced by other types (as parent or interface) to be persisted to XML"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_REFERENCED_TYPE

inherit
	ANY
		redefine
			is_equal
		end

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
			internal_name := n
			assembly_id := id
		ensure
			name_set: internal_name = n
			id_set: assembly_id = id
		end

feature -- Access

	name: STRING is
			-- .NET type name
		do
			Result := internal_name
		ensure
			name_not_void: Result /= Void
		end
	
	assembly_id: INTEGER
			-- Assembly containing type

feature {CONSUMED_ARGUMENT, OVERLOAD_SOLVER, CONSUMED_REFERENCED_TYPE} -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Only compare referenced types from same assembly as ids may change for other assemblies!
		do
			Result := other.name.is_equal (name) and other.assembly_id.is_equal (assembly_id)
		end

feature {NONE} -- Data storage

	internal_name: STRING
			-- Storage for type name.

invariant
	non_void_name: name /= Void
	valid_name: not name.is_empty
	valid_assembly_id: assembly_id > 0

end -- class CONSUMED_REFERENCE_TYPE
