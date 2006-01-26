indexing
	description: "Object that represents a list of features that are exported to the same client set"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_EXPORT_ITEM_LIST

create
	make

feature{NONE} -- Implementation

	make (a_clients: like clients) is
			-- Initialize.
		require
			a_clients_not_void: a_clients /= Void
		do
			create feature_name_list.make
			clients := a_clients
		ensure
			clients_set: clients = a_clients
		end

feature -- Access

	feature_name_list: LINKED_LIST [STRING]
			-- List of feature name

	clients: ERT_CLIENT_SET
			-- Clients to which `feature_name' is exported

invariant
	feature_name_list_not_void: feature_name_list /= Void
	clients_not_void: clients /= Void

end
