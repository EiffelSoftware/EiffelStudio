indexing
	description: "[
		The default EiffelSoftware Eiffel Documentation help provider.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	EIFFEL_DOC_HELP_PROVIDER

inherit
	WEB_HELP_PROVIDER
		redefine
			section_url_separator,
			format_context
		end

create
	default_create,
	make -- Use to access page title, if needed!

feature -- Access

	document_protocol: !STRING_32
			-- <Precursor>
		once
			create Result.make_empty
			Result.append ("eiffeldoc")
		end

	document_description: !STRING_32
			-- <Precursor>
		once
			create Result.make_empty
			Result.append ("Eiffel Documentation")
		end

feature {NONE} -- Access

	base_url: !STRING
			-- <Precursor>
		once
			create Result.make_from_string ("http://docs.eiffel.com/isedoc/uuid/")
		end

	section_url_separator: CHARACTER
			-- <Precursor>
		once
			Result := '/'
		end

feature {NONE} -- Formatting

	format_context (a_context: !STRING_GENERAL): !STRING
			-- <Precursor>
		local
			l_count, i: INTEGER
		do
			create Result.make_from_string (a_context.as_string_8)
			l_count := Result.count
			from i := 1 until i > l_count loop
				if Result.item (i).is_space then
					Result.put ('-', i)
				end
				i := i + 1
			end
		end

;indexing
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
