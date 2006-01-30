indexing
	description:
		"AST representation of an access in an invariant beginning a %
		%call expression or instruction or an access after a creation for %
		%which there is no standard export validation like in %
		%ACCESS_FEAT_AS."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ACCESS_INV_AS

inherit
	ACCESS_FEAT_AS
		redefine
			process, is_qualified
		end

create
	make

feature{NONE} -- Initialization

	make (f: like feature_name; p: like internal_parameters; s_as: like dot_symbol) is
			-- Create a new FEATURE_ACCESS AST node.
		do
			initialize (f, p)
			dot_symbol := s_as
		ensure
			dot_symbol_set: dot_symbol = s_as
		end

feature -- Attributes

	is_qualified: BOOLEAN is
			-- Is current entity a call on an other object?
		do
			Result := False
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_access_inv_as (Current)
		end

feature -- Roundtrip

	dot_symbol: SYMBOL_AS;
			-- Symbol "." associated with this structure

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

end -- class ACCESS_INV_AS
