note
	description: "Abstract description of an access to the precursor of an Eiffel feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PRECURSOR_AS

inherit
	ACCESS_AS

	CLICKABLE_AST
		redefine
			is_precursor
		end

	ID_SET_ACCESSOR

create
	initialize

feature {NONE} -- Initialization

	initialize (pk: like precursor_keyword; n: like parent_base_class; p: like internal_parameters)
			-- Create a new PRECURSOR AST node.
		require
			pk_not_void: pk /= Void
			valid_n: n /= Void implies n.generics = Void
		do
			make_id_set
			precursor_keyword := pk
			parent_base_class := n
			internal_parameters := p
		ensure
			precursor_keyword_set: precursor_keyword = pk
			parent_base_class_set: parent_base_class = n
			internal_parameters_set: internal_parameters = p
			no_routine_id: routine_ids.is_empty
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_precursor_as (Current)
		end

feature -- Attributes

	precursor_keyword: KEYWORD_AS
			-- Position of Precursor keyword.

	parent_base_class: detachable CLASS_TYPE_AS
			-- Optional name of the parent.

	parameters: detachable EIFFEL_LIST [EXPR_AS]
			-- List of parameters.
		do
			if attached internal_parameters as l_internal_paran then
				Result := l_internal_paran.parameters
				Result.start
			end
		ensure then
			good_result: (internal_parameters = Void implies Result = Void) and
						 (attached internal_parameters as l_params implies Result = l_params.parameters)
		end

	parameter_count: INTEGER
			-- Number of parameters.
		do
			if attached parameters as l_params then
				Result := l_params.count
			end
		end

	is_precursor: BOOLEAN = True
			-- Precursor makes reference to a class.

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Attributes

	access_name: detachable STRING
		do
			-- Void because a Precursor call is like a client call but without
			-- a client, so there is no variable which is accessing the feature.
		end

feature -- Roundtrip

	internal_parameters: detachable PARAMETER_LIST_AS
			-- Internal list of parameters.

	index: INTEGER
			-- <Precursor>
		do
			if attached internal_parameters as p then
				Result := p.index
			elseif attached precursor_keyword as k then
				Result := k.index
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := precursor_keyword.first_token (a_list)
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				if attached parameters as l_params then
					Result := l_params.last_token (a_list)
				elseif attached parent_base_class as l_base_class then
					Result := l_base_class.first_token (a_list)
				else
					Result := precursor_keyword.last_token (a_list)
				end
			else
				if attached internal_parameters as l_params then
					Result := l_params.last_token (a_list)
				elseif attached parent_base_class as l_base_class then
					Result := l_base_class.last_token (a_list)
				else
					Result := precursor_keyword.last_token (a_list)
				end
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result := equivalent (parent_base_class, other.parent_base_class) and
				equivalent (parameters, other.parameters)
		end

invariant
	precursor_keyword_not_void: precursor_keyword /= Void
	valid_parent_base_class: attached parent_base_class as l_class implies l_class.generics = Void
	parameters_set: (attached internal_parameters as l_params implies parameters = l_params.parameters) and
					(internal_parameters = Void implies parameters = Void)
	parameter_count_correct: (parameters = Void implies parameter_count = 0) and (parameters /= Void implies parameter_count > 0)

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
