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

	SHARED_EXECUTION_ENVIRONMENT
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

	auto_test_dirname: PATH
			-- Directory where AutoTest has been installed.
		do
			Result := eiffel_layout.auto_test_path
		ensure
			directory_not_void: Result /= Void
		end

	runtime_dirname: PATH
			-- Directory where runtime files are stored
		once
			if attached execution_environment.item ("ERL_G") as l_erlg then
				create Result.make_from_string (l_erlg)
				Result := Result.extended ("library")
			else
				Result := auto_test_dirname
			end
			Result := Result.extended ("runtime")
		ensure
			directory_not_void: Result /= Void
		end

	image_dirname: PATH
			-- Directory where images are stored
		do
			Result := auto_test_dirname.extended ("image")
		ensure
			dirname_not_void: Result /= Void
		end

	misc_dirname: PATH
			-- Directory where miscelaneous files are stored
		do
			Result := auto_test_dirname.extended ("misc")
		ensure
			dirname_not_void: Result /= Void
		end

	misc_html_dirname: PATH
			-- Directory where miscelaneous files are stored
		do
			Result := misc_dirname.extended ("html")
		ensure
			dirname_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	auto_test_key_name: STRING = "HKEY_LOCAL_MACHINE\software\AutoTest"
			-- Name of AutoTest key

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
