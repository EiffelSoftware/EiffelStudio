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
			has_arguments, arguments, q, dotnet_eiffel_name
		end
create
	make,
	make_attribute_setter

feature {NONE} -- Initialization

	make (en, dn, den: STRING; args: like arguments; froz, static, defer, pub, ns, virt, poe: BOOLEAN;
			a_type: CONSUMED_REFERENCED_TYPE)
		is
			-- Initialize consumed method.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_dotnet_eiffel_name: den /= Void
			valid_dotnet_eiffel_name: not den.is_empty
			non_void_arguments: args /= Void
			a_type_not_void: a_type /= Void
		do
			member_make (en, dn, pub, a_type)
			if not den.is_equal (en) then
				q := den
			end
			a := args
			if froz or not virt then
				f := f | {FEATURE_ATTRIBUTE}.Is_frozen
			end
			if static then
				f := f | {FEATURE_ATTRIBUTE}.Is_static
			end
			if defer then
				f := f | {FEATURE_ATTRIBUTE}.Is_deferred
			end
			if ns then
				f := f | {FEATURE_ATTRIBUTE}.Is_newslot
			end
			if virt then
				f := f | {FEATURE_ATTRIBUTE}.Is_virtual
			end
			if poe then
				f := f | {FEATURE_ATTRIBUTE}.Is_property_or_event				
			end
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			dotnet_eiffel_name_set: equal (dotnet_eiffel_name, den)
			arguments_set: arguments = args
			is_frozen_set: is_frozen = froz or is_frozen = not virt
			is_static_set: is_static = static
			is_deferred_set: is_deferred = defer
			is_public_set: is_public = pub
			is_new_slot_set: is_new_slot = ns
			is_virtual_set: is_virtual = virt
			is_property_or_event_set: is_property_or_event = poe
			declared_type_set: declared_type = a_type
		end

	make_attribute_setter (en, dn: STRING; arg: CONSUMED_ARGUMENT; a_type: CONSUMED_REFERENCED_TYPE; a_is_static: BOOLEAN) is
			-- Initialize consumed method.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_arguments: arg /= Void
			a_type_not_void: a_type /= Void
		do
			member_make (en, dn, True, a_type)
			a := <<arg>>
			f := f | {FEATURE_ATTRIBUTE}.Is_frozen
			if a_is_static then
				f := f | {FEATURE_ATTRIBUTE}.Is_static	
			end
			f := f | {FEATURE_ATTRIBUTE}.Is_attribute_setter
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = en
			donet_eiffel_name_set: equal (dotnet_eiffel_name, en)
			is_frozen_set: is_frozen = True
			is_static_set: is_static = a_is_static
			is_deferred_set: is_deferred = False
			is_public_set: is_public = True
			is_new_slot_set: is_new_slot = False
			is_virtual_set: is_virtual = False
			is_property_or_event_set: is_property_or_event = False
			is_attribute_setter_set: is_attribute_setter = True
			declared_type_set: declared_type = a_type
		end

feature -- Access

	arguments: ARRAY [CONSUMED_ARGUMENT] is
			-- Feature arguments
		do
			Result := a
		end

	dotnet_eiffel_name: STRING is
			-- Eiffel entity name without overloading resolved.
		do
			if q = Void then
					-- If `q' is not set then it is identical to the `eiffel_name'.
				Result := e
			else
				Result := q
			end
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

	q: like dotnet_eiffel_name
			-- Internal data for `dotnet_eiffel_name'.

end -- class CONSUMED_PROCEDURE
