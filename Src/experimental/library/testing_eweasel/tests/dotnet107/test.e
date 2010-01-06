class
	TEST
 
inherit
	MSCORE_APPLICATION_EXCEPTION
		rename
			message as dotnet_message
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Initialization
		do
			make_from_message (exception_message)
		end

	exception_message: STRING is
		do
		end
      
end