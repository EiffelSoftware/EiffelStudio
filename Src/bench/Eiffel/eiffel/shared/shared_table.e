-- Access to all the Eiffel tables

class SHARED_TABLE

inherit

	SHARED_WORKBENCH
	
feature {NONE}

	Eiffel_table: EIFFEL_HISTORY is
			-- Array of data tables for the final Eiffel executable. This
			-- might contain at an index `rout_id' either a routine table
			-- (instance of ROUT_TABLE) or an attribute offset table (instance
			-- of ATTR_TABLE)
		once
			!!Result.make
		end;

feature {NONE} -- DLE

	Old_eiffel_table: DLE_EIFFEL_HISTORY is
			-- Array of data tables for the final Eiffel executable of the
			-- extendible system. This might contain at an index `rout_id'
			-- either a routine table (instance of ROUT_TABLE) or an attribute
			-- offset table (instance of ATTR_TABLE)
		require
			dynamic_system: System.is_dynamic
		once
			Result := System.dle_eiffel_table
		end;

end
