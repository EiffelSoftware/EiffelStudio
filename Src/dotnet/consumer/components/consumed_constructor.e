note
	description: ".NET type constructor as seen in Eiffel"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	CONSUMED_CONSTRUCTOR

inherit
	CONSUMED_ENTITY
		rename
			make as entity_make
		redefine
			dotnet_eiffel_name,
			has_arguments, arguments, is_public,
			is_frozen,
			is_constructor,
			set_is_public
		end

create
	make

feature {NONE} -- Initialization

	make (en: STRING; args: like arguments; pub: BOOLEAN; a_type: CONSUMED_REFERENCED_TYPE)
			-- Initialize consumed constructor.
		require
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_arguments: args /= Void
			a_type_not_void: a_type /= Void
		do
			entity_make (en, ".ctor", pub, a_type)
			a := args
		ensure
			eiffel_name_set: eiffel_name = en
			arguments_set: arguments = args
			is_public_set: is_public = pub
			declared_type_set: declared_type = a_type
		end

feature -- Access

	arguments: ARRAY [CONSUMED_ARGUMENT]
			-- Constructor arguments
		do
			Result := a
		end

	is_public: BOOLEAN
			-- Is constructor public?
		do
			Result := p
		end

	is_frozen: BOOLEAN = True
			-- A constructor cannot be redefined.

	is_constructor: BOOLEAN = True
			-- A constructor is a constructor.

	dotnet_eiffel_name: STRING = "make"
			-- Eiffelized name of .NET constructor.

feature -- Status report

	has_arguments: BOOLEAN
			-- Does current have arguments?
		do
			Result := arguments /= Void and then arguments.count /= 0
		end

feature -- Settings

	set_is_public (pub: like is_public)
			-- Set `is_public' with `pub'.
		do
			p := pub
		ensure then
			is_public_set: is_public = pub
		end

feature {NONE} -- Access

	a: like arguments
			-- Internal data for `arguments'.

	p: like is_public;
			-- Internal data for `is_public'.

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


end -- class CONSUMED_CONSTRUCTOR then
