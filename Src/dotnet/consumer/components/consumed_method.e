indexing
	description: ".NET method as seen by Eiffel"

class
	CONSUMED_METHOD

inherit
	CONSUMED_MEMBER
		rename
			make as member_make
		end
create
	make

feature {NONE} -- Initialization

	make (en, dn: STRING; args: like arguments; froz, static, defer: BOOLEAN) is
			-- Initialize consumed method.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_arguments: args /= Void
		do
			member_make (en, dn)
			arguments := args
			is_frozen := froz
			is_static := static
			is_deferred := defer
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			arguments_set: arguments = args
			is_frozen_set: is_frozen = froz
			is_static_set: is_static = static
			is_deferred_set: is_deferred = defer
		end
		
feature -- Access

	arguments: ARRAY [CONSUMED_ARGUMENT]
			-- Feature arguments
	
	is_frozen: BOOLEAN
			-- Is feature frozen?
	
	is_static: BOOLEAN
		-- Is .NET member static?

	is_deferred: BOOLEAN
			-- Is feature deferred?
	
invariant
	non_void_arguments: arguments /= Void

end -- class CONSUMED_METHOD
