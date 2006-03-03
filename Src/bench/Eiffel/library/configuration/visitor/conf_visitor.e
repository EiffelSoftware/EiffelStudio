indexing
	description: "Visitor to visit configuration."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_VISITOR

feature -- Status

	is_error: BOOLEAN
			-- Was there an error?

	last_errors: LINKED_LIST [CONF_ERROR]
			-- The last error.

feature -- Visit nodes

	process_system (a_system: CONF_SYSTEM) is
			-- Visit `a_system'.
		deferred
		end

	process_target (a_target: CONF_TARGET) is
			-- Visit `a_target'.
		deferred
		end

	process_group (a_group: CONF_GROUP) is
			-- Visit `a_group'.
		deferred
		end

	process_assembly (an_assembly: CONF_ASSEMBLY) is
			-- Visit `an_assembly'.
		deferred
		end

	process_library (a_library: CONF_LIBRARY) is
			-- Visit `a_library'.
		deferred
		end

	process_precompile (a_precompile: CONF_PRECOMPILE) is
			-- Visit `a_precompile'.
		deferred
		end

	process_cluster (a_cluster: CONF_CLUSTER) is
			-- Visit `a_cluster'.
		deferred
		end

	process_override (an_override: CONF_OVERRIDE) is
			-- Visit `an_override'.
		deferred
		end

feature {NONE} -- Implementation

	add_error (an_error: CONF_ERROR) is
			-- Set `an_error'.
		require
			an_error_not_void: an_error /= Void
		do
			if not is_error then
				is_error := True
				create last_errors.make
			end
			last_errors.extend (an_error)
		end


end
