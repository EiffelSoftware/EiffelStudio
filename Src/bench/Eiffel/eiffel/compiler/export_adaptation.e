class EXPORT_ADAPTATION 

inherit

	EXTEND_TABLE [EXPORT_I, STRING];
	SHARED_WORKBENCH
		undefine
			twin
		end;
	SHARED_ERROR_HANDLER
		undefine
			twin
		end

creation

	make
	
feature 

	all_export: EXPORT_I;
			-- Export for keyword all

	set_all_export (e: EXPORT_I) is
			-- Assign `e' to `all_export'.
		do
			all_export := e;
		end;

	new_export_for (feature_name: STRING): EXPORT_I is
			-- Export adatation for feature `feature_name'
		require
			good_argument: feature_name /= Void
		do
			Result := item (feature_name);
			if Result = Void then
				Result := all_export;
			end;
		end;

end
