note
	description: "[
		Object representing a cluster which is intended to contain classes specifically for testing.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_TEST_CLUSTER

inherit
	CONF_CLUSTER
		redefine
			is_test_cluster,
			process
		end

create {CONF_PARSE_FACTORY}
	make

feature -- Status report

	is_test_cluster: BOOLEAN
			-- <Precursor>
		once
			Result := True
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR)
			-- Process `a_visitor'
		do
			a_visitor.process_test_cluster (Current)
			Precursor (a_visitor)
		end

end
