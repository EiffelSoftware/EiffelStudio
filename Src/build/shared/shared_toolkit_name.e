class SHARED_TOOLKIT_NAME

inherit
	
	CONSTANTS

feature

	Shared_toolkit_name: STRING is
		once
			!! Result.make (0);
			Result.append (Resources.default_toolkit)
		end;

end
