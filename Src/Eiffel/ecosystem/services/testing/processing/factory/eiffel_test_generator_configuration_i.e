indexing
	description: "[
		Interface defining configuration options for AutoTest.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_GENERATOR_CONFIGURATION_I

inherit
	EIFFEL_TEST_CONFIGURATION_I

feature -- Access

	types: !DS_LINEAR [!STRING]
			-- Names of classes to be tested
		require
			usable: is_interface_usable
		deferred
		end

	time_out: NATURAL
			-- Time in minutes used for testing.
			--
			-- Note: is zero, default will be used.
		require
			usable: is_interface_usable
		deferred
		end

	proxy_time_out: NATURAL
			-- Time in seconds used by proxy to wait for a feature to execute.
			--
			-- Note: if zero, default will be used.
		require
			usable: is_interface_usable
		deferred
		end

	seed: NATURAL
			-- Seed for random number generation.
			--
			-- Note: if zero, current time will be used to generate random numbers.
		require
			usable: is_interface_usable
		deferred
		end

feature -- Status report

	is_benchmarking: BOOLEAN
			-- Log timeing information (usefull for assessing efficiency)
		require
			usable: is_interface_usable
		deferred
		end

	is_slicing_enabled: BOOLEAN
			-- Is slicing enabled?
		require
			usable: is_interface_usable
		deferred
		end

	is_ddmin_enabled: BOOLEAN
			-- Is ddmin enabled?
		require
			usable: is_interface_usable
		deferred
		end

	is_html_output: BOOLEAN
			-- Output statistics as html?
		require
			usable: is_interface_usable
		deferred
		end

end
