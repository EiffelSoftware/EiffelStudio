indexing
	description: "Flags used to create instance of COR_RUNTIME_HOST."
	date: "$Date$"
	revision: "$Revision$"

class
	CLR_HOST_STARTUP_FLAGS

feature -- Access

	concurrent_gc: INTEGER is 0x1
			-- Specifies that concurrent garbage collection should be used.
			-- Note: If the caller asks for the server build and concurrent
			-- garbage collection on a single-processor machine, the workstation
			-- build and non-concurrent garbage collection is run instead.

	single_domain: INTEGER is 0x2
			-- No assemblies are loaded as domain-neutral.

	multi_domain: INTEGER is 0x4
			-- All assemblies are loaded as domain-neutral.

	multi_domain_host: INTEGER is 0x6
			-- All strong-named assemblies are loaded as domain-neutral.

	safemode: INTEGER is 0x10
			-- Specifies that the exact version of the common language
			-- runtime passed will be loaded. The shim does not evaluate
			-- policy to determine the latest compatible version.

	setpreference: INTEGER is 0x100
			-- ???

feature -- Mask

	optimization_mask: INTEGER is 0x6
			-- Mask for single_domain, multi_domain and multi_domain_host.

end -- class CLR_HOST_STARTUP_FLAGS
