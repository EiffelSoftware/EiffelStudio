note
	description: "[
				application service
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_WEB

inherit
	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end

	WSF_ROUTED_SERVICE
		undefine
			execute_default
		end

	WDOCS_SERVICE

	APPLICATION_LAUNCHER

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			Precursor
			create root_dir.make_current
			set_service_option ("port", 9090)
			initialize_router
		end

feature -- Access

	root_dir: PATH

feature -- Factory

	manager: WDOCS_MANAGER
		do
			create Result.make (root_dir)
		end

end

