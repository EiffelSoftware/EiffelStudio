note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	testing:  "covers/{DIFF}"

class
	BRIDGE_TEST

inherit
	EQA_TEST_SET

feature {NONE} -- Access

	bridged_interface: BRIDGE_TEST_INTERFACE
			-- Test object.
		once
			create Result
		end

feature -- Test routines

	test
			-- Ensure a patch is generated correctly for insertion.
		note
			testing: "covers/{BRIDGE}.bridge", "covers/{BRIDGE}.new_bridge"
		do
			if {PLATFORM}.is_windows then
				assert ("Expected Windows name", bridged_interface.name ~ {BRIDGE_TEST_INTERFACE}.windows_name)
			elseif {PLATFORM}.is_unix then
				assert ("Expected Unix name", bridged_interface.name ~ {BRIDGE_TEST_INTERFACE}.unix_name)
			else
				check unsupported: False end
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

