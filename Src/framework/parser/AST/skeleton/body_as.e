indexing
	description	: "Abstract description of the body of an Eiffel feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class BODY_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (a: like internal_arguments; t: like type; r: like assigner c: like content; c_as: SYMBOL_AS; k_as: LEAF_AS; a_as: KEYWORD_AS; i_as: like indexing_clause) is
			-- Create a new BODY AST node.
		do
			set_arguments (a)
			type := t
			assigner := r
			content := c
			colon_symbol := c_as
			is_keyword := k_as
			assign_keyword := a_as
			indexing_clause := i_as
		ensure
			internal_arguments_set: internal_arguments = a
			type_set: type = t
			assigner_set: assigner = r
			content_set: content = c
			colon_symbol_set: colon_symbol = c_as
			is_keyword_set: is_keyword = k_as
			assign_keyword_set: assign_keyword = a_as
			indexing_clause_set: indexing_clause = i_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_body_as (Current)
		end

feature -- Roundtrip

	colon_symbol: SYMBOL_AS
			-- Symbol colon associated with this structure

	is_keyword: LEAF_AS
			-- Keyword "is" or equal sign associated with this structure

	assign_keyword: KEYWORD_AS
			-- Keyword "assign" associated with this structure

feature -- Attributes

	arguments: EIFFEL_LIST [TYPE_DEC_AS] is
			-- List (of list) of arguments
		local
			l_internal_arguments: like internal_arguments
		do
			l_internal_arguments := internal_arguments
			if l_internal_arguments /= Void then
				Result := l_internal_arguments.meaningful_content
			end
		ensure
			good_result: (internal_arguments = Void implies Result = Void) and
						 (internal_arguments /= Void implies Result = internal_arguments.meaningful_content)
		end

	type: TYPE_AS
			-- Type if any

	assigner: ID_AS
			-- Assigner mark if any

	content: CONTENT_AS
			-- Content of the body: constant or regular body

feature -- Roundtrip

	internal_arguments: FORMAL_ARGU_DEC_LIST_AS
			-- Internal list (of list) of arguments, in which "(" and ")" are stored

	indexing_clause: INDEXING_CLAUSE_AS
			-- Indexing clause in this structure

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				if arguments /= Void then
					Result := arguments.first_token (a_list)
				elseif type /= Void then
					Result := type.first_token (a_list)
				elseif assigner /= Void then
					Result := assigner.first_token (a_list)
				elseif content /= Void then
					Result := content.first_token (a_list)
				end
			else
				if internal_arguments /= Void then
					Result := internal_arguments.first_token (a_list)
				elseif colon_symbol /= Void then
					Result := colon_symbol.first_token (a_list)
				elseif assign_keyword /= Void then
					Result := assign_keyword.first_token (a_list)
				elseif is_keyword /= Void then
					Result := is_keyword.first_token (a_list)
				elseif indexing_clause /= Void then
					Result := indexing_clause.first_token (a_list)
				elseif content /= VOid then
					Result := content.first_token (a_list)
				else
					check False end
				end
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				if content /= Void then
					Result := content.last_token (a_list)
				elseif type /= Void then
					Result := type.last_token (a_list)
				elseif arguments /= Void then
					Result := arguments.last_token (a_list)
				else
					Result := Void
				end
			else
				if is_routine then
					Result := content.last_token (a_list)
				elseif is_constant then
					if indexing_clause /= Void then
						Result := indexing_clause.last_token (a_list)
					else
						Result := content.last_token (a_list)
					end
				else
						-- Attribute case
					if indexing_clause /= Void then
						Result := indexing_clause.last_token (a_list)
					elseif assigner /= Void then
						Result := assigner.last_token (a_list)
					else
						Result := type.last_token (a_list)
					end
				end
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (arguments, other.arguments) and
				equivalent (content, other.content) and
				equivalent (type, other.type)
		end

feature -- Access

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does this body has instruction `i'?
		do
			if content /= Void then
				Result := content.has_instruction (i)
			else
				Result := False
			end
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this body.
			-- Result is `0' not found.
		do
			if content /= Void then
				Result := content.index_of_instruction (i)
			else
				Result := 0
			end
		end

feature -- empty body

	is_empty : BOOLEAN is
				-- Is body empty?
		do
			Result := (content = Void) or else (content.is_empty)
		end

feature -- default rescue

	create_default_rescue (def_resc_name_id: INTEGER) is
				-- Create default rescue if necessary
		require
			valid_feature_name_id: def_resc_name_id > 0
		do
			if content /= Void then
				content.create_default_rescue (def_resc_name_id)
			end
		end

feature -- Type check, byte code and dead code removal

	is_unique: BOOLEAN is
		do
			Result := content /= Void and then content.is_unique
		end

	is_built_in: BOOLEAN is
			-- Is current body a built in?
		do
			Result := content /= Void and then content.is_built_in
		end

	is_routine: BOOLEAN is
			-- Is current body a routine?
		do
				-- If not a constant then current body is a routine.
			Result := content /= Void and then not content.is_constant
		end

	is_constant: BOOLEAN is
			-- Is current body a constant?
		do
			Result := content /= Void and then content.is_constant
		end

feature -- New feature description

	is_body_equiv (other: like Current): BOOLEAN is
			-- Is the body of current feature equivalent to
			-- body of `other' ?
		do
			Result := equivalent (type, other.type) and then
					equivalent (arguments, other.arguments)
			if Result then
				if (content = Void) and (other.content = Void) then
				elseif (content = Void) or else (other.content = Void) then
					Result := False
				elseif (content.is_constant = other.content.is_constant) then
						-- The two objects are of the same type.
						-- There is no global typing problem.
					Result := content.is_body_equiv (other.content)
				else
					Result := False
				end
			end
		end

	is_assertion_equiv (other: like Current): BOOLEAN is
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
		local
			r1, r2: ROUTINE_AS
		do
			r1 ?= content;
			r2 ?= other.content
			if (r1 /= Void) and then (r2 /= Void) then
				Result := r1.is_assertion_equiv (r2)
			else
				Result := True
			end
		end

feature {BODY_AS, FEATURE_AS} -- Replication

	set_arguments (a: like internal_arguments) is
			-- Set `internal_arguments' with `a'.
		do
			internal_arguments := a
		ensure
			internal_arguments_set: internal_arguments = a
		end

	set_type (t: like type) is
		do
			type := t
		end

	set_content (c: like content) is
		do
			content := c
		end

invariant
	arguments_correct: (internal_arguments /= Void implies arguments = internal_arguments.meaningful_content) and
	   				   (internal_arguments = Void implies arguments = Void)

indexing
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

end -- class BODY_AS
