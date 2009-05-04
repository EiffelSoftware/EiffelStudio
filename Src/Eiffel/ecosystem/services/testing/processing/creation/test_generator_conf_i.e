note
	description: "[
		Interface defining configuration options for AutoTest.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_GENERATOR_CONF_I

inherit
	TEST_CREATOR_CONF_I

feature -- Access

	types: attached DS_LINEAR [attached STRING]
			-- Names of classes to be tested
		require
			usable: is_interface_usable
		deferred
		end

	time_out: NATURAL
			-- Time in minutes used for testing.
			--
			-- Note: if zero, default will be used.
		require
			usable: is_interface_usable
		deferred
		end

	test_count: NATURAL
			-- Maximum number of tests that will be executed.
			--
			-- Note: if zero, no restriction will be applied.
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

	is_debugging: BOOLEAN
			-- Should debugging output be printed to log?
		require
			usable: is_interface_usable
		deferred
		end

end
