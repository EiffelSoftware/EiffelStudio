class EXPORT_ADAPTATION 

inherit

	HASH_TABLE [EXPORT_I, INTEGER]
	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end
	SHARED_ERROR_HANDLER
		undefine
			copy, is_equal
		end

create

	make
	
feature 

	all_export: EXPORT_I
			-- Export for keyword all

	set_all_export (e: EXPORT_I) is
			-- Assign `e' to `all_export'.
		do
			all_export := e
		end

	new_export_for (feature_name_id: INTEGER): EXPORT_I is
			-- Export adatation for feature `feature_name_id'
		require
			good_argument: feature_name_id > 0
		do
			Result := item (feature_name_id)
			if Result = Void then
				Result := all_export
			end
		end

end
