indexing
	description: ".NET method as seen by Eiffel"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_PROCEDURE

inherit
	CONSUMED_MEMBER
		rename
			make as member_make
		redefine
			has_arguments, arguments, is_static, is_deferred
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
			if froz then
				internal_flags := internal_flags | Is_frozen_mask
			end
			if static then
				internal_flags := internal_flags | Is_static_mask
			end
			if defer then
				internal_flags := internal_flags | Is_deferred_mask
			end
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

feature -- Status report

	is_frozen: BOOLEAN is
			-- Is feature frozen?
		do
			Result := internal_flags & Is_frozen_mask = Is_frozen_mask
		end

	is_static: BOOLEAN is
			-- Is .NET member static?
		do
			Result := internal_flags & Is_static_mask = Is_static_mask
		end

	is_deferred: BOOLEAN is
			-- Is feature deferred?
		do
			Result := internal_flags & Is_deferred_mask = Is_deferred_mask
		end

	has_arguments: BOOLEAN is
			-- Does current have arguments?
		do
			Result := arguments /= Void and then arguments.count /= 0
		end
		
feature {NONE} -- Internal

	internal_flags: INTEGER
			-- Store status of current feature.

	is_frozen_mask: INTEGER is 1
	is_static_mask: INTEGER is 2
	is_deferred_mask: INTEGER is 4
			-- Different mask. Be careful when adding new mask
			-- to update descendants.
	
invariant
	non_void_arguments: arguments /= Void

end -- class CONSUMED_PROCEDURE
