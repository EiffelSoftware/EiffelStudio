indexing
	description: "Abstract description of a formal generic parameter. %
				%Instances produced by Yacc. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_DEC_AS

inherit
	FORMAL_AS
		redefine
			set, is_equivalent, simple_format
		end

	SHARED_SERVER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			formal_name ?= yacc_arg (0)
			constraint ?= yacc_arg (1)
			creation_feature_list ?= yacc_arg (2)
			position := yacc_int_arg (0)
		ensure then
			formal_name_exists: formal_name /= Void
		end; 

feature -- Attributes

	formal_name: ID_AS
			-- Formal generic parameter name

	constraint: TYPE
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
				and then not creation_feature_list.empty
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (formal_name, other.formal_name)
				and then equivalent (constraint, other.constraint)
				and then equivalent (creation_feature_list, other.creation_feature_list)
				and then position = other.position
		end

	equiv (other: like Current): BOOLEAN is
			-- Is `other' equivalent to `Current'
			-- Incrementality of the generic parameters
		require
			good_argument: other /= Void
		local
			ct, o_ct: TYPE_A
		do
				-- Test on void is done only to
				-- protect incorrect generic constraints
			ct := constraint_type
			o_ct := other.constraint_type
			if ct /= Void then
				if o_ct /= Void then
					Result := ct.same_as (o_ct)
				end
			else
				Result := o_ct = Void
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
		local
			class_type: CL_TYPE_A
			class_id: CLASS_ID
			feature_name: STRING
			feat_table: FEATURE_TABLE
		do
			if creation_feature_list /= Void then
				class_type ?= constraint_type
				if class_type /= Void then
					class_id := class_type.base_class_id
					feat_table := Feat_tbl_server.item (class_id)
					check
							-- A feature table associated to `base_class_id' should
							-- always be in the system
						feature_table_exists: feat_table /= Void
					end
					from
						creation_feature_list.start
						!! Result.make
					until
						creation_feature_list.after
					loop
						feature_name := creation_feature_list.item.internal_name
						Result.extend (feat_table.item (feature_name))
						Result.forth
						creation_feature_list.forth
					end
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

	Any_constraint_type: CL_TYPE_A is
			-- Default constraint actual type
		once
			!!Result
			Result.set_base_class_id (System.any_id)
		end

feature -- creation feature check

	check_constraint_creation (current_class: CLASS_C; current_type: TYPE) is
			-- Check validity of the creation clause in the constraint
		require
			current_class_exists: current_class /= Void
			current_type_exists: current_type /= Void
			has_creation_constraint: has_creation_constraint
		local
			associated_class: CLASS_C
			class_i: CLASS_I
			cluster: CLUSTER_I
			matched: BOOLEAN
			feature_name: STRING
			feat_table: FEATURE_TABLE
			class_type: CLASS_TYPE_AS
			vtcg6: VTCG6
		do
			cluster := current_class.cluster
			class_type ?= current_type
			
			check
				-- The assignement attempt should return a non-Void value since
				-- we are sure that we are effectively passing a CLASS_TYPE_AS
				class_type_validity: class_type /= Void
			end

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
					matched := True
				until
					not matched or else creation_feature_list.after	
				loop
					feature_name := creation_feature_list.item.internal_name
					matched := associated_class.feature_table.has (feature_name)	
					creation_feature_list.forth
				end

				if not matched then
					-- The feature listed in the creation constraint have not been
					-- declared in the constraint class.
					!! vtcg6
					vtcg6.set_class (current_class)
					vtcg6.set_constraint_class (associated_class)
					vtcg6.set_feature_name (feature_name)
					Error_handler.insert_error (vtcg6)
				end
			end
		end

feature -- Output

	constraint_string: STRING is
			-- Produce a STRING version of the CONSTRAINT
		local
			feature_name: FEAT_NAME_ID_AS
		do
			!! Result.make (50)
			Result.append (formal_name)
			if has_constraint then
				Result.append (" -> ")
				Result.append (constraint.dump)
				Result.to_upper
				if has_creation_constraint then
					from
						creation_feature_list.start
						Result.append (" create ")
						feature_name ?= creation_feature_list.item
						Result.append (feature_name.feature_name)
						creation_feature_list.forth
					until
						creation_feature_list.after
					loop
						Result.append (", ")
						feature_name ?= creation_feature_list.item
						Result.append (feature_name.feature_name)
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
			feature_name: FEAT_NAME_ID_AS
		do
			c_name := clone (formal_name)
			c_name.to_upper
			st.add_string (c_name)
			if has_constraint then
				st.add (ti_Space)
				st.add (ti_Constraint)
				st.add (ti_Space)
				constraint.append_to (st)
				if has_creation_constraint then
					from
						creation_feature_list.start
						st.add (ti_Space)
						st.add (ti_Creation_keyword)
						st.add (ti_Space)
						feature_name ?= creation_feature_list.item
						st.add_string (feature_name.feature_name)
						creation_feature_list.forth
					until
						creation_feature_list.after
					loop
						st.add (ti_Comma)
						st.add (ti_Space)
						feature_name ?= creation_feature_list.item
						st.add_string (feature_name.feature_name)
						creation_feature_list.forth
					end
					st.add (ti_Space)
					st.add (ti_End_keyword)
				end
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			s: STRING
			feature_name: FEAT_NAME_ID_AS
		do
			s := clone (formal_name)
			s.to_upper
			ctxt.put_string (s)
			if has_constraint then
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_Constraint)
				ctxt.put_space
				ctxt.format_ast (constraint)
				if has_creation_constraint then
					from
						creation_feature_list.start
						ctxt.put_space
						ctxt.put_text_item (ti_Creation_keyword)
						ctxt.put_space
						feature_name ?= creation_feature_list.item
						ctxt.put_string (feature_name.feature_name)
						creation_feature_list.forth
					until
						creation_feature_list.after
					loop
						ctxt.put_text_item (ti_Comma)
						ctxt.put_space
						feature_name ?= creation_feature_list.item
						ctxt.put_string (feature_name.feature_name)
						creation_feature_list.forth
					end
					ctxt.put_space
					ctxt.put_text_item (ti_End_keyword)
				end
			end
		end

end -- class FORMAL_DEC_AS
