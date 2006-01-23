indexing
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
	make

feature {NONE} -- Initialization

	make (dn: STRING; pub, stat: BOOLEAN; decl_type: CONSUMED_REFERENCED_TYPE; cp_getter: CONSUMED_FUNCTION; cp_setter: CONSUMED_PROCEDURE) is
			-- Initialize event.
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_declaring_type: decl_type /= Void
			getter_or_setter: cp_getter = Void implies cp_setter /= Void
			getter_or_setter: cp_setter = Void implies cp_getter /= Void
		local
			l_name: like dotnet_eiffel_name
		do
			n := dn
			p := pub
			t := stat
			entity_make (dn, pub, decl_type)
			g := cp_getter
				-- Remove `get_' from property name.
			if g /= Void then
				l_name := g.dotnet_eiffel_name
				if l_name.count > 4 and then l_name.substring (1, 4).is_equal ("get_") then
					l_name.remove_head (4)
				end
			end
			s := cp_setter
		ensure
			dotnet_name_set: dotnet_name = dn
			getter_set: getter = cp_getter
			setter_set: setter = cp_setter
		end
	
feature -- ConsumerWrapper functions

	is_property: BOOLEAN is
			-- Is `Current' a .Net Property.
		do
			Result := True
		end
		
	is_property_or_event: BOOLEAN is
			-- Is 'Current' a .NET Property or Event?
		do
			Result := True
		end
		
	is_public: BOOLEAN is
			-- Is `Current' public.
		do
			Result := p
		end
			
	is_static: BOOLEAN is
			-- Is `Current' static.
		do
			Result := t
		end

feature -- Access

	eiffelized_consumed_entities: ARRAYED_LIST [CONSUMED_ENTITY] is
			-- List of eiffelized Consumed Entities relative to `Current'.
		do
			create Result.make (0)
			if getter /= Void then
				Result.extend (getter)
			end
			if setter /= Void then
				Result.extend (setter)
			end
		end

	getter: CONSUMED_FUNCTION is
			-- Property getter function
		do
			Result := g
		end
	
	setter: CONSUMED_PROCEDURE is
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
