indexing
	description: "Eiffel compiler that can be used from either EiffelStudio or from Visual Studio .NET"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_WINDOWS_KERNEL

inherit
	EB_KERNEL
		rename
			make as standard_make
		end
		
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize server.
		local
			local_string: STRING
			com_compiler: ECOM_ISE_REGISTRATION
		do
			if argument_count > 0 then
				local_string :=argument (1)
				local_string.to_lower
			end
			if
				local_string /= Void and
				(local_string.is_equal ("-regserver") or local_string.is_equal ("/regserver") or
				local_string.is_equal ("-unregserver") or local_string.is_equal ("/unregserver") or
				local_string.is_equal ("-embedding") or local_string.is_equal ("/embedding"))
			then
				register_basic_graphical_types
				initialize_resources (system_general, Eiffel_preferences)
				create com_compiler.make
			else
				standard_make
			end
		end

end -- class EB_WINDOWS_KERNEL
