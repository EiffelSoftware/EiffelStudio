note
	description: "[
		Encapsulates a HASH_TABLE of XC_SERVER_MODULEs
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_SERVER_MODULES


inherit
	HASH_TABLE [XC_SERVER_MODULE, STRING]
	XS_SHARED_SERVER_OUTPUTTER
		undefine
			is_equal,
			copy
		end

create
	make

feature -- Status setting

	run_all
			-- Launches all modules
		do
			from
				start
			until
				after
			loop
				o.dprint ("Launching '" + key_for_iteration.out + "'", 2)
				item_for_iteration.launch
				forth
			end
		end

end

