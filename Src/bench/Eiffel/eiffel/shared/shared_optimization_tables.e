class SHARED_OPTIMIZATION_TABLES

inherit

	SHARED_WORKBENCH

feature

	optimization_tables: SEARCH_TABLE [OPTIMIZE_UNIT] is
		do
			Result := System.optimization_tables
		end

end
