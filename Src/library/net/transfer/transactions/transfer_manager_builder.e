indexing
	description:
		"Singleton instance of the transfer manager builder"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	TRANSFER_MANAGER_BUILDER

feature -- Access

	Transfer_manager_builder: TRANSFER_MANAGER_BUILDER_IMPL is
			-- Transfer manager builder singleton
		once
			create Result.make
		end

end -- class TRANSFER_MANAGER_BUILDER

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

