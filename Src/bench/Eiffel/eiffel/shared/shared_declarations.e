-- Shared access to C extern declarations generator

class SHARED_DECLARATIONS

inherit
	SHARED_WORKBENCH

feature

	Extern_declarations: EXTERN_DECLARATIONS is
			-- C extern declarations generator
		once
			if System.is_dynamic or System.extendible then
				!DLE_EXTERN_DECLARATIONS! Result.make
			else
				!! Result.make
			end
		end;

feature {NONE} -- DLE

	Rout_declarations: DLE_EXTERN_DECLARATIONS is
			-- Routine tables and C extern declaration generator
		require
			dle_system: System.is_dynamic or System.extendible
		once
			Result ?= Extern_declarations
		end;

	Attr_declarations: DLE_EXTERN_DECLARATIONS is
			-- Routine tables and C extern declaration generator
		require
			dle_system: System.is_dynamic or System.extendible
		once
			!!Result.make
		end;

end
