indexing
	description: "Abstract description of a formal generic parameter. %
				%Instances produced by Yacc. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_DEC_AS_B

inherit
	FORMAL_DEC_AS
		undefine
			same_as, associated_eiffel_class
		redefine
			formal_name, constraint, creation_feature_list
		end

	FORMAL_AS_B
		undefine
			set, is_equivalent, text_position, simple_format
		end

	SHARED_SERVER
		export
			{NONE} all
		end

feature -- Attributes

	formal_name: ID_AS_B
			-- Formal generic parameter name

	constraint: TYPE_B
			-- Constraint of the formal generic
	
	creation_feature_list: EIFFEL_LIST_B [FEATURE_NAME_B]
			-- Constraint on the creation routines of the constraint

feature -- Comparison

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
			creation_list: EIFFEL_LIST_B [FEATURE_NAME_B]
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

	check_constraint_creation (current_class: CLASS_C; current_type: TYPE_B) is
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
			class_type: CLASS_TYPE_AS_B
			vtcg6: VTCG6
		do
			cluster := current_class.cluster
			class_type ?= current_type
			
			check
				-- The assignement attempt should return a non-Void value since
				-- we are sure that we are effectively passing a CLASS_TYPE_AS_B
				class_type_validity: class_type /= Void
			end

			class_i := universe.class_named (class_type.class_name, cluster)

				-- We handle only the case where `class_i' is a valid reference
				-- because the case has been handled in `check_constraint_type'
				-- from CLASS_TYPE_AS_B which is called just before this feature.
			if class_i /= Void then
					-- Here we assume that the class is correct (cad `check_constraint_type'
					-- from CLASS_TYPE_AS_B did not add any error items to `Error_handler'.
					
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

end -- class FORMAL_DEC_AS_B
