indexing
	description: ".NET function as seen in Eiffel"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_FUNCTION

inherit
	CONSUMED_PROCEDURE
		rename
			make as method_make
		redefine
			has_return_value, return_type, is_infix, is_prefix
		end

create
	make

feature {NONE} -- Initialization

	make (en, dn: STRING; args: like arguments; ret: like return_type;
			froz, static, defer, inf, pref, pub, ns, virt, poe: BOOLEAN;
			a_type: CONSUMED_REFERENCED_TYPE)
		is
			-- Initialize consumed method.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_arguments: args /= Void
			non_void_return_type: ret /= Void
			a_type_not_void: a_type /= Void
		do
			method_make (en, dn, args, froz, static, defer, pub, ns, virt, poe, a_type)
			r := ret
			if inf then
				f := f | feature {FEATURE_ATTRIBUTE}.Is_infix
			end
			if pref then
				f := f | feature {FEATURE_ATTRIBUTE}.Is_prefix				
			end
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
			is_public_set: is_public = pub
			is_new_slot_set: is_new_slot = ns
			is_virtual_set: is_virtual = virt
			is_property_or_event_set: is_property_or_event = poe
			declared_type_set: declared_type = a_type
		end

feature -- Access

	return_type: CONSUMED_REFERENCED_TYPE is
			-- Function return type
		do
			Result := r
		end

feature -- Status report

	is_infix: BOOLEAN is
			-- Is function an infix feature?
		do
			Result := f & feature {FEATURE_ATTRIBUTE}.Is_infix =
				feature {FEATURE_ATTRIBUTE}.Is_infix
		end
			
	is_prefix: BOOLEAN is
			-- Is function a prefix feature?
		do
			Result := f & feature {FEATURE_ATTRIBUTE}.Is_prefix = 
				feature {FEATURE_ATTRIBUTE}.Is_prefix
		end

	has_return_value: BOOLEAN is True
			-- A function always return a value.

feature {NONE} -- Access

	r: like return_type
			-- Internal data for `return_type'.

invariant
	non_void_return_type: return_type /= Void

end -- class CONSUMED_FUNCTION
