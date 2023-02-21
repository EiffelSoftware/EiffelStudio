note
	description: ".NET properties"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_PROPERTY

inherit
	CONSUMED_ENTITY
		rename
			make as entity_make
		redefine
			eiffelized_consumed_entities,
			is_property,
			is_property_or_event,
			is_public,
			is_static
		end

create
	make,
	make_with_updated_getter

feature {NONE} -- Initialization

	make (dn: STRING; pub, stat: BOOLEAN; decl_type: CONSUMED_REFERENCED_TYPE; cp_getter: detachable CONSUMED_FUNCTION; cp_setter: detachable CONSUMED_PROCEDURE)
			-- Initialize property.
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_declaring_type: decl_type /= Void
			getter_or_setter: cp_getter = Void implies cp_setter /= Void
			getter_or_setter: cp_setter = Void implies cp_getter /= Void
		do
			p := pub
			t := stat
			entity_make (dn, dn, pub, decl_type)

			if cp_getter /= Void then
					-- Remove eventual "get_"
				cp_getter.update_dotnet_eiffel_name_for_getter
			end

			g := cp_getter
			s := cp_setter

			if cp_getter /= Void then
				cp_getter.set_associated_entity (Current)
			end
			if cp_setter /= Void then
				cp_setter.set_associated_entity (Current)
			end
		ensure
			dotnet_name_set: dotnet_name = dn
			getter_set: getter = cp_getter
			setter_set: setter = cp_setter
		end

feature {CONSUMER_ACCESS} -- Initialization		

	make_with_updated_getter (dn: STRING; pub, stat: BOOLEAN; decl_type: CONSUMED_REFERENCED_TYPE; cp_getter: detachable CONSUMED_FUNCTION; cp_setter: detachable CONSUMED_PROCEDURE)
			-- Initialize property with `cp_getter` already updated for the "get_" removal.
			-- Mostly needed when rebuilding property object from existing data (JSON).
			-- note: this avoids removing double "get_get_".
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_declaring_type: decl_type /= Void
			getter_or_setter: cp_getter = Void implies cp_setter /= Void
			getter_or_setter: cp_setter = Void implies cp_getter /= Void
		do
			p := pub
			t := stat
			entity_make (dn, dn, pub, decl_type)

			g := cp_getter
			s := cp_setter
			if cp_getter /= Void then
				cp_getter.set_associated_entity (Current)
			end
			if cp_setter /= Void then
				cp_setter.set_associated_entity (Current)
			end
		ensure
			dotnet_name_set: dotnet_name = dn
			getter_set: getter = cp_getter
			setter_set: setter = cp_setter
		end

feature -- ConsumerWrapper functions

	is_property: BOOLEAN
			-- Is `Current' a .Net Property.
		do
			Result := True
		end

	is_property_or_event: BOOLEAN
			-- Is 'Current' a .NET Property or Event?
		do
			Result := True
		end

	is_public: BOOLEAN
			-- Is `Current' public.
		do
			Result := p
		end

	is_static: BOOLEAN
			-- Is `Current' static.
		do
			Result := t
		end

feature -- Access

	eiffelized_consumed_entities: ARRAYED_LIST [CONSUMED_ENTITY]
			-- List of eiffelized Consumed Entities relative to `Current'.
		do
			create Result.make (0)
			if attached getter as l_getter then
				Result.extend (l_getter)
			end
			if attached setter as l_setter then
				Result.extend (l_setter)
			end
		end

	getter: detachable CONSUMED_FUNCTION
			-- Property getter function
		do
			Result := g
		end

	setter: detachable CONSUMED_PROCEDURE
			-- Property setter procedure
		do
			Result := s
		end

feature {NONE} -- Access

	g: like getter
			-- Internal data for `getter'.

	s: like setter
			-- Internal data for `setter'.

	p: like is_public
			-- Internal data for `is_public'.

	t: like is_static;
			-- Internal data for `is_static'.

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


end -- class CONSUMED_PROPERTY
