indexing
	description: ".NET function as seen in Eiffel"

class
	CONSUMED_FUNCTION

inherit
	CONSUMED_PROCEDURE
		rename
			make as method_make
		end

create
	make

feature {NONE} -- Initialization

	make (en, dn: STRING; args: like arguments; ret: like return_type; froz, static, defer, inf, pref: BOOLEAN) is
			-- Initialize consumed method.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_arguments: args /= Void
			non_void_return_type: ret /= Void
		do
			method_make (en, dn, args, froz, static, defer)
			return_type := ret
			is_infix := inf
			is_prefix := pref
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			arguments_set: arguments = args
			return_type_set: return_type = ret
			is_frozen_set: is_frozen = froz
			is_static_set: is_static = static
			is_deferred_set: is_deferred = defer
			is_infix_set: is_infix = inf
			is_prefix_set: is_prefix = pref
		end

feature -- Access

	return_type: CONSUMED_REFERENCED_TYPE
			-- Function return type

	is_infix: BOOLEAN
			-- Is function an infix feature?
			
	is_prefix: BOOLEAN
			-- Is function a prefix feature?

invariant
	non_void_return_type: return_type /= Void

end -- class CONSUMED_FUNCTION
