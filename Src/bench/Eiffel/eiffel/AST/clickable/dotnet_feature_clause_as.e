indexing
	description: "[
		Abstraction of a dotnet feature clause.  Used for formatting .NET type information.
		Is actually just a list of consumed_entities.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	DOTNET_FEATURE_CLAUSE_AS [G -> CONSUMED_ENTITY]

inherit
	LINKED_LIST [G]
		rename 
			make as make_list
		end

create
	make
	
create {DOTNET_FEATURE_CLAUSE_AS}
	make_list

feature -- Initialization

	make (a_name: STRING; a_flag: BOOLEAN) is 
			-- Create with name as 'a_name' and with features 'a_features'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			name := a_name
			is_exported := a_flag
		ensure
			name_set: name = a_name
			exported_set: is_exported = a_flag
		end
		
feature -- Properties

	name: STRING
			-- Category name of clause (i.e. 'Access')
			
	is_exported: BOOLEAN
			-- Are items exported?  Yes by default.
			
invariant
	name_not_void: name /= Void
	name_not_empty: not name.is_empty

end -- class DOTNET_FEATURE_CLAUSE_AS
