indexing
	description: "Prepare the C code to work with the server"
	date: "$Date$"
	revision: "$Revision$"

class
	INIT_SERVERS

creation
	make

feature -- Initialization

	make is
		do
			store_init
			retrieve_init
		end

feature -- Disposal

	dispose is
		external
			"C | %"pstore.h%""
		alias
			"parsing_store_dispose"
		end

feature {NONE} -- Externals

	store_init is
		external
			"C | %"pstore.h%""
		alias
			"parsing_store_initialize"
		end

	retrieve_init is
		external
			"C | %"pretrieve.h%""
		alias
			"parsing_retrieve_initialize"
		end

end -- class INIT_SERVER
