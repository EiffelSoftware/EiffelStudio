indexing
	description: "Objects that hold code generation settings, for GB_XML_STORE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_GENERATION_SETTINGS

feature -- Access

	generate_names: BOOLEAN
		-- Should a default name be generated
		-- for any object that does not have a name?
		
	is_saving: BOOLEAN
		-- Is current generation representing a save
		-- operation?

feature -- Status setting

	enable_generate_names is
			-- Assign `True' to `generate_names'.
		do
			generate_names := True
		end
		
	disable_generate_names is
			-- Assign `False' to `generate_names'.
		do
			generate_names := False
		end
		
	enable_is_saving is
			-- Assign `True' to `is_saving'.
		do
			is_saving := True
		end
		
	disable_is_saving is
			-- Assign `False' to `is_saving'.
		do
			is_saving := False
		end
		
		

end -- class GB_GENERATION_SETTINGS
