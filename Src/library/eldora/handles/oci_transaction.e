indexing
	description: "Wrapper for user session"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"
	history: "$History: oci_transaction.e $"

class
	OCI_TRANSACTION
	
inherit
	OCI_CHILD_HANDLE

create
	make, make_child_by_handle

feature {OCI_HANDLE} -- Implementation

	handle_type: INTEGER is
			-- Handle type
		do
			Result := Oci_htype_trans
		end
		
end -- class OCI_TRANSACTION
