indexing
	description: ".NET type name to be mapped to an Eiffel class name"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_NAME_SOLVER

inherit
	COMPARABLE
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (t: TYPE) is
			-- Initialize from .NET type `t'.
		require
			non_void_type: t /= Void
		do
			internal_type := t
			create simple_name.make_from_cil (internal_type.get_name)
			weight := t.get_full_name.split (dot_array).count - 1
		ensure
			non_void_internal_type: internal_type /= Void
			non_void_simple_name: simple_name /= Void
		end

feature -- Access

	weight: INTEGER
			-- Weight used to compare instances
	
	dot_array: NATIVE_ARRAY [CHARACTER] is
			-- <<.>>
		once
			create Result.make (1)
			Result.put (0, '.')
		end
	
	simple_name: STRING
			-- Simple type name (without namespace)

	eiffel_name: STRING
			-- Eiffel class name

feature -- Element Settings

	set_eiffel_name (name: like eiffel_name) is
			-- Set `eiffel_name' with `name'.
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		do
			eiffel_name := name
		ensure
			name_set: eiffel_name = name
		end
		
feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := weight < other.weight
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object of the same type
			-- as current object and identical to it?
		do
			Result := internal_type.equals_type (other.internal_type)
		end

feature {TYPE_NAME_SOLVER, ASSEMBLY_CONSUMER} -- Implementation

	internal_type: TYPE
			-- Type whose name is consumed

end -- class TYPE_NAME_SOLVER
