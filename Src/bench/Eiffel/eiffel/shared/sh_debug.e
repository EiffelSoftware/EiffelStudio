class SH_DEBUG
	
feature {NONE}

	association: HASH_TABLE [FEATURE_I, INTEGER] is
			-- Assoication of routine id and feature
		once
			!!Result.make (500);
		end;

end
