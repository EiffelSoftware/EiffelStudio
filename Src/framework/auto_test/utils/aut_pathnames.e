note

	description:

		"Common pathnames"

	library: "AutoTest Library"
	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_PATHNAMES

inherit
	ANY

	AUT_SHARED_REGISTRY
		export {NONE} all end

	KL_SHARED_EXECUTION_ENVIRONMENT
		export {NONE} all end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create

	make

feature {AUT_SHARED_PATHNAMES}

	make
			-- Create new object.
		do
		end

feature -- Directory names

	auto_test_dirname: STRING
			-- Directory where AutoTest has been installed.
			-- First the registry (if available) will be queried for the dirname
			-- then the ${AUTO_TEST} environment variable will be used.
			-- If no other information is available, the current directly will be assumed.
		once
			Result := eiffel_layout.auto_test_path
--			if registry.is_available then
--				Result := registry.string_value (auto_test_key_name + "\AUTO_TEST")
--			end
--			if Result = Void then
--				Result := execution_environment.variable_value ("AUTO_TEST")
--			end
--			if Result = Void then
--				Result := ""
--			end
		ensure
			directory_not_void: Result /= Void
		end

	runtime_dirname: STRING
			-- Directory where runtime files are stored
		once
			Result := execution_environment.variable_value ("ERL_G")
			if Result /= Void then
				Result := file_system.nested_pathname (Result, <<"library", "runtime">>)
			else
				Result := file_system.pathname (auto_test_dirname, "runtime")
			end
		ensure
			directory_not_void: Result /= Void
		end

	image_dirname: STRING
			-- Directory where images are stored
		do
			Result := file_system.pathname (auto_test_dirname, "image")
		ensure
			dirname_not_void: Result /= Void
		end

	misc_dirname: STRING
			-- Directory where miscelaneous files are stored
		do
			Result := file_system.pathname (auto_test_dirname, "misc")
		ensure
			dirname_not_void: Result /= Void
		end

	misc_html_dirname: STRING
			-- Directory where miscelaneous files are stored
		do
			Result := file_system.pathname (misc_dirname, "html")
		ensure
			dirname_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	auto_test_key_name: STRING = "HKEY_LOCAL_MACHINE\software\AutoTest"
			-- Name of AutoTest key

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
