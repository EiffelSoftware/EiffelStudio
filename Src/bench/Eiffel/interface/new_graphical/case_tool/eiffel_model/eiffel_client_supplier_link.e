indexing
	description: "Objects that is a model for a client supplier link."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EM_CLIENT_SUPPLIER_LINK
	
inherit
	EG_LINK
		rename
			source as client,
			target as supplier
		redefine
			default_create
		end
	
create
	make_with_classes_and_name
	
feature {NONE} -- Initialization

	default_create is
			-- Create an EIFFEL_CLIENT_SUPPLIER_LINK.
		do
			Precursor {EG_LINK}
			create is_aggregated_changed
		end

	make_with_classes_and_name (a_client, a_supplier: EM_CLASS; a_name: like name) is
			-- Create a EIFFEL_CLIENT_SUPPLIER_LINK with `a_name'.
		require
			a_client_not_void: a_client /= Void
			a_supplier_not_void: a_supplier /= Void
			a_name_not_void: a_name /= Void
		do
			make_directed_with_source_and_target (a_client, a_supplier)
			name := a_name
			if a_supplier.is_expanded then
				is_aggregated := True
			end
		ensure
			set: client = a_client and supplier = a_supplier
			name_set: name = a_name
		end
		
feature -- Status report

	is_aggregated: BOOLEAN
			-- Is `Current' an aggregated link (`supplier' is expanded)?.
			
	is_aggregated_changed: EV_NOTIFY_ACTION_SEQUENCE
			-- Called when `is_aggregated' is changed.
			
feature -- Status settings

	set_is_aggregated (b: BOOLEAN) is
			-- Set `is_aggregated' to `b'.
		do
			if b /= is_aggregated then
				is_aggregated := b
				is_aggregated_changed.call (Void)
			end
		ensure
			set: is_aggregated = b
		end
		
invariant
	is_aggregated_changed_not_void: is_aggregated_changed /= Void

end -- class EM_CLIENT_SUPPLIER_LINK
