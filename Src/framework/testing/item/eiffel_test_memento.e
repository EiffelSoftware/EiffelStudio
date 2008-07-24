indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_MEMENTO

inherit
	EIFFEL_TEST_MEMENTO_I

create {EIFFEL_TEST}
	make

feature {NONE} -- Initialization

	make (a_test: EIFFEL_TEST) is
			-- Initialize `Current'
		do
			added_tags := a_test.new_hash_set
			removed_tags := a_test.new_hash_set
		end

feature -- Access

	outcome_added: BOOLEAN
			-- <Precursor>

	execution_status_changed: BOOLEAN
			-- <Precursor>

	added_tags: !DS_HASH_SET [!STRING]
			-- <Precursor>

	removed_tags: !DS_HASH_SET [!STRING]

feature -- Status report

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature {EIFFEL_TEST} -- Status change

	set_outcome_added is
			-- Set `outcome_added' to True.
		do
			outcome_added := True
		end

	set_execution_status_changed is
			-- Set `execution_status_changed' to True
		do
			execution_status_changed := True
		end

end
