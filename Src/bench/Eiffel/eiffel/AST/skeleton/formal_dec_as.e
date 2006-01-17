indexing
	description: "Abstract description of a formal generic parameter. %
				%Instances produced by Yacc. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_DEC_AS

inherit
	FORMAL_AS
		rename
			initialize as initialize_formal_as
		redefine
			process, is_equivalent
		end

	SHARED_SERVER
		export
			{NONE} all
		end

	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (f: FORMAL_AS; c: like constraint; cf: like creation_feature_list; c_as: like constrain_symbol) is
			-- Create a new FORMAL_DECLARATION AST node.
		require
			f_not_void: f /= Void
		do
			name := f.name
			constraint := c
			creation_feature_list := cf
			position := f.position
			is_reference := f.is_reference
			is_expanded := f.is_expanded
			constrain_symbol := c_as
			formal_para := f
		ensure
			name_set: name = f.name
			constraint_set: constraint = c
			creation_feature_list_set: creation_feature_list = cf
			position_set: position = f.position
			is_reference_set: is_reference = f.is_reference
			is_expanded_set: is_expanded = f.is_expanded
			constrain_symbol_set: constrain_symbol = c_as
			formal_para_set: formal_para = f
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_formal_dec_as (Current)
		end

feature -- Roundtrip

	constrain_symbol: SYMBOL_AS
			-- Symbol "->" associated with this structure

	formal_para: FORMAL_AS
			-- Formal generic parameter associated with this structure

feature -- Attributes

	constraint: TYPE_AS
			-- Constraint of the formal generic

	creation_feature_list: EIFFEL_LIST [FEATURE_NAME]
			-- Constraint on the creation routines of the constraint

feature -- Status

	has_constraint: BOOLEAN is
			-- Does the formal generic parameter have a constraint?
		do
			Result := constraint /= Void
		end

	has_creation_constraint: BOOLEAN is
			-- Does the construct have a creation constraint?
		do
			Result := creation_feature_list /= Void
				and then not creation_feature_list.is_empty
		end

	has_default_create: BOOLEAN
			-- Does the construct list `default_create' has creation procedure?
			-- Set after a call to `constraint_creation_list'.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (name, other.name)
				and then equivalent (constraint, other.constraint)
				and then equivalent (creation_feature_list, other.creation_feature_list)
				and then Precursor {FORMAL_AS} (other)
		end

	equiv (other: like Current): BOOLEAN is
			-- Is `other' equivalent to `Current'
			-- Incrementality of the generic parameters
		require
			good_argument: other /= Void
		local
			ct, o_ct: like constraint
		do
			Result := position = other.position and then
				is_reference = other.is_reference and then
				is_expanded = other.is_expanded
			if Result then
				ct := constraint
				o_ct := other.constraint
				if ct = Void then
					Result := o_ct = Void
				else
					Result := o_ct /= Void and then o_ct.same_type (ct) and then o_ct.is_equivalent (ct)
					Result := Result and then
						equivalent (creation_feature_list, other.creation_feature_list)
				end
			end
		end

feature -- Status

	constraint_type: TYPE_A is
			-- Actual type of the constraint.
		do
			if constraint = Void then
					-- Default constraint to ANY
				Result := Any_constraint_type
			else
				Result := constraint.actual_type
			end
		end

	constraint_creation_list: LINKED_LIST [FEATURE_I] is
			-- Actual creation routines from a constraint clause
		require
			has_creation_constraint: has_creation_constraint
			has_computed_feature_table: has_computed_feature_table
		local
			class_type: CL_TYPE_A
			class_id: INTEGER
			feature_name: STRING
			feat_table: FEATURE_TABLE
		do
			class_type ?= constraint_type
			if class_type /= Void then
				class_id := class_type.class_id
				feat_table := Feat_tbl_server.item (class_id)
				check
						-- A feature table associated to `base_class_id' should
						-- always be in the system
					feature_table_exists: feat_table /= Void
				end
				from
					creation_feature_list.start
					create Result.make
				until
					creation_feature_list.after
				loop
					feature_name := creation_feature_list.item.internal_name
					feat_table.search (feature_name)
					Result.extend (feat_table.found_item)
					Result.forth

					if not has_default_create then
						has_default_create := feat_table.found_item.rout_id_set.first =
													System.default_create_id
					end
					creation_feature_list.forth
				end
			end
		end

	has_computed_feature_table: BOOLEAN is
			-- Check that we can retrieve a FEATURE_TABLE from the class
			-- on which we want to check the validity rule about creation
			-- constraint.
			--| Basically, sometimes (degree 4) for example, we need to access
			--| the information on a class which has not been yet compiled, because
			--| of the order of the compilation which does not take into account
			--| the constraint part.
		local
			class_type: CL_TYPE_A
		do
			if creation_feature_list /= Void then
				class_type ?= constraint_type
				if class_type /= Void then
					Result := Feat_tbl_server.item (class_type.class_id) /= Void
				end
			end
		end

	has_creation_feature_name (feature_name: STRING): BOOLEAN is
			-- Check in `creation_feature_list' if it contains `feature_name'.
		local
			creation_list: EIFFEL_LIST [FEATURE_NAME]
		do
			from
				creation_list := creation_feature_list
				creation_list.start
			until
				Result or else creation_list.after
			loop
				Result := creation_list.item.internal_name.string_value.is_equal (feature_name)
				creation_list.forth
			end
		end

feature {NONE} -- Access

	Any_constraint_type: CL_TYPE_A is
			-- Default constraint actual type
		once
			create Result.make (System.any_id)
		end

feature -- creation feature check

	check_constraint_creation (current_class: CLASS_C; current_type: TYPE_AS) is
			-- Check validity of the creation clause in the constraint
		require
			current_class_exists: current_class /= Void
			current_type_exists: current_type /= Void
			has_creation_constraint: has_creation_constraint
		local
			associated_class: CLASS_C
			class_i: CLASS_I
			cluster: CLUSTER_I
			feature_name: STRING
			feat_table: FEATURE_TABLE
			class_type: CLASS_TYPE_AS
			vtcg6: VTCG6
		do
			cluster := current_class.cluster
			class_type ?= current_type

			if class_type = Void then
					-- Generic constraint lists a type which is not a class type:
					--   fictitious class NONE
					--   tuple type
					--   formal generic parameter
					-- There are no features that can be used for creation.
				fixme ("Process formal generic parameter.")
				create vtcg6
				vtcg6.set_class (current_class)
				vtcg6.set_constraint_type (current_type)
				vtcg6.set_feature_name (creation_feature_list.first.internal_name)
				vtcg6.set_location (creation_feature_list.first.start_location)
				Error_handler.insert_error (vtcg6)
			else
				class_i := universe.class_named (class_type.class_name, cluster)
					-- We handle only the case where `class_i' is a valid reference
					-- because the case has been handled in `check_constraint_type'
					-- from CLASS_TYPE_AS which is called just before this feature.
				if class_i /= Void then
						-- Here we assume that the class is correct (cad `check_constraint_type'
						-- from CLASS_TYPE_AS did not add any error items to `Error_handler'.

						-- Here we will just check that the feature listed in the creation
						-- constraint part are effectively features of the constraint.
					from
						creation_feature_list.start
						associated_class := class_i.compiled_class
						feat_table := associated_class.feature_table
					until
						creation_feature_list.after
					loop
						feature_name := creation_feature_list.item.internal_name
						feat_table.search (feature_name)
						if
							not feat_table.found or else
							not is_valid_creation_routine (feat_table.found_item)
						then
								-- The feature listed in the creation constraint have not been
								-- declared in the constraint class.
							create vtcg6
							vtcg6.set_class (current_class)
							vtcg6.set_constraint_class (associated_class)
							vtcg6.set_feature_name (feature_name)
							vtcg6.set_location (creation_feature_list.item.start_location)
							Error_handler.insert_error (vtcg6)
						end
						creation_feature_list.forth
					end
				end
			end
		end

feature -- Output

	constraint_string: STRING is
			-- Produce a STRING version of the CONSTRAINT
		do
			create Result.make (50)
			if is_reference then
				Result.append ("reference ")
			elseif is_expanded then
				Result.append ("expanded ")
			end
			Result.append (name.as_upper)
			if has_constraint then
				Result.append (" -> ")
				Result.append (constraint.dump.as_upper)
				if has_creation_constraint then
					from
						creation_feature_list.start
						Result.append (" create ")
						Result.append (creation_feature_list.item.internal_name)
						creation_feature_list.forth
					until
						creation_feature_list.after
					loop
						Result.append (", ")
						Result.append (creation_feature_list.item.internal_name)
						creation_feature_list.forth
					end
					Result.append (" end")
				end
			end
		end

	append_signature (st: STRUCTURED_TEXT) is
			-- Append the signature of current class in `st'
			--| We do not produce the creation constraint clause since
			--| it is useless in this case.
		require
			non_void_st: st /= Void
		local
			c_name: STRING
			eiffel_name: STRING
		do
			if is_reference then
				st.add (ti_reference_keyword)
				st.add_space
			elseif is_expanded then
				st.add (ti_expanded_keyword)
				st.add_space
			end
			c_name := name.as_upper
			st.add (create {GENERIC_TEXT}.make (c_name))
			if has_constraint then
				st.add_space
				st.add (ti_Constraint)
				st.add_space
				constraint.append_to (st)
				if has_creation_constraint then
					from
						creation_feature_list.start
						st.add_space
						st.add (ti_Create_keyword)
					until
						creation_feature_list.after
					loop
						st.add_space
						eiffel_name := creation_feature_list.item.internal_name
						st.add_string (eiffel_name)
						creation_feature_list.forth
						if not creation_feature_list.after then
							st.add (ti_Comma)
						end
					end
					st.add_space
					st.add (ti_End_keyword)
				end
			end
		end

feature {NONE} -- Implementation

	is_valid_creation_routine (f: FEATURE_I): BOOLEAN is
			-- Does `f' have all the needed requirement to be
			-- used a creation routine for the future creation
			-- of the generic parameter.
		require
			feature_exists: f /= Void
		local
			p: PROCEDURE_I
		do
			p ?= f
			Result := p /= Void
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

end -- class FORMAL_DEC_AS
