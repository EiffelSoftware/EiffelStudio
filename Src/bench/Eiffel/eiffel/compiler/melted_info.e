-- Melted information

deferred class MELTED_INFO 

inherit

	COMPARABLE
		redefine
			is_equal
		end;
	SHARED_SERVER
		redefine
			is_equal
		end;
	SHARED_EXEC_TABLE
		redefine
			is_equal
		end;
	SHARED_EXTERNALS
		redefine
			is_equal
		end;
	SHARED_ARRAY_BYTE
		redefine
			is_equal
		end;

feature 


	dispatch_unit (melted_feat: FEATURE_I; class_type: CLASS_TYPE; 
					feat_tbl: FEATURE_TABLE): DISPATCH_UNIT is
			-- Dispatch unit for `melted_feat'. 
		require
			good_argument: not (class_type = Void or else feat_tbl = Void);
			consistency:	class_type.associated_class
							=
							feat_tbl.associated_class;
		local
			execution_unit: EXECUTION_UNIT;
			external_unit: EXT_EXECUTION_UNIT;
			info: EXTERNAL_INFO;
		do
				-- Evaluation of the dispatch unit of the
				-- feature: attribute `real_body_id' will be set to
				-- the `real_body_id' of the execution unit.
			!!Result.make (class_type, melted_feat);
			Dispatch_table.put (Result);
			Result := Dispatch_table.last_unit;

				-- Evaluation of the execution unit
			execution_unit := melted_feat.execution_unit (class_type);
			Execution_table.put (execution_unit);
			execution_unit := Execution_table.last_unit;

				-- Udpdate of the dispatch and execution tables
			Result.set_execution_unit (execution_unit);

				-- Update the external table
			if execution_unit.is_external then
				external_unit ?= execution_unit;
				check
					Externals.has (external_unit.external_name);
				end;
				info := Externals.item (external_unit.external_name);
				info.set_execution_unit (external_unit);
			end;
		end;

	update_dispatch_unit (class_type: CLASS_TYPE; feat_tbl: FEATURE_TABLE) is
			-- Update dispatch unit. 
		local
			melted_feat: FEATURE_I;
			disp_unit: DISPATCH_UNIT;
		do
			melted_feat := associated_feature (feat_tbl);
			disp_unit := dispatch_unit (melted_feat, class_type, feat_tbl);
		end;

	melt (class_type: CLASS_TYPE; feat_tbl: FEATURE_TABLE) is
			-- Melt the feature
		local
			melted_feat: FEATURE_I;
			disp_unit: DISPATCH_UNIT;
			s: SORTED_SET [INTEGER];
			body_id: INTEGER;
		do
			melted_feat := associated_feature (feat_tbl);
			body_id := melted_feat.body_id;
			s := class_type.valid_body_ids;
			if not s.has (body_id) then
				s.add (body_id)
			end;
			disp_unit := dispatch_unit (melted_feat, class_type, feat_tbl);
			melted_feat.melt (disp_unit, disp_unit.execution_unit);
		end;

	associated_feature (feat_tbl: FEATURE_TABLE): FEATURE_I is
			-- Associated feature
		require
			good_argument: feat_tbl /= Void
		deferred
		ensure
			Result_exists: Result /= Void
		end;

	feature_name: STRING is
			-- Name of the feature to melt
		deferred
		end;

	is_equal (other: MELTED_INFO): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := feature_name.is_equal (other.feature_name);
		end;

	infix "<" (other: MELTED_INFO): BOOLEAN is
			-- Is `other' grater than Current ?
		do
			Result := feature_name < other.feature_name;
		end;

end
