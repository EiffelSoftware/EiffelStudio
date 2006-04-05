indexing
	description	: "All information about the wizard ... This class is inherited in each state "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "David Solal / Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_INFORMATION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize.
		do
		end

feature -- Access

	location: STRING
		-- location of the project

	l_to_precompile: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
		-- list of library to precompile

	l_precompilable: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW]
		-- list of library that can be precompile

feature -- Element change

	set_location (s: STRING) is
		do
			location:= s
		end

	set_l_to_precompile (l: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW]) is
		do
			l_to_precompile:= l
		end

	set_l_precompilable (l: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW]) is
		do
			l_precompilable:= l
		end

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
end -- class WIZARD_INFORMATION
