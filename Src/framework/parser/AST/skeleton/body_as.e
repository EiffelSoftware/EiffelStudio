note
	description: "Abstract description of the body of an Eiffel feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class BODY_AS

inherit
	AST_EIFFEL

create
	initialize

feature {NONE} -- Initialization

	initialize (a: like internal_arguments; t: like type; r: like assigner c: like content; c_as: detachable SYMBOL_AS; k_as: detachable LEAF_AS; a_as: detachable KEYWORD_AS; i_as: like indexing_clause)
			-- Create a new BODY AST node.
		do
			set_arguments (a)
			type := t
			assigner := r
			content := c
			if c_as /= Void then
				colon_symbol_index := c_as.index
			end
			if k_as /= Void then
				is_keyword_index := k_as.index
			end
			if a_as /= Void then
				assign_keyword_index := a_as.index
			end
			indexing_clause := i_as
		ensure
			internal_arguments_set: internal_arguments = a
			type_set: type = t
			assigner_set: assigner = r
			content_set: content = c
			colon_symbol_set: c_as /= Void implies colon_symbol_index = c_as.index
			is_keyword_set: k_as /= Void implies is_keyword_index = k_as.index
			assign_keyword_set: a_as /= Void implies assign_keyword_index = a_as.index
			indexing_clause_set: indexing_clause = i_as
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_body_as (Current)
		end

feature -- Roundtrip

	colon_symbol_index: INTEGER
			-- Index of symbol colon associated with this structure.

	is_keyword_index: INTEGER
			-- Index of keyword "is" or equal sign associated with this structure.

	assign_keyword_index: INTEGER
			-- Index of keyword "assign" associated with this structure.

	colon_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol colon associated with this structure.
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, colon_symbol_index)
		end

	is_keyword (a_list: LEAF_AS_LIST): detachable LEAF_AS
			-- Keyword "is" or equal sign associated with this structure.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := is_keyword_index
			if a_list.valid_index (i) then
				Result := a_list.i_th (i)
			end
		end

	assign_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "assign" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, assign_keyword_index)
		end

	internal_arguments: detachable FORMAL_ARGU_DEC_LIST_AS
			-- Internal list (of list) of arguments, in which "(" and ")" are stored.

	indexing_clause: detachable INDEXING_CLAUSE_AS
			-- Indexing clause in this structure.

	index: INTEGER
			-- <Precursor>
		do
			if attached content as l_content then
				Result := l_content.index
			end
		end

feature -- Attributes

	arguments: detachable EIFFEL_LIST [TYPE_DEC_AS]
			-- List (of list) of arguments.
		do
			if attached internal_arguments as l_internal_arguments then
				Result := l_internal_arguments.arguments
			end
		ensure
			good_result: (internal_arguments = Void implies Result = Void) and
						 (attached internal_arguments as l_args implies Result = l_args.arguments)
		end

	type: detachable TYPE_AS
			-- Type if any.

	assigner: detachable ID_AS
			-- Assigner mark if any.

	content: detachable CONTENT_AS
			-- Content of the body: constant or regular body.

	as_routine: detachable ROUTINE_AS
			-- See `content' as an instance of ROUTINE_AS.
		do
			if attached {ROUTINE_AS} content as l_routine then
				Result := l_routine
			end
		end

	as_constant: detachable CONSTANT_AS
			-- See `content' as an instance of CONSTANT_AS.
		do
			if attached {CONSTANT_AS} content as l_constant then
				Result := l_constant
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached internal_arguments as l_args then
				Result := l_args.first_token (a_list)
			elseif colon_symbol_index /= 0 and a_list /= Void then
				Result := colon_symbol (a_list)
			elseif attached type as l_type then
				Result := l_type.first_token (a_list)
			elseif assign_keyword_index /= 0 and a_list /= Void then
				Result := assign_keyword (a_list)
			elseif attached assigner as l_assigner then
				Result := l_assigner.first_token (a_list)
			elseif is_keyword_index /= 0 and a_list /= Void then
				Result := is_keyword (a_list)
			elseif attached indexing_clause as l_indexing_clause then
				Result := l_indexing_clause.first_token (a_list)
			elseif attached content as l_content then
				Result := l_content.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				if attached content as l_content then
					Result := l_content.last_token (a_list)
				elseif attached type as l_type then
					Result := l_type.last_token (a_list)
				elseif attached arguments as l_args then
					Result := l_args.last_token (a_list)
				else
					Result := Void
				end
			else
				if attached content as l_content then
					if l_content.is_constant then
						if attached indexing_clause as l_indexing_clause then
							Result := l_indexing_clause.last_token (a_list)
						else
							Result := l_content.last_token (a_list)
						end
					else
						Result := l_content.last_token (a_list)
					end
				else
						-- Attribute case
					if attached indexing_clause as l_indexing_clause then
						Result := l_indexing_clause.last_token (a_list)
					elseif attached assigner as l_assigner then
						Result := l_assigner.last_token (a_list)
					elseif attached type as l_type then
						Result := l_type.last_token (a_list)
					end
				end
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result := equivalent (arguments, other.arguments) and
				equivalent (content, other.content) and
				equivalent (type, other.type)
		end

feature -- Access

	has_instruction (i: INSTRUCTION_AS): BOOLEAN
			-- Does this body has instruction `i'?
		do
			if attached content as l_content then
				Result := l_content.has_instruction (i)
			else
				Result := False
			end
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER
			-- Index of `i' in this body.
			-- Result is `0' not found.
		do
			if attached content as l_content then
				Result := l_content.index_of_instruction (i)
			else
				Result := 0
			end
		end

	argument_index (n: INTEGER): INTEGER
			-- AST index of an argument number `n`if found, `0` otherwise.
		require
			valid_argument_number: n > 0
		local
			id_list: IDENTIFIER_LIST
			distance: INTEGER
		do
			if attached arguments as a then
				distance := n
				across
					a as type_declaration
				until
					distance <= 0
				loop
					id_list := type_declaration.id_list
					if distance > id_list.count then
							-- There are more declaration lists to go, skip this one.
						distance := distance - id_list.count
					else
							-- The argument should be in this declaration list.
						if attached id_list.id_list as argument_indexes then
							Result := argument_indexes [distance]
						end
							-- Exit the loop.
						distance := 0
					end
				end
			end
		end

feature -- Status report

	is_empty : BOOLEAN
				-- Is body empty?
		do
			Result := (not attached content as l_content) or else l_content.is_empty
		end

feature -- default rescue

	create_default_rescue (def_resc_name_id: INTEGER)
				-- Create default rescue if necessary.
		require
			valid_feature_name_id: def_resc_name_id > 0
		do
			if attached content as l_content then
				l_content.create_default_rescue (def_resc_name_id)
			end
		end

feature -- Type check, byte code and dead code removal

	is_unique: BOOLEAN
		do
			Result := attached content as l_content and then l_content.is_unique
		end

	is_built_in: BOOLEAN
			-- Is current body a built in?
		do
			Result := attached content as l_content and then l_content.is_built_in
		end

	is_routine: BOOLEAN
			-- Is current body a routine?
		do
				-- If not a constant then current body is a routine.
			Result := attached content as l_content and then not l_content.is_constant
		end

	is_constant: BOOLEAN
			-- Is current body a constant?
		do
			Result := attached content as l_content and then l_content.is_constant
		end

feature -- New feature description

	is_body_equiv (other: like Current): BOOLEAN
			-- Is the body of current feature equivalent to
			-- body of `other' ?
		do
			Result := equivalent (type, other.type) and then
					equivalent (arguments, other.arguments)
			if Result then
				if attached content as l_content and attached other.content as l_other_content then
					if l_content.is_constant = l_other_content.is_constant then
							-- The two objects are of the same type.
							-- There is no global typing problem.
						Result := l_content.is_body_equiv (l_other_content)
					else
						Result := False
					end
				else
					Result := content = other.content
				end
			end
		end

	is_assertion_equiv (other: like Current): BOOLEAN
			-- Is the assertion of Current feature equivalent to
			-- assertion of `other' ?
			--|Note: This test is valid since assertions are generated
			--|along with the body code. The assertions will be re-generated
			--|whenever the body has changed. Therefore it is not necessary to
			--|consider the cases in which one of the contents is a ROUTINE_AS
			--|and the other a CONSTANT_AS (The True value is actually returned
			--|but we don't care.
			--|Non-constant attributes have a Void content. In any case
			--|involving at least on attribute, the True value is retuned:
			--|   . If they are both attributes, the assertions are equivalent
			--|   . If only on is an attribute, we don't care since the bodies will
			--|	 not be equivalent anyway.
			--|The best way to understand all this, is to draw a two-dimensional
			--|table, for all possible combinations of the values (CONSTANT_AS,
			--|ROUTINE_AS, Void) of content and other.content)
		do
			if attached {ROUTINE_AS} content as r1 and attached {ROUTINE_AS} other.content as r2 then
				Result := r1.is_assertion_equiv (r2)
			else
				Result := True
			end
		end

feature {BODY_AS, FEATURE_AS} -- Replication

	set_arguments (a: like internal_arguments)
			-- Set `internal_arguments' with `a'.
		do
			internal_arguments := a
		ensure
			internal_arguments_set: internal_arguments = a
		end

	set_type (t: like type)
		do
			type := t
		end

	set_content (c: like content)
		do
			content := c
		end

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
