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

feature -- Initialization

	make (a_name: STRING) is 
			-- Create with name as 'a_name' and with features 'a_features'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
		do
			name := a_name
			set_export_status (True)
		end
		
feature -- Properties

	name: STRING
			-- Category name of clause (i.e. 'Access')
			
	is_exported: BOOLEAN
			-- Are items exported?  Yes by default.
			
feature -- Status Setting

	set_export_status (a_flag: BOOLEAN) is
			-- Set 'is_exported' to reflect 'a_flag'.
		require
			flag_not_void: a_flag /= Void
		do
			is_exported := a_flag
		ensure
			exported_set: is_exported = a_flag
		end

end -- class DOTNET_FEATURE_CLAUSE_AS
