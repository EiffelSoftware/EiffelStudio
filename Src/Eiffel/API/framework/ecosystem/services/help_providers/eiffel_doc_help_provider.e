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
			format_context
		end

create
	default_create,
	make -- Use to access page title, if needed!

feature -- Access

	document_protocol: !STRING_32
			-- Document protocol used by a URI to navigate to the help accessible from the provider.
		once
			create Result.make_empty
			Result.append ("eiffeldoc")
		end

	document_description: !STRING_32
			-- Document short description
		once
			create Result.make_empty
			Result.append ("Eiffel Documentation")
		end

feature {NONE} -- Access

	base_url: !STRING_8
			-- Base URL used to locate help documentation.
		once
			create Result.make_from_string ("http://ise181.ise/book/documentation/")
		end

feature -- Helpers

	id_map: !EIFFEL_DOC_ID_MAP
			-- Access to the Eiffel IDs map
		once
			create Result
		end

feature {NONE} -- Formatting

	format_context (a_context: !STRING_GENERAL): !STRING_8
			-- Formats the context so it may be used in a URL.
			--
			-- `a_context': A help content context of session context identifier to format
			-- `Result': A formatted help context for a URL
		local
			l_count, i: INTEGER
			l_context: ?STRING
		do
			l_context := id_map[a_context]
			if l_context /= Void then
				create Result.make_from_string (l_context)
				l_count := Result.count
				from i := 1 until i > l_count loop
					if Result.item (i) = ' ' then
						Result.put ('_', i)
					end
					i := i + 1
				end
			end
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
