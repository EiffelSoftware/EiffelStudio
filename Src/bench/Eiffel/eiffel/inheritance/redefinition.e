indexing
	description: "Redefinition of inherited features contained in `old_features' into%N%
		%a new feature."
	date: "$Date$"
	revision: "$Revision$"

class
	REDEFINITION 

inherit
	DEFINITION
		redefine
			check_adaptation
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

creation
	make
	
feature 

	check_adaptation (feat_tbl: FEATURE_TABLE) is
			-- Check signature conformance beetween the precursors contained
			-- in `old_features' and the feature `new_feature'.
			-- Take care also of the attribute `redefinitions' of
			-- `new_feature' for merging assertions.
		require else
			old_features /= Void
			new_feature /= Void
		local
			vdrd8: VDRD8
		do
			Precursor {DEFINITION} (feat_tbl)

				-- Check assertion marks
			if
				not new_feature.is_require_else
				and then new_feature.is_ensure_then
			then
				create vdrd8
				vdrd8.set_class (System.current_class)
				vdrd8.set_feature (new_feature)
				if not new_feature.is_require_else then
					vdrd8.set_precondition
				end
				if not new_feature.is_ensure_then then
					vdrd8.set_postcondition
				end
				Error_handler.insert_error (vdrd8)
			end
		end
			
end -- class REDEFINITION
