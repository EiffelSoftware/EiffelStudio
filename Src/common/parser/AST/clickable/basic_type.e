indexing
	description: "AST representation of an Eiffel basic type."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BASIC_TYPE

inherit
	EIFFEL_TYPE

	CLICKABLE_AST
		redefine
			is_class
		end

feature {AST_FACTORY} -- Initialization

	initialize is
			-- Create a new BASIC_TYPE AST node.
		do
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

end -- class BASIC_TYPE
