indexing
	description: "AST representation of a TUPLE type."
	date: "$Date$"
	revision: "$Revision$"

class
	NAMED_TUPLE_TYPE_AS

inherit
	TYPE_AS
		redefine
			has_formal_generic, has_like, is_loose,
			is_equivalent, start_location, end_location,
			first_token, last_token
		end

	CLICKABLE_AST
		redefine
			is_class
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (n: like class_name; p: like parameters) is
			-- Create a new CLASS_TYPE AST node.
		require
			n_not_void: n /= Void
			p_not_void: p /= Void
			p_has_arguments: p.arguments /= Void
		do
			class_name := n
			class_name.to_upper
			parameters := p
		ensure
			class_name_set: class_name.is_equal (n)
			parameters_set: parameters = p
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_named_tuple_type_as (Current)
		end

feature -- Roundtrip

	separate_keyword: KEYWORD_AS
			-- Keyword "separate" associated with this structure.	

feature -- Attributes

	class_name: ID_AS
			-- Class type name

	generics: EIFFEL_LIST [TYPE_DEC_AS] is
			-- Direct access to generic parameters
		do
		   Result := parameters.arguments
		ensure
		   generics_not_void: Result /= Void
		end

	parameters: FORMAL_ARGU_DEC_LIST_AS
			-- Generic parameters

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

	is_separate: BOOLEAN
			-- Is current type used with `separate' keyword?

feature -- Status report

	generic_count: INTEGER is
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


feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := Precursor (a_list)
			if Result = Void then
				if a_list = Void then
					Result := class_name.first_token (a_list)
				else
					if lcurly_symbol /= Void then
						Result := lcurly_symbol.first_token (a_list)
					elseif separate_keyword /= Void then
						Result := separate_keyword.first_token (a_list)
					else
						Result := class_name.first_token (a_list)
					end
				end
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := Precursor (a_list)
			if Result = Void then
				Result := parameters.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (class_name, other.class_name) and then
				equivalent (parameters, other.parameters)
		end

feature -- Access

	has_like: BOOLEAN is
			-- Does the type have anchored type in its definition ?
		local
			l_generics: like generics
		do
			from
				l_generics := generics
				l_generics.start
			until
				l_generics.after or else Result
			loop
				Result := l_generics.item.type.has_like
				l_generics.forth
			end
		end

	has_formal_generic: BOOLEAN is
			-- Has type a formal generic parameter?
		local
			l_generics: like generics
		do
			from
				l_generics := generics
				l_generics.start
			until
				l_generics.after or else Result
			loop
				Result := l_generics.item.type.has_formal_generic
				l_generics.forth
			end
		end

	is_loose: BOOLEAN is
			-- Does type depend on formal generic parameters and/or anchors?
		local
			l_generics: like generics
		do
			from
				l_generics := generics
				l_generics.start
			until
				l_generics.after or else Result
			loop
				Result := l_generics.item.type.is_loose
				l_generics.forth
			end
		end

feature {AST_FACTORY, COMPILER_EXPORTER} -- Conveniences

	set_is_separate (i: like is_separate; s_as: like separate_keyword) is
			-- Set `is_separate' to `i'.
		do
			is_separate := i
			separate_keyword := s_as
		ensure
			is_separate_set: is_separate = i
			separate_keyword_set: separate_keyword = s_as
		end

	set_class_name (s: like class_name) is
			-- Assign `s' to `class_name'.
		do
			class_name := s
		end

	dump: STRING is
			-- Dumped string
		local
			i, nb: INTEGER
			l_generics: like generics
		do
			create Result.make (class_name.count)
			Result.append (class_name)
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
					Result.append (l_generics.item.item_name (i))
					if i <= nb then
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
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
