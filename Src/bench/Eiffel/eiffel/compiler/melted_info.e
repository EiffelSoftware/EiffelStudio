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

	melt (class_type: CLASS_TYPE; feat_tbl: FEATURE_TABLE) is
			-- Melt the feature
		require
			good_argument: not (class_type = Void or else feat_tbl = Void);
			consistency:	class_type.associated_class
							=
							feat_tbl.associated_class;
		local
			dispatch_unit: DISPATCH_UNIT;
			execution_unit: EXECUTION_UNIT;
			external_unit: EXT_EXECUTION_UNIT;
			info: EXTERNAL_INFO;
			melted_feature: FEATURE_I
		do
			melted_feature := associated_feature (feat_tbl);
				-- Evaluation of the dispatch unit of the
				-- feature: attribute `real_body_id' will be set to
				-- the `real_body_id' of the execution unit.
			!!dispatch_unit.make (class_type, melted_feature);
			Dispatch_table.put (dispatch_unit);
			dispatch_unit := Dispatch_table.last_unit;

				-- Evaluation of the execution unit
			execution_unit := melted_feature.execution_unit (class_type);
			Execution_table.put (execution_unit);
			execution_unit := Execution_table.last_unit;

				-- Udpdate of the dispatch and execution tables
			dispatch_unit.set_execution_unit (execution_unit);

				-- Update the external table
			if execution_unit.is_external then
				external_unit ?= execution_unit;
				check
					Externals.has (external_unit.external_name);
				end;
				info := Externals.item (external_unit.external_name);
				info.set_execution_unit (external_unit);
			end;

			melted_feature.melt (dispatch_unit, execution_unit);
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
