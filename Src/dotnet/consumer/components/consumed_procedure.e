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
			has_arguments, arguments
		end
create
	make

feature {NONE} -- Initialization

	make (en, dn: STRING; args: like arguments; froz, static, defer, pub: BOOLEAN) is
			-- Initialize consumed method.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_arguments: args /= Void
		do
			member_make (en, dn, pub)
			arguments := args
			if froz then
				internal_flags := internal_flags | feature {FEATURE_ATTRIBUTE}.Is_frozen
			end
			if static then
				internal_flags := internal_flags | feature {FEATURE_ATTRIBUTE}.Is_static
			end
			if defer then
				internal_flags := internal_flags | feature {FEATURE_ATTRIBUTE}.Is_deferred
			end
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			arguments_set: arguments = args
			is_frozen_set: is_frozen = froz
			is_static_set: is_static = static
			is_deferred_set: is_deferred = defer
			is_public_set: is_public = pub
		end
		
feature -- Access

	arguments: ARRAY [CONSUMED_ARGUMENT]
			-- Feature arguments

feature -- Status report

	has_arguments: BOOLEAN is
			-- Does current have arguments?
		do
			Result := arguments /= Void and then arguments.count /= 0
		end
	
invariant
	non_void_arguments: arguments /= Void

end -- class CONSUMED_PROCEDURE
