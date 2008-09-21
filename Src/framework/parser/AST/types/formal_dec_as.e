indexing
	description: "Abstract description of a formal generic parameter."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_DEC_AS

inherit
	AST_EIFFEL

create
	initialize

feature {NONE} -- Initialization

	initialize (f: FORMAL_AS; c: like constraints; cf: like creation_feature_list; c_as: like constrain_symbol; ck_as: like create_keyword; ek_as: like end_keyword; q: BOOLEAN; q_as: like is_self_initializing_symbol) is
			-- Create a new FORMAL_DECLARATION AST node.
		require
			f_not_void: f /= Void
		do
			if c = Void then
				create constraints.make (0)
			else
				constraints := c
			end
			creation_feature_list := cf
			formal := f
			if c_as /= Void then
				constrain_symbol_index := c_as.index
			end
			if ck_as /= Void then
				create_keyword_index := ck_as.index
			end
			if ek_as /= Void then
				end_keyword_index := ek_as.index
			end
			is_self_initializing := q
			if q_as /= Void then
				is_self_initializing_symbol_index := q_as.index
			end
		ensure
			constraints_set: c /= Void implies constraints = c
			constraints_not_void: constraints /= Void
			creation_feature_list_set: creation_feature_list = cf
			formal_set: formal = f
			constrain_symbol_set: c_as /= Void implies constrain_symbol_index = c_as.index
			create_keyword_set: ck_as /= Void implies create_keyword_index = ck_as.index
			end_keyword_set: ek_as /= Void implies end_keyword_index = ek_as.index
			is_self_initializing_set: is_self_initializing = q
			is_self_initializing_symbol_set: q_as /= Void implies is_self_initializing_symbol_index = q_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_formal_dec_as (Current)
		end

feature -- Roundtrip

	formal: FORMAL_AS
			-- Formal generic parameter associated with this structure		

	is_self_initializing_symbol_index: INTEGER
			-- Self-initializing mark index (if any)

	constrain_symbol_index: INTEGER
			-- Symbol "->" associated with this structure

	create_keyword_index: INTEGER
			-- Keyword "create" associated with this structure

	end_keyword_index: INTEGER
			-- Keyword "end" associated with this structure

	is_self_initializing_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS
			-- Self-initializing mark (if any)
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := is_self_initializing_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	constrain_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS is
			-- Symbol "->" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := constrain_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	create_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "create" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := create_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	end_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "end" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := end_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Convenience

	name: ID_AS is
			--
		do
			Result := formal.name
		end

	is_self_initializing: BOOLEAN
			-- If formal generic self_initializing?

	is_reference: BOOLEAN
		do
			Result := formal.is_reference
		end

	is_expanded: BOOLEAN
		do
			Result := formal.is_expanded
		end

	position: INTEGER is
			--
		do
			Result := formal.position
		end


feature -- Attributes

	constraint: CONSTRAINING_TYPE_AS is
			-- Constraint of the formal generic
			-- Only valid to call if there's exactly one constraint.
		require
			not_multi_constraint: constraints.count  <= 1
		do
			if not constraints.is_empty then
				Result := constraints.last
			end
		ensure
			has_constraints_implies_result_not_void: not constraints.is_empty implies Result /= Void
		end

	constraints: CONSTRAINT_LIST_AS
			-- Constraints of the formal generic

	creation_feature_list: EIFFEL_LIST [FEATURE_NAME]
			-- Constraint on the creation routines of the constraint

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and is_self_initializing_symbol_index /= 0 then
				Result := is_self_initializing_symbol (a_list)
			else
				Result := formal.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and end_keyword_index /= 0 then
				Result := end_keyword (a_list)
			elseif constraints /= Void then
				Result := constraints.last_token (a_list)
			else
				Result := formal.last_token (a_list)
			end
		end

feature -- Status

	has_constraint: BOOLEAN is
			-- Does the formal generic parameter have a constraint?
		do
			Result := constraints /= Void and then not constraints.is_empty
		end

	has_multi_constraints: BOOLEAN is
			-- Does the formal generic parameter have multiple constraints in it's own constraint list?
		do
			Result := constraints /= Void and then constraints.count > 1
		ensure
			not_more_than_one_constraint: not Result implies (constraints /= Void implies constraints.count <= 1)
		end

	is_single_constraint_without_renaming (a_generics: EIFFEL_LIST [FORMAL_DEC_AS]): BOOLEAN
			-- Is the formal generic parameter only single constraint and this constraint has no feature renaming clause?
			--
			-- `a_generics' is the list of the classes generics where this formal is written in.
			--|  `a_generics' is used to resolve formals occuring as constraints.
			--| If this feature returns true, some optimizations become available: No check for renaming and the
			--| feature lookup is simpler, as there is at most one constraint.
		require
			a_generics_not_void: a_generics /= Void
			a_generics_valid: position <= a_generics.count
		local
			l_constraints: like constraints
			l_count: INTEGER
			l_constraining_type: CONSTRAINING_TYPE_AS
			l_formal: FORMAL_AS
			l_recursion_break: SEARCH_TABLE [INTEGER]
		do
			l_constraints := constraints
			if l_constraints = Void then
					-- No constraints means just constraint to ANY without any feature renaming.
				Result := True
			else
				l_count := l_constraints.count
				if l_count = 0 then
					Result := True
				elseif l_count = 1 then
						-- Further investigations are necessary
					l_constraining_type := l_constraints.first
					if l_constraining_type.renaming = Void then
							-- If we don't have a renaming check whether it is a formal
						l_formal ?= l_constraining_type.type
						if l_formal = Void then
								-- One constraint which is not a formal and has no renaming
							Result := True
						else
							create l_recursion_break.make (3)
							l_recursion_break.force (position)
							Result := a_generics[l_formal.position].recursive_is_single_constraint_without_renaming (a_generics, l_recursion_break)
						end
					end
				end
			end
				-- Uncomment this line for testing tcs#26
		 	--Result := False
		end

	is_multi_constrained (a_generics: EIFFEL_LIST [FORMAL_DEC_AS]): BOOLEAN is
			-- Does the formal generic parameter have multiple constraints?
			-- The difference between `has_multi_constraints' is the following:
			-- [G -> H, H -> {A,B}] (Each is called for G.)
			--		* `is_multi_constrained' returns True (H is multi constrained)
			--		* `has_multi_constraints' returns False (G has just one constraint)
			--
			-- `a_generics' is the list of formals where `Current' is part of.
		require
			a_generics_not_void: a_generics /= Void
			a_generics_valid: position <= a_generics.count
		local
			l_formal: FORMAL_AS
			l_recursion_break: SEARCH_TABLE [INTEGER]
			l_count: INTEGER
			l_constraints: like constraints
		do
			l_constraints := constraints
			if l_constraints /= Void then
				l_count := l_constraints.count

				if l_count = 1 then
						-- Maybe our constraint is a formal which itself has multi constraints?
					l_formal ?= l_constraints.first.type
					if l_formal /= Void and then l_formal.position /= position then
						create l_recursion_break.make (3)
						l_recursion_break.force (position)
						Result := a_generics[l_formal.position].recursive_is_multi_constraint (a_generics, l_recursion_break)
					end
				else
						--Possibly multi constraint
					 Result := l_count > 1
				end
			end
				-- Uncomment this line for testing tcs#26
			-- Result := True
		end

	has_creation_constraint: BOOLEAN is
			-- Does the construct have a creation constraint?
		do
			Result := creation_feature_list /= Void
				and then not creation_feature_list.is_empty
		end

	has_default_create: BOOLEAN
			-- Has the construct list a version of `default_create' as a creation procedure?
			-- Set after a call to `constraint_creation_list'.

	has_creation_feature_id (a_feature_id: ID_AS): BOOLEAN is
			-- Check in `creation_feature_list' if it contains a feature with id `a_feature_id'.
			--
			-- `a_feature_name_id' is the names heap id of the feature.
		require
			a_feature_id_not_void: a_feature_id /= Void
		do
			Result := has_creation_feature_name_id (a_feature_id.name_id)
		end

	has_creation_feature_name_id (a_feature_name_id: INTEGER): BOOLEAN is
			-- Check in `creation_feature_list' if it contains a feature with id `a_feature_name_id'.
			--
			-- `a_feature_name_id' is the names heap id of the feature.
		local
			creation_list: EIFFEL_LIST [FEATURE_NAME]
		do
			from
				creation_list := creation_feature_list
				creation_list.start
			until
				Result or else creation_list.after
			loop
				Result := creation_list.item.internal_name.name_id = a_feature_name_id
				creation_list.forth
			end
		end
feature {FORMAL_DEC_AS} -- Status implementation

	recursive_is_single_constraint_without_renaming (a_generics: EIFFEL_LIST[FORMAL_DEC_AS]; a_recursion_break: SEARCH_TABLE[INTEGER]): BOOLEAN
			-- Is `a_formal' still single constraint without any renamings?
			--
			-- `a_generics' is the list of generics where `a_formal' is a part of. Needed to resolve formal constraints.
			-- `a_recursion_break' is used to break the recursion in case of a loop by storing poisitions of already visited formals.
		require
			a_generics_not_void: a_generics /= Void
			a_recursion_break_not_void: a_recursion_break /= Void
		local
			l_constraints: like constraints
			l_count: INTEGER
			l_constraining_type: CONSTRAINING_TYPE_AS
			l_formal: FORMAL_AS
		do
			if a_recursion_break.has (position) then
					-- This is the case when sombebody writes a pure loop: MULTI [G -> H, H -> G]
				Result := True
			else
				l_constraints := constraints
				if l_constraints = Void then
						-- No constraints means just constraint to ANY without any feature renaming.
					Result := True
				else
					l_count := l_constraints.count
					if l_count = 1 then
						l_constraining_type := l_constraints.first
						if l_constraining_type.renaming = Void then
								-- If we don't have a renaming check whether it is a formal
							l_formal ?= l_constraining_type.type
							if l_formal = Void then
									-- One constraint which is not a formal and has no renaming
								Result := True
							else
									-- We insert the current position into the recursion break.
								a_recursion_break.force (position)
								Result := a_generics [l_formal.position].recursive_is_single_constraint_without_renaming (a_generics, a_recursion_break)
							end
						end
					end
				end
			end
		end

	recursive_is_multi_constraint (a_generics: EIFFEL_LIST [FORMAL_DEC_AS]; a_recursion_break: SEARCH_TABLE[INTEGER]): BOOLEAN
			-- Is current formal an actual multi constraint? (recursive)
			--
			-- `a_generics' is the list of generics where `a_formal' is a part of.
			-- `a_recursion_break' is used to break the recursion in case of a loop by storing poisitions of already visited formals.		
		require
			a_generics_not_void: a_generics /= Void
			a_recursion_break_not_void: a_recursion_break /= Void
		local
			l_constraints: like constraints
			l_next_formal: FORMAL_AS
			l_count: INTEGER
		do
			if not a_recursion_break.has (position) then
				l_constraints := constraints
				l_count := l_constraints.count
				if l_count = 1 then
						-- Maybe our constraint is a formal which itself has multi constraints?
					l_next_formal ?= l_constraints.first.type
					if l_next_formal /= Void then
						a_recursion_break.force (position)
						Result := a_generics[l_next_formal.position].recursive_is_multi_constraint (a_generics, a_recursion_break)
					end
				else
						-- Possibly multi-constraiend
					Result := l_count > 1
				end
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (formal, other.formal)
				and then equivalent (constraints, other.constraints)
				and then equivalent (creation_feature_list, other.creation_feature_list)
				and then is_self_initializing = other.is_self_initializing
		end

	equiv (other: like Current): BOOLEAN is
			-- Is `other' equivalent to `Current'
			-- Incrementality of the generic parameters
		require
			good_argument: other /= Void
		do
			if
				formal.is_equivalent (other.formal) and then
				is_self_initializing = other.is_self_initializing
			then
				Result := constraints.is_equivalent (other.constraints) and then
					equivalent (creation_feature_list, other.creation_feature_list)
			end
		end

feature -- Output

	constraint_string: STRING is
			-- Produce a STRING version of the CONSTRAINT
		do
			create Result.make (50)
			if is_self_initializing then
				Result.append_character ('?')
			end
			if is_reference then
				Result.append ("reference ")
			elseif is_expanded then
				Result.append ("expanded ")
			end
			Result.append (name.name.as_upper)
			if has_constraint then
				Result.append (" -> ")

				Result.append (constraints.dump (false))
				if has_creation_constraint then
					from
						creation_feature_list.start
						Result.append (" create ")
						Result.append (creation_feature_list.item.visual_name)
						creation_feature_list.forth
					until
						creation_feature_list.after
					loop
						Result.append (", ")
						Result.append (creation_feature_list.item.visual_name)
						creation_feature_list.forth
					end
					Result.append (" end")
				end
			end
		end

invariant
	constraints_not_void: constraints /= Void
	formal_not_void: formal /= Void

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class FORMAL_DEC_AS
