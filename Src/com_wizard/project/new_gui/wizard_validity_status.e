indexing
	description: "Object returned by validity checking functions"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_VALIDITY_STATUS

inherit
	WIZARD_VALIDITY_STATUS_IDS

create
	make_success,
	make_error

feature {NONE} -- Initialization

	make_success (a_id: like id) is
			-- Set `id' with `a_id'.
		require
			valid_id: is_valid_status_id (a_id)
		do
			id := a_id
		ensure
			id_set: id = a_id
		end
	
	make_error (a_id: like id) is
			-- Set `id' with `a_id'.
			-- Set `is_error' to `True'.
		require
			valid_id: is_valid_status_id (a_id)
		do
			id := a_id
			is_error := True
		ensure
			id_set: id = a_id
			is_error: is_error
		end

feature -- Access

	id: INTEGER
			-- Status ID
			-- Used to check for global validity

	is_error: BOOLEAN
			-- Does status correspond to error?
	
	error_message: STRING is
			-- Error message if `is_error'
		do
			Result := errors.item (id)
		ensure
			non_void_message: Result /= Void
		end

invariant
	valid_id: is_valid_status_id (id)
		
end

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