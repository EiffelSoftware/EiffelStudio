class SHARED_OPTIMIZATION_TABLES

inherit

	SHARED_WORKBENCH

feature

	optimization_tables: OPTIMIZATION_TABLES is
		do
			Result := System.optimization_tables
		end

end
