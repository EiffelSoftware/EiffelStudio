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

	question_mark_symbol: SYMBOL_AS
			-- Symbol "?" associated with thie structure

	set_question_mark_symbol (s_as: SYMBOL_AS) is
			-- Set `question_mark_symbol' with `s_as'.
		do
			question_mark_symbol := s_as
		ensure
			question_mark_symbol_set: question_mark_symbol = s_as
		end

feature -- Attributes

	class_type: TYPE_AS
			-- Type from which the feature comes if specified

	target : ACCESS_AS
			-- Name of target of delayed call

	expression: EXPR_AS
			-- Object expression given at routine object evaluation

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if class_type /= Void then
				Result := class_type.complete_start_location (a_list)
			elseif question_mark_symbol /= Void and then a_list /= Void then
				Result := question_mark_symbol.complete_start_location (a_list)
			elseif target /= Void then
				Result := target.complete_start_location (a_list)
			elseif expression /= Void then
				Result := expression.complete_start_location (a_list)
			else
				Result := null_location
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if class_type /= Void then
				Result := class_type.complete_end_location (a_list)
			elseif question_mark_symbol /= Void and then a_list /= Void then
				Result := question_mark_symbol.complete_end_location (a_list)
			elseif target /= Void then
				Result := target.complete_end_location (a_list)
			elseif expression /= Void then
				Result := expression.complete_end_location (a_list)
			else
				Result := null_location
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

feature

	is_open : BOOLEAN is
			-- Is it an open operand?
		do
			Result := (expression = Void) and then (target = Void)
		ensure
			Result = (expression = Void) and then (target = Void)
		end

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

end -- class OPERAND_AS

