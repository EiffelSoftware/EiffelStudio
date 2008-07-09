indexing
	description: "[
		An exception to represent an unavailable dynamic API function or variable.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	DYNAMIC_API_UNAVAILABLE_EXCEPTION

inherit
	DEVELOPER_EXCEPTION
		redefine
			internal_meaning
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: ?like api_feature_name)
			-- Initializes a API unavailable exception with an API function or variable name.
			--
			-- `a_name': An API function or variable name.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
			api_feature_name ?= a_name
			set_message (once "dynamic feature unavailable")
		ensure
			api_feature_name_set: api_feature_name = a_name
		end

feature -- Access

	api_feature_name: !STRING
			-- The API feature name.

feature {NONE} -- Access

	internal_meaning: !STRING
			-- <Precursor>
		do
			create Result.make (40)
			Result.append ("The API function or variable `")
			Result.append (api_feature_name)
			Result.append ("' is not available.")
		ensure then
			not_result_is_empty: not Result.is_empty
		end

invariant
	not_api_feature_name: not api_feature_name.is_empty
	message_attached: message /= Void
	not_message_is_empty: not message.is_empty

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
