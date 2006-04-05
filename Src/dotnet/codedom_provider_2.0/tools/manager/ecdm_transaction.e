indexing
	description: "Transaction corresponding to change in Eiffel Codedom Provider configuration"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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