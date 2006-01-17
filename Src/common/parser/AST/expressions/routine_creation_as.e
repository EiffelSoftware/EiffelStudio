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

feature {NONE} -- Initialization

	initialize (t: like target; f: like feature_name; o: like operands; ht: BOOLEAN) is
			-- Create a new ROUTINE_CREATION AST node.
			-- When `t' is Void it means it is a question mark.
		require
			f_not_void: f /= Void
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

	lparan_symbol, rparan_symbol: SYMBOL_AS
			-- Symbol "(" and ")" associated with this structure

	set_lparan_symbol (s_as: SYMBOL_AS) is
			-- Set `lparan_symbol' with `s_as'.
		do
			lparan_symbol := s_as
		ensure
			lparan_symbol_set: lparan_symbol = s_as
		end

	set_rparan_symbol (s_as: SYMBOL_AS) is
			-- Set `rparan_symbol' with `s_as'.
		do
			rparan_symbol := s_as
		ensure
			rparan_symbol_set: rparan_symbol = s_as
		end

feature -- Attributes

	target: OPERAND_AS
			-- Target operand used when the feature will be called.

	feature_name: ID_AS
			-- Feature name.

	operands : EIFFEL_LIST [OPERAND_AS] is
			-- List of operands used by the feature when called.
		do
			if internal_operands = Void or else internal_operands.is_empty then
				Result := Void
			else
				Result := internal_operands
			end
		end

	has_target: BOOLEAN
			-- Does Current has a target?

feature -- Roundtrip

	internal_operands : EIFFEL_LIST [OPERAND_AS]
			-- Internal list of operands used by the feature when called.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name) and then
					  equivalent (operands, other.operands) and then
					  equivalent (target, other.target) and then
					  has_target = other.has_target
		end

invariant
	feature_name_not_void: feature_name /= Void

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

end -- class ROUTINE_CREATION_AS


