indexing
	description: "Iterator that iterates through a configuration, looking only at objects that are enabled for the current platform/build."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CONDITIONED_ITERATOR

inherit
	CONF_VISITOR

	CONF_VALIDITY

	CONF_ITERATOR
		redefine
			process_target
		end

create
	make

feature {NONE} -- Initialization

	make (a_platform, a_build: INTEGER) is
			-- Create.
		require
			platform_valid: valid_platform (a_platform)
			build_valid: valid_build (a_build)
		do
			platform := a_platform
			build := a_build
		end

feature -- Access

	platform: INTEGER
			-- The current platform.

	build: INTEGER
			-- The current build.

feature -- Visit nodes

	process_target (a_target: CONF_TARGET) is
			-- Visit `a_target'.
		local
			l_pre: CONF_PRECOMPILE
		do
			l_pre := a_target.precompile
			if l_pre /= Void and then l_pre.is_enabled (platform, build) then
				a_target.precompile.process (Current)
			end
			a_target.libraries.linear_representation.do_if (agent {CONF_LIBRARY}.process (Current), agent {CONF_LIBRARY}.is_enabled (platform, build))
			a_target.assemblies.linear_representation.do_if (agent {CONF_ASSEMBLY}.process (Current), agent {CONF_ASSEMBLY}.is_enabled (platform, build))
			a_target.clusters.linear_representation.do_if (agent {CONF_CLUSTER}.process (Current), agent {CONF_CLUSTER}.is_enabled (platform, build))
				-- overrides must be processed at the end
			a_target.overrides.linear_representation.do_if (agent {CONF_OVERRIDE}.process (Current), agent {CONF_OVERRIDE}.is_enabled (platform, build))
		end

end
