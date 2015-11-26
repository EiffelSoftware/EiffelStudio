note
	description: "Abstract description of an Eiffel routine object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROUTINE_CREATION_AS

inherit
	EXPR_AS
	ID_SET_ACCESSOR

feature {NONE} -- Initialization

	initialize (t: like target; f: like feature_name; o: like internal_operands; ht: BOOLEAN)
			-- Create a new ROUTINE_CREATION AST node.
			-- When `t' is Void it means it is a question mark.
		do
			make_id_set
			target := t
			feature_name := f
			internal_operands := o
			has_target := ht
		ensure
			target_set: target = t
			feature_name_set: feature_name = f
			internal_operands_set: internal_operands = o
			has_target_set: has_target = ht
			no_routine_id: routine_ids.is_empty
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_routine_creation_as (Current)
		end

feature -- Roundtrip

	lparan_symbol_index, rparan_symbol_index: INTEGER
			-- Symbol "(" and ")" associated with Current AST node

	lparan_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "(" associated with Current AST node
		require
			a_list_not_void: a_list /= Void
		do
		end

	rparan_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol ")" associated with Current AST node
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, rparan_symbol_index)
		end

	set_lparan_symbol (s_as: like lparan_symbol)
			-- Set `lparan_symbol' with `s_as'.
		do
			if s_as /= Void then
				lparan_symbol_index := s_as.index
			end
		ensure
			lparan_symbol_index_set: s_as /= Void implies lparan_symbol_index = s_as.index
		end

	set_rparan_symbol (s_as: like rparan_symbol)
			-- Set `rparan_symbol' with `s_as'.
		do
			if s_as /= Void then
				rparan_symbol_index := s_as.index
			end
		ensure
			rparan_symbol_index_set: s_as /= Void implies rparan_symbol_index = s_as.index
		end

feature -- Attributes

	target: detachable OPERAND_AS
			-- Target operand used when the feature will be called.

	feature_name: detachable ID_AS
			-- Feature name.

	operands : detachable EIFFEL_LIST [OPERAND_AS]
			-- List of operands used by the feature when called.
		do
			if attached internal_operands as l_internal_operands then
				Result := l_internal_operands.operands
			end
		ensure
			good_result: (internal_operands = Void implies Result = Void) and
						 (attached internal_operands as l_operands implies Result = l_operands.operands)
		end

	has_target: BOOLEAN
			-- Does Current has a target?

feature -- Roundtrip

	internal_operands : detachable DELAYED_ACTUAL_LIST_AS
			-- Internal list of operands used by the feature when called, in which "(" and ")" are stored

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name) and then
					  equivalent (operands, other.operands) and then
					  equivalent (target, other.target) and then
					  has_target = other.has_target
		end

invariant
	operands_correct: (attached internal_operands as l_operands implies operands = l_operands.operands) and
					  (internal_operands = Void implies operands = Void)

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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

end -- class ROUTINE_CREATION_AS

