indexing
	description:
		"Abstract description of an access to the precursor of%
		%an Eiffel feature. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PRECURSOR_AS

inherit
	ACCESS_AS
		redefine
			is_equivalent
		end

	CLICKABLE_AST
		redefine
			is_precursor
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (pk: like precursor_keyword; n: like parent_base_class; p: like internal_parameters) is
			-- Create a new PRECURSOR AST node.
		require
			pk_not_void: pk /= Void
			valid_n: n /= Void implies n.generics = Void
		do
			precursor_keyword := pk
			parent_base_class := n
			internal_parameters := p
			if parameters /= Void then
				parameters.start
			end
		ensure
			precursor_keyword_set: precursor_keyword = pk
			parent_base_class_set: parent_base_class = n
			internal_parameters_set: internal_parameters = p
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_precursor_as (Current)
		end

feature -- Attributes

	precursor_keyword: KEYWORD_AS
			-- Position of Precursor keyword

	parent_base_class: CLASS_TYPE_AS
			-- Optional name of the parent

	parameters: EIFFEL_LIST [EXPR_AS] is
			-- List of parameters
		do
			if
				internal_parameters = Void or else
				internal_parameters.parameters = Void or else
				internal_parameters.parameters.is_empty
			then
				Result := Void
			else
				Result := internal_parameters.parameters
			end
		end

	parameter_count: INTEGER is
			-- Number of parameters
		do
			if parameters /= Void then
				Result := parameters.count
			end
		end

	access_name: STRING is
		do
			-- Void because a Precursor call is like a client call but without
			-- a client, so there is no variable which is accessing the feature.
		end

	is_precursor: BOOLEAN is True
			-- Precursor makes reference to a class

feature -- Roundtrip

	internal_parameters: PARAMETER_LIST_AS
			-- Internal list of parameters			

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := precursor_keyword.first_token (a_list)
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				if parameters /= Void then
					Result := parameters.last_token (a_list)
				elseif parent_base_class /= Void then
					Result := parent_base_class.first_token (a_list)
				else
					Result := precursor_keyword.last_token (a_list)
				end
			else
				if internal_parameters /= Void then
					Result := internal_parameters.last_token (a_list)
				elseif parent_base_class /= Void then
					Result := parent_base_class.last_token (a_list)
				else
					Result := precursor_keyword.last_token (a_list)
				end
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (parent_base_class, other.parent_base_class) and
				equivalent (parameters, other.parameters)
		end

invariant
	precursor_keyword_not_void: precursor_keyword /= Void
	valid_parent_base_class: parent_base_class /= Void implies parent_base_class.generics = Void

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

end -- class PRECURSOR_AS
