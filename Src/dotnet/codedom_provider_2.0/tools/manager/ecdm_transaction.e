indexing
	description: "Transaction corresponding to change in Eiffel Codedom Provider configuration"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECDM_TRANSACTION


feature -- Initialization

	make (a_path: STRING; a_configuration: ECDM_CONFIGURATION; a_manager: ECDM_MANAGER) is
			-- Set `application_path' with `a_path'
			-- Set `configuration' with `a_configuration'.
			-- Set `manager' with `a_manager'.
		require
			non_void_path: a_path /= Void
			non_void_configuration: a_configuration /= Void
			non_void_manager: a_manager /= Void
		do
			application_path := a_path
			configuration := a_configuration
			manager := a_manager
		ensure
			path_set: application_path = a_path
			configuration_set: configuration = a_configuration
			manager_set: manager = a_manager
		end

feature -- Access

	application_path: STRING
			-- Path to application involved in transaction
	
	configuration: ECDM_CONFIGURATION
			-- Configuration involved in transaction

	manager: ECDM_MANAGER
			-- Configuration manager involved in transaction

feature -- Basic Operation

	commit is
			-- Commit transaction.
		deferred
		end

invariant
	non_void_application_path: application_path /= Void
	non_void_configuration: configuration /= Void
	non_void_manager: manager /= Void

end -- class ECDM_TRANSACTION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Manager
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------