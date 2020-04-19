note
	description: "Abstract description of an Eiffel operand of a routine object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	initialize (c: like class_type; e: like expression)
			-- Create a new OPERAND AST node.
		do
			class_type := c
			expression := e
		ensure
			class_type_set: class_type = c
			expression_set: expression = e
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_operand_as (Current)
		end

feature -- Roundtrip

	question_mark_symbol_index: INTEGER
			-- Index of symbol "?" associated with thie structure

	question_mark_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "?" associated with thie structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, question_mark_symbol_index)
		end

	set_question_mark_symbol (s_as: detachable SYMBOL_AS)
			-- Set `question_mark_symbol' with `s_as'.
		do
			if s_as /= Void then
				question_mark_symbol_index := s_as.index
			end
		ensure
			question_mark_symbol_set: s_as /= Void implies question_mark_symbol_index = s_as.index
		end

	index: INTEGER
			-- <Precursor>
		do
			if attached expression as e then
				Result := e.index
			else
				Result := question_mark_symbol_index
			end
		end

feature -- Attributes

	class_type: detachable TYPE_AS
			-- Type from which the feature comes if specified

	expression: detachable EXPR_AS
			-- Object expression given at routine object evaluation

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached class_type as l_class_type then
				Result := l_class_type.first_token (a_list)
			elseif a_list /= Void and question_mark_symbol_index /= 0 then
				Result := question_mark_symbol (a_list)
			elseif attached expression as l_expr then
				Result := l_expr.first_token (a_list)
			else
				Result := Void
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached class_type as l_class_type then
				Result := l_class_type.last_token (a_list)
			elseif a_list /= Void and question_mark_symbol_index /= 0 then
				Result := question_mark_symbol (a_list)
			elseif attached expression as l_expr then
				Result := l_expr.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (class_type, other.class_type) and then
					  equivalent (expression, other.expression)
		end

feature -- Status report

	is_open : BOOLEAN
			-- Is it an open operand?
		do
			Result := not attached expression
		ensure
			Result = not attached expression
		end

feature -- Conversion

	converted_expression (a_additional_data: ANY): EXPR_AS
			-- Convert current expression in another one.
		do
				-- Conversion can only make sense when `expression' is not void,
				-- otherwise what is the point of requesting a conversion.
			if attached expression as l_expr then
				expression := l_expr.converted_expression (a_additional_data)
			end
			Result := Current
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
