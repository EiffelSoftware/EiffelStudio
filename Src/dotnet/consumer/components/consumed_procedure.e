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

	make (en, dn: STRING; args: like arguments; froz, static, defer, pub, ns, virt, poe: BOOLEAN;
			a_type: CONSUMED_REFERENCED_TYPE)
		is
			-- Initialize consumed method.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_arguments: args /= Void
			a_type_not_void: a_type /= Void
		do
			member_make (en, dn, pub, a_type)
			a := args
			if froz or not virt then
				f := f | feature {FEATURE_ATTRIBUTE}.Is_frozen
			end
			if static then
				f := f | feature {FEATURE_ATTRIBUTE}.Is_static
			end
			if defer then
				f := f | feature {FEATURE_ATTRIBUTE}.Is_deferred
			end
			if ns then
				f := f | feature {FEATURE_ATTRIBUTE}.Is_newslot
			end
			if virt then
				f := f | feature {FEATURE_ATTRIBUTE}.Is_virtual
			end
			if poe then
				f := f | feature {FEATURE_ATTRIBUTE}.Is_property_or_event				
			end
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			arguments_set: arguments = args
			is_frozen_set: is_frozen = froz
			is_static_set: is_static = static
			is_deferred_set: is_deferred = defer
			is_public_set: is_public = pub
			is_new_slot_set: is_new_slot = ns
			is_virtual_set: is_virtual = virt
			is_property_or_event_set: is_property_or_event = poe
			declared_type_set: declared_type = a_type
		end
		
feature -- Access

	arguments: ARRAY [CONSUMED_ARGUMENT] is
			-- Feature arguments
		do
			Result := a
		end

feature -- Status report

	has_arguments: BOOLEAN is
			-- Does current have arguments?
		do
			Result := arguments /= Void and then arguments.count /= 0
		end
		
feature {NONE} -- Access

	a: like arguments
			-- Internal data for `arguments'.

invariant
	non_void_arguments: arguments /= Void

end -- class CONSUMED_PROCEDURE
