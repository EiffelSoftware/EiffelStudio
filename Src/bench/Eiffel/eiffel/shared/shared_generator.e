-- Shared access to generator of routine and attribute offset tables

class SHARED_GENERATOR

inherit

	SHARED_WORKBENCH
	
feature {NONE}

	Attr_generator: ATTR_GENERATOR is
			-- Generator of attribute tables
		once
			if System.extendible or System.is_dynamic then
				!DLE_ATTR_GENERATOR! Result
			else
				!! Result
			end
		end;

	Rout_generator: ROUT_GENERATOR is
			-- Generator of routine tables
		once
			if System.extendible or System.is_dynamic then
				!DLE_ROUT_GENERATOR! Result
			else
				!! Result
			end
		end;

	Desc_generator: DESC_GENERATOR is
			-- Generator of precompiled descriptor tables
		once
			!! Result
		end;

end
