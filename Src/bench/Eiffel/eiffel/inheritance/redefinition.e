-- Redefinition of inherited features contained in `old_features' into
-- a new feature

class REDEFINITION 

inherit

	DEFINITION
		rename
			check_adaptation as check_definition
		end;
	DEFINITION
		redefine
			check_adaptation
		select
			check_adaptation
		end;
	SHARED_WORKBENCH;
	SHARED_ERROR_HANDLER;


creation

	make
	
feature 

	check_adaptation (feat_tbl: FEATURE_TABLE) is
			-- Check signature conformance beetween the precursors contained
			-- in `old_features' and the feature `new_feature'.
			-- Take care also of the attribute `redefinitions' of
			-- `new_feature' for merging assertions.
		require else
			old_features /= Void;
			new_feature /= Void;
		local
			vdrd8: VDRD8;
		do
			check_definition (feat_tbl);

				-- Check assertion marks
			if not (
						new_feature.is_require_else
						and then
						new_feature.is_ensure_then
					)
			then
				!!vdrd8;
				vdrd8.set_class_id (System.current_class.id);
				vdrd8.set_a_feature (new_feature);
				Error_handler.insert_error (vdrd8);
			end;
		end;
			
end
