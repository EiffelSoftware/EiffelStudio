indexing
	description: "Shared Generators. Must be once so that if a parent interface is generated%
					%this is known and next time the same interface is processed it is not%
					%generated again"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SHARED_GENERATORS

feature -- Access

	C_client_generator: WIZARD_COMPONENT_INTERFACE_C_CLIENT_GENERATOR is
			-- Component interface C client generator
		once
			create Result
		end
		
	C_server_generator: WIZARD_COMPONENT_INTERFACE_C_SERVER_GENERATOR is
			-- Component interface C server generator
		once
			create Result
		end

	Eiffel_client_generator: WIZARD_COMPONENT_INTERFACE_EIFFEL_CLIENT_GENERATOR is
		once
			create Result
		end

	Eiffel_server_generator: WIZARD_COMPONENT_INTERFACE_EIFFEL_SERVER_GENERATOR is
		once
			create Result
		end

	Eiffel_coclass_server_generator: WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_GENERATOR is
		once
			create Result
		end
	
	Eiffel_server_impl_generator: WIZARD_COCLASS_INTERFACE_EIFFEL_SERVER_IMPL_GENERATOR is
		once
			create Result
		end

	Source_eiffel_server_generator: WIZARD_COMPONENT_INTERFACE_SOURCE_EIFFEL_SERVER_GENERATOR is
		once
			create Result
		end

end -- class WIZARD_SHARED_GENERATORS

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
