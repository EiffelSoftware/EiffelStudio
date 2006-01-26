indexing
	description: "[
					Object that represents a feature with its clients in an export clause.
					This class is used for roundtrip text modification, not by compiler.
				]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_EXPORT_FEATURE

create
	make

feature{NONE} -- Implementation

	make (a_name: like feature_name; a_clients: like clients) is
			-- Initialize instance.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			a_clients_not_void: a_clients /= Void
		do
			feature_name := a_name.twin
			clients := a_clients
		ensure
			feature_name_set: feature_name.is_equal (a_name)
			clients_set: clients = a_clients
		end

feature -- Status reporting

	is_all: BOOLEAN is
			-- Does current represent "all" features?
		do
			Result := feature_name.is_case_insensitive_equal (once "all")
		ensure
			Result_set: feature_name.is_case_insensitive_equal (once "all") implies Result
		end

feature -- Access

	feature_name: STRING
			-- Feature name

	clients: ERT_CLIENT_SET
			-- Clients to which `feature_name' is exported

invariant
	feature_name_not_void: feature_name /= Void
	feature_name_not_empty: not feature_name.is_empty
	clients_not_void: clients /= Void

end
