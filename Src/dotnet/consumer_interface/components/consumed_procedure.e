note
	description: ".NET method as seen by Eiffel"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_PROCEDURE

inherit
	CONSUMED_MEMBER
		rename
			make as member_make
		redefine
			has_arguments, arguments, q
		end
create
	make,
	make_attribute_setter

feature {NONE} -- Initialization

	make (en, dn, den: STRING; args: like arguments; froz, static, defer, pub, ns, virt, poe: BOOLEAN;
			a_type: CONSUMED_REFERENCED_TYPE)

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
			else
				q := en
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

	make_attribute_setter (en, dn: STRING; arg: CONSUMED_ARGUMENT; a_type: CONSUMED_REFERENCED_TYPE; a_is_static: BOOLEAN)
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
			q := en
			a := <<arg>>
			f := f | {FEATURE_ATTRIBUTE}.Is_frozen
			if a_is_static then
				f := f | {FEATURE_ATTRIBUTE}.Is_static
			end
			f := f | {FEATURE_ATTRIBUTE}.Is_attribute_setter
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
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

feature -- Element change

	update_dotnet_eiffel_name_for_getter
			-- Update current for getter procedure of CONSUMED_PROPERTY.
			-- Remove the "get_".
		local
			l_name: like dotnet_eiffel_name
		do
			l_name := dotnet_eiffel_name
			if l_name.starts_with ("get_") then
				l_name.remove_head (4)
			end
		end

feature -- Access

	arguments: ARRAY [CONSUMED_ARGUMENT]
			-- Feature arguments
		do
			Result := a
		end

feature -- Status report

	has_arguments: BOOLEAN
			-- Does current have arguments?
		do
			Result := arguments /= Void and then arguments.count /= 0
		end

feature {NONE} -- Access

	a: like arguments
			-- Internal data for `arguments'.

	q: like dotnet_eiffel_name;
			-- Internal data for `dotnet_eiffel_name'.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CONSUMED_PROCEDURE
