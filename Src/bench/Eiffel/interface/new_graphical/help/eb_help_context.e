indexing
	description: "$EiffelGraphicalCompiler$ help context sent to help engine%
				%Made of a URL and a base address.%
				%The URL is relative to the base address."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	EB_HELP_CONTEXT

inherit
	EV_HELP_CONTEXT

	EB_HELP_CONTEXTS_BASES
		export
			{NONE} all
		end

create
	make,
	make_absolute

feature {NONE} -- Initialization

	make (a_base_id: INTEGER; a_url: STRING) is
			-- Set `url' with concatenation of base URL identified by `a_base_id' and `a_url'.
			-- See `EB_HELP_CONTEXTS_BASES' for valid `a_base_id' values.
		require
			valid_url: is_valid_url (a_url)
			valid_base: is_valid_base_id (a_base_id)
		do
			url := base_url (a_base_id) + a_url
		end
			
	make_absolute (a_url: STRING) is
			-- Set `url' with `a_url'.
		require
			valid_url: is_valid_url (a_url)
		do
			url := a_url
		ensure
			url_set: url.is_equal (a_url)
		end

feature -- Access

	url: STRING
			-- URL of corresponding HTML file

invariant

	valid_url: is_valid_url (url)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class EB_HELP_CONTEXT