-- Shared access to generator of routine and attribute offset tables

class SHARED_GENERATOR
	
feature {NONE}

	Attr_generator: ATTR_GENERATOR is
			-- Generator of attribute tables
		once
			!!Result.make;
		end;

	Rout_generator: ROUT_GENERATOR is
			-- Generator of routine tables
		once
			!!Result.make
		end;

end
