indexing
	description: "Abstract description of an Eiffel routine object"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROUTINE_CREATION_AS

inherit
	EXPR_AS

	ID_SET_ACCESSOR
		rename
			make as make_id_set,
			id_set as routine_ids,
			set_id_set as set_routine_ids
		undefine
			copy, is_equal
		end

feature {NONE} -- Initialization

	initialize (t: like target; f: like feature_name; o: like internal_operands; ht: BOOLEAN) is
			-- Create a new ROUTINE_CREATION AST node.
			-- When `t' is Void it means it is a question mark.
		do
			target := t
			feature_name := f
			internal_operands := o
			has_target := ht
		ensure
			target_set: target = t
			feature_name_set: feature_name = f
			internal_operands_set: internal_operands = o
			has_target_set: has_target = ht
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_routine_creation_as (Current)
		end

feature -- Roundtrip

	lparan_symbol_index, rparan_symbol_index: INTEGER
			-- Symbol "(" and ")" associated with Current AST node

	lparan_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS is
			-- Symbol "(" associated with Current AST node
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := lparan_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	rparan_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS is
			-- Symbol ")" associated with Current AST node
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := rparan_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	set_lparan_symbol (s_as: SYMBOL_AS) is
			-- Set `lparan_symbol' with `s_as'.
		do
			if s_as /= Void then
				lparan_symbol_index := s_as.index
			end
		ensure
			lparan_symbol_index_set: s_as /= Void implies lparan_symbol_index = s_as.index
		end

	set_rparan_symbol (s_as: SYMBOL_AS) is
			-- Set `rparan_symbol' with `s_as'.
		do
			if s_as /= Void then
				rparan_symbol_index := s_as.index
			end
		ensure
			rparan_symbol_index_set: s_as /= Void implies rparan_symbol_index = s_as.index
		end

feature -- Attributes

	target: OPERAND_AS
			-- Target operand used when the feature will be called.

	feature_name: ID_AS
			-- Feature name.

	operands : EIFFEL_LIST [OPERAND_AS] is
			-- List of operands used by the feature when called.
		local
			l_internal_operands: like internal_operands
		do
			l_internal_operands := internal_operands
			if l_internal_operands /= Void then
				Result := l_internal_operands.meaningful_content
			end
		ensure
			good_result: (internal_operands = Void implies Result = Void) and
						 (internal_operands /= Void implies Result = internal_operands.meaningful_content)
		end

	has_target: BOOLEAN
			-- Does Current has a target?

	class_id: INTEGER
			-- The class id.

feature -- Roundtrip

	internal_operands : DELAYED_ACTUAL_LIST_AS
			-- Internal list of operands used by the feature when called, in which "(" and ")" are stored

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name) and then
					  equivalent (operands, other.operands) and then
					  equivalent (target, other.target) and then
					  has_target = other.has_target
		end

feature -- Setting

	set_class_id (a_class_id: like class_id) is
			-- Set `class_id' to `a_class_id'.
		require
			a_class_id_ok: a_class_id > 0 or a_class_id = -1
		do
			class_id := a_class_id
		ensure
			class_id_set: class_id = a_class_id
		end

invariant
	operands_correct: (internal_operands /= Void implies operands = internal_operands.meaningful_content) and
					  (internal_operands = Void implies operands = Void)

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

end -- class ROUTINE_CREATION_AS

