indexing
	description: "Shared configuration factory."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CONF_FACTORY

feature {NONE}

	Conf_factory: CONF_FACTORY is
			-- Configuration factory
		once
			Result := Compiler_conf_factory
		end

	Configuration_factory: CONF_FACTORY is
			-- Configuration system factory.
		once
			create Result
		end

	Compiler_conf_factory: CONF_COMP_FACTORY is
			-- Compiler configuration factory.
		once
			create Result
		end



end
