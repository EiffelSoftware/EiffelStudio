note
	description: ".NET events"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	CONSUMED_EVENT

inherit
	CONSUMED_ENTITY
		rename
			make as entity_make
		redefine
			eiffelized_consumed_entities,
			is_event,
			is_property_or_event,
			is_public
		end

create
	make

feature {NONE} -- Initialization

	make (dn: STRING; pub: BOOLEAN; decl_type: CONSUMED_REFERENCED_TYPE; cp_raiser, cp_adder, cp_remover: detachable CONSUMED_PROCEDURE)
			-- Initialize property with name `n' and type `type'.
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_declaring_type: decl_type /= Void
		do
			p := pub
			entity_make (dn, dn, pub, decl_type)
			i := cp_raiser
			a := cp_adder
			r := cp_remover
			if cp_raiser /= Void then
				cp_raiser.set_associated_entity (Current)
			end
			if cp_adder /= Void then
				cp_adder.set_associated_entity (Current)
			end
			if cp_remover /= Void then
				cp_remover.set_associated_entity (Current)
			end
		ensure
			dotnet_name_set: dotnet_name = dn
			raiser_set: raiser = cp_raiser
			adder_set: adder = cp_adder
			remover_set: remover = cp_remover
			valid_raiser: attached raiser as l_raiser implies l_raiser.is_property_or_event
		end

feature -- ConsumerWrapper functions

	is_event: BOOLEAN = True
			-- Is `Current' a .Net Event.

	is_property_or_event: BOOLEAN = True
			-- Is 'Current' a .NET Property or Event?

	is_public: BOOLEAN
			-- Is `Current' public.
		do
			Result := p
		end

feature -- Access

	eiffelized_consumed_entities: ARRAYED_LIST [CONSUMED_ENTITY]
			-- List of eiffelized Consumed Entities relative to `Current'.
		do
			create Result.make_from_iterable (eiffelized_consumed_procedures)
		end

	eiffelized_consumed_procedures: ARRAYED_LIST [CONSUMED_PROCEDURE]
			-- List of eiffelized procedures relative to `Current'.
		do
			create Result.make (3)
			if attached adder as l_adder then
				Result.extend (l_adder)
			end
			if attached remover as l_remover then
				Result.extend (l_remover)
			end
			if attached raiser as l_raiser then
				Result.extend (l_raiser)
			end
		end

	adder: detachable CONSUMED_PROCEDURE
			-- Property getter function
		do
			Result := a
		end

	remover: detachable CONSUMED_PROCEDURE
			-- Property setter procedure
		do
			Result := r
		end

	raiser: detachable CONSUMED_PROCEDURE
			-- Property setter procedure
		do
			Result := i
		end

feature {NONE} -- Access

	a: like adder
			-- Internal data for `adder'.

	r: like remover
			-- Internal data for `remover'.

	i: like raiser
			-- Internal data for `raiser'.

	p: like is_public;
			-- Internal data for `is_public'.

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
