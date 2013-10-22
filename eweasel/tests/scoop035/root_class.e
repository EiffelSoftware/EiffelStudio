note
	description	: "System's root class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision: 90701 $"

class
	ROOT_CLASS

inherit

	SHARED_APPLICATION_CONFIGURATION

create
	make

feature -- Initialization


	make
			-- Creation procedure.
		local
			cfg: APPLICATION_CONFIGURATION
		do
			create cfg.make
			set_app_configuration (cfg)
		end
end
