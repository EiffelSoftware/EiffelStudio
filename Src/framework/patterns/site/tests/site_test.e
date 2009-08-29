note
	description: "[

		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SITE_TEST

inherit
	EQA_TEST_SET

feature -- Tests

	test_is_valid_site
		note
			testing: "covers/{SITE}.is_valid_site"
		local
			l_basic_interface: SITE_TEST_INTERFACE_BASIC
			l_object: SITE_TEST_OBJECT
			l_validation_interface: SITE_TEST_VALIDATION_INTERFACE
			l_validation_object: SITE_TEST_VALIDATION_OBJECT
		do
				--	
				-- Test validity of a siteable object using rundimentary implementation.
				--
			create l_basic_interface
				-- Using a void-site object.
			assert ("Void should not be a valid site object", not l_basic_interface.is_valid_site (Void))

				-- Using site objects with a rudimentary siteable object (valid by default.)
			create l_object
			assert ("Default validation should indicate the site is valid", l_basic_interface.is_valid_site (l_object))

				--
				-- Test validity of a sitea object that has state to indicate validity.
				--
			create l_validation_interface

				-- Using incompatible site objects.
			assert ("Incompatible site objects should indicate they are invalid", not l_validation_interface.is_valid_site (l_object))

				-- Using a invalid site object.
			create l_validation_object
			assert ("Invalid site object not reported correctly", not l_validation_interface.is_valid_site (l_validation_object))

				-- Using a valid site object.
			l_validation_object.is_valid_object := True
			assert ("Valid site object not reported correctly", l_validation_interface.is_valid_site (l_validation_object))
		end

	test_set_site
		note
			testing: "covers/{SITE}.site", "covers/{SITE}.set_site", "covers/{SITE}.is_sited"
		local
			l_basic_interface: SITE_TEST_INTERFACE_BASIC
			l_object: SITE_TEST_OBJECT
		do
				-- Test defaults
			create l_basic_interface
			assert ("Default site should be Void", l_basic_interface.site = Void)
			assert ("Default site should not indicate is_sited", not l_basic_interface.is_sited)

				-- Test setting a basic object
			create l_object
			l_basic_interface.site := l_object
			assert ("Sited site should be set", l_basic_interface.site = l_object)
			assert ("Sited site should indicate is_sited", l_basic_interface.is_sited)

				-- Test unsiting
			l_basic_interface.site := Void
			assert ("Unsited site should be Void", l_basic_interface.site = Void)
			assert ("Unsited site should not indicate is_sited", not l_basic_interface.is_sited)
		end

	test_on_sited
		do

		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
