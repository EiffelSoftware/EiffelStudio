indexing
	description: "Abstract description of an Eiffel operand of a routine object"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OPERAND_AS

inherit
	EXPR_AS
		redefine
			converted_expression
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like class_type; t: like target; e: like expression) is
			-- Create a new OPERAND AST node.
		do
			class_type := c
			target := t
			expression := e
		ensure
			class_type_set: class_type = c
			target_set: target = t
			expression_set: expression = e
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_operand_as (Current)
		end

feature -- Roundtrip

	question_mark_symbol_index: INTEGER
			-- Index of symbol "?" associated with thie structure

	question_mark_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS
			-- Symbol "?" associated with thie structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := question_mark_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	set_question_mark_symbol (s_as: SYMBOL_AS) is
			-- Set `question_mark_symbol' with `s_as'.
		do
			if s_as /= Void then
				question_mark_symbol_index := s_as.index
			end
		ensure
			question_mark_symbol_set: s_as /= Void implies question_mark_symbol_index = s_as.index
		end

feature -- Attributes

	class_type: TYPE_AS
			-- Type from which the feature comes if specified

	target : ACCESS_AS
			-- Name of target of delayed call

	expression: EXPR_AS
			-- Object expression given at routine object evaluation

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if class_type /= Void then
				Result := class_type.first_token (a_list)
			elseif a_list /= Void and question_mark_symbol_index /= 0 then
				Result := question_mark_symbol (a_list)
			elseif target /= Void then
				Result := target.first_token (a_list)
			elseif expression /= Void then
				Result := expression.first_token (a_list)
			else
				Result := Void
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if class_type /= Void then
				Result := class_type.last_token (a_list)
			elseif a_list /= Void and question_mark_symbol_index /= 0 then
				Result := question_mark_symbol (a_list)
			elseif target /= Void then
				Result := target.last_token (a_list)
			elseif expression /= Void then
				Result := expression.last_token (a_list)
			else
				Result := Void
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (class_type, other.class_type) and then
					  equivalent (target, other.target) and then
					  equivalent (expression, other.expression)
		end

feature -- Status report

	is_open : BOOLEAN is
			-- Is it an open operand?
		do
			Result := (expression = Void) and then (target = Void)
		ensure
			Result = ((expression = Void) and then (target = Void))
		end

feature -- Conversion

	converted_expression (a_additional_data: ANY): EXPR_AS is
			-- Convert current expression in another one.
		do
				-- Conversion can only make sense when `expression' is not void,
				-- otherwise what is the point of requesting a conversion.
			if expression /= Void then
				expression := expression.converted_expression (a_additional_data)
			end
			Result := Current
		end

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

end -- class OPERAND_AS

