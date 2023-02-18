note
	description: "AST representation of a TUPLE type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NAMED_TUPLE_TYPE_AS

inherit
	TYPE_AS
		redefine
			first_token,
			has_anchor,
			is_fixed,
			last_token
		end

	CLICKABLE_AST
		redefine
			is_class, class_name
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (n: like class_name; p: like parameters)
			-- Create a new CLASS_TYPE AST node.
		require
			n_not_void: n /= Void
			n_upper: n.name.is_equal (n.name.as_upper)
			p_not_void: p /= Void
			p_has_arguments: p.arguments /= Void
		do
			class_name := n
			parameters := p
		ensure
			class_name_set: class_name.is_equal (n)
			parameters_set: parameters = p
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_named_tuple_type_as (Current)
		end

feature -- Status

	has_anchor: BOOLEAN
			-- <Precursor>
		do
			Result := generics.there_exists (
				agent (t: TYPE_DEC_AS): BOOLEAN
					do
						Result := t.type.has_anchor
					end
			)
		end

	is_fixed: BOOLEAN
			-- <Precursor>
		do
			Result :=
				across
					generics as g
				all
					g.type.is_fixed
				end
		end

feature -- Attributes

	class_name: ID_AS
			-- Class type name.

	generics: EIFFEL_LIST [TYPE_DEC_AS]
			-- Direct access to generic parameters.
		do
				-- Per invariant
			Result := parameters.arguments
		ensure
		   generics_not_void: Result /= Void
		end

	parameters: FORMAL_ARGU_DEC_LIST_AS
			-- Generic parameters.

	is_class: BOOLEAN = True
			-- Does the Current AST represent a class?
feature -- Roundtrip

	index: INTEGER
			-- <Precursor>
		do
			Result := class_name.index
		end

feature -- Status report

	generic_count: INTEGER
			-- Number of actual generic parameters.
		local
			l_generics: like generics
			l_index: INTEGER
		do
			from
				l_generics := generics
				l_index := l_generics.index
				l_generics.start
			until
				l_generics.after
			loop
				Result := Result + l_generics.item.id_list.count
				l_generics.forth
			end
			l_generics.go_i_th (l_index)
		ensure
			generic_count_positive: generic_count > 0
		end

	i_th_type_declaration (i: INTEGER): detachable TYPE_DEC_AS
			-- Extract the type declaration for the `i-th' identifier of Current.
		require
			valid_index: i >= 1 and i <= generic_count
		local
			l_generics: like generics
			l_index: INTEGER
			j, k: INTEGER
		do
			from
				l_generics := generics
				l_index := l_generics.index
				l_generics.start
				j := 1
			until
				l_generics.after
			loop
				k := l_generics.item.id_list.count
				if j <= i and i < j + k then
					Result := l_generics.item
				else
					j := j + k
				end
				l_generics.forth
			end
			l_generics.go_i_th (l_index)
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := Precursor (a_list)
			if Result = Void then
				Result := class_name.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := Precursor (a_list)
			if Result = Void then
				Result := parameters.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result := equivalent (class_name, other.class_name) and then
				equivalent (parameters, other.parameters) and then
				has_same_marks (other)
		end

feature {AST_FACTORY, COMPILER_EXPORTER} -- Conveniences

	set_class_name (s: like class_name)
			-- Assign `s' to `class_name'.
		do
			class_name := s
		end

	dump: STRING
			-- Dumped string.
		local
			i, nb: INTEGER
			l_generics: like generics
		do
			create Result.make (class_name.name.count + 4)
			dump_marks (Result)
			Result.append (class_name.name)
			from
				l_generics := generics
				l_generics.start;
				Result.append (" [")
			until
				l_generics.after
			loop
				from
					i := 1
					nb := l_generics.item.id_list.count
				until
					i > nb
				loop
					Result.append_string (l_generics.item.item_name (i))
					if i < nb then
						Result.append_character (',')
						Result.append_character (' ')
					end
					i := i + 1
				end
				Result.append (": ")
				Result.append (l_generics.item.type.dump)
				if not l_generics.islast then
					Result.append ("; ")
				end
				l_generics.forth
			end
			Result.append ("]")
		end

invariant
	parameters_not_void: parameters /= Void and then parameters.arguments /= Void and then
		not parameters.arguments.is_empty

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
