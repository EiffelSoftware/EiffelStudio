indexing
	description: "Transaction that unregisters an application to use a specific Eiffel Codedom Provider configuration"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDM_UNREGISTRATION

inherit
	ECDM_TRANSACTION

create
	make

feature -- Basic Operation

	commit is
			-- Register application.
		do
			manager.delete_application (application_path)
		end

end -- class ECDM_REGISTRATION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Manager
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------