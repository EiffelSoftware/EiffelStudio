-- Shared access to generator of routine and attribute offset tables

class SHARED_GENERATOR

inherit
	SHARED_WORKBENCH
	
feature {NONE}

	Attr_generator: ATTR_GENERATOR is
			-- Generator of attribute tables
		once
			!! Result
		end;

	Rout_generator: ROUT_GENERATOR is
			-- Generator of routine tables
		once
			!! Result
		end;

end
