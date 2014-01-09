note
	description: "Summary description for {PS_RELATIONAL_REPOSITORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_RELATIONAL_REPOSITORY

inherit
	PS_DEFAULT_REPOSITORY
		redefine
			is_expanded, initialize
		end

create
	make_from_factory

feature {PS_ABEL_EXPORT} -- Status Report

	is_expanded (type: TYPE [detachable ANY]): BOOLEAN
			-- <Precursor>
		do
			Result := type.is_expanded or else expanded_type_override.has (type)
		end

feature {PS_REPOSITORY_FACTORY} -- Initialization

	override_expanded_type (type: TYPE [detachable ANY])
			-- Treat `type' like an expanded type.
		do
			expanded_type_override.extend (True, type)
		end

	initialize
			-- <Precursor>
		do
			Precursor
			create expanded_type_override.make (1)
		end

feature {NONE} -- Implementation

	expanded_type_override: HASH_TABLE [BOOLEAN, TYPE [detachable ANY]]
			-- A table to override types which should be treated as if expanded.

end
