-- Shared access to generator of routine and attribute offset tables

class SHARED_GENERATOR
	
feature {NONE}

	Attr_generator: ATTR_GENERATOR is
			-- Generator of attribute tables
		once
			!!Result
		end;

	Rout_generator: ROUT_GENERATOR is
			-- Generator of routine tables
		once
			!!Result
		end;

	Makefile_generator: MAKEFILE_GENERATOR is
			-- Makefile generator
		once
			!!Result
		end;

end
