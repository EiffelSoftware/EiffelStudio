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

end -- class GB_GENERATION_SETTINGS
