indexing
	description: "Prepare the C code to work with the server"
	date: "$Date$"
	revision: "$Revision$"

class
	INIT_SERVER

feature -- Initialization

	server_init is
		do
			store_init
			retrieve_init
		end

	server_reset is
		do
			store_reset
			retrieve_reset
		end

feature {NONE} -- Externals

	store_init is
		external
			"C | %"pstore.h%""
		alias
			"parsing_store_initialize"
		end

	store_reset is
		external
			"C | %"pstore.h%""
		alias
			"parsing_store_reset"
		end

	retrieve_init is
		external
			"C | %"pretrieve.h%""
		alias
			"parsing_retrieve_initialize"
		end

	retrieve_reset is
		external
			"C | %"pretrieve.h%""
		alias
			"parsing_retrieve_reset"
		end

end -- class INIT_SERVER
