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

feature -- Initialization

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
			feature_name: STRING
			class_type: CL_TYPE_A
			class_id: CLASS_ID
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

	Any_constraint_type: CL_TYPE_A is
			-- Default constraint actual type
		once
			!!Result
			Result.set_base_class_id (System.any_id)
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

end -- class FORMAL_DEC_AS_B
