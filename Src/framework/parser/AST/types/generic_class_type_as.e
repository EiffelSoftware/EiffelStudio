note
	description: "Representation of generic classes."
	date: "$Date$"
	revision: "$Revision$"

class
	GENERIC_CLASS_TYPE_AS

inherit
	CLASS_TYPE_AS
		rename
			initialize as class_type_initialize
		redefine
			dump,
			generics,
			has_anchor,
			is_fixed,
			last_token,
			process
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (n: like class_name; g: attached like generics)
			-- Create a new CLASS_TYPE AST node.
		require
			n_not_void: n /= Void
			g_not_void: g /= Void
			n_upper: n.name.is_equal (n.name.as_upper)
		do
			class_type_initialize (n)
			internal_generics := g
		ensure
			class_name_set: class_name.name.is_equal (n.name)
			internal_generics_set: internal_generics = g
		end

feature -- Status

	has_anchor: BOOLEAN
			-- <Precursor>
		do
			if attached generics as g then
				Result := g.there_exists (agent {TYPE_AS}.has_anchor)
			end
		end

	is_fixed: BOOLEAN
			-- <Precursor>
		do
			Result :=
				across
					internal_generics as g
				all
					g.is_fixed
				end
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_generic_class_type_as (Current)
		end

feature -- Access

	generics: detachable TYPE_LIST_AS
			-- Possible generical parameters
		do
			Result := internal_generics
			if Result.is_empty then
				Result := Void
			end
		end

feature -- Roundtrip

	internal_generics: attached like generics
			-- Internal actual generic parameters.

feature -- Roundtrip/Token

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- <Precursor>
		do
			if a_list /= Void then
					-- If we have a match list then we need to check for symbols
				if rcurly_symbol_index /= 0 then
						-- Check for '}'
					Result := rcurly_symbol (a_list)
				end
				if Result = Void then
						-- If no '}', then check for ']'
					Result := internal_generics.last_token (a_list)
				end
			end
			if Result = Void then
					-- Default to last token of 'class_name'
				Result := class_name.last_token (a_list)
			end
		end

feature -- Conveniences

	dump: STRING
			-- Dumped string
		do
			Result := Precursor {CLASS_TYPE_AS}
			across
				internal_generics as g
			from
				Result.append (" [")
			loop
				Result.append (g.dump)
				if not @ g.is_last then
					Result.append (", ")
				end
			end
			Result.append ("]")
		end

invariant
	internal_generics_not_void: internal_generics /= Void

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
