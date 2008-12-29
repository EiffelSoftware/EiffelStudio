note
	description: "Metric path criterion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_PATH_CRITERION

inherit
	EB_METRIC_TEXT_CRITERION
		rename
			text as path,
			set_text as set_path
		redefine
			make,
			process,
			is_path_criterion
		end

create
	make

feature{NONE} -- Initialization

	make (a_scope: like scope; a_name: STRING)
			-- Initialize `scope' with `a_scope' and `name' with `a_name'.
		local
			l_platform: PLATFORM
		do
			create l_platform
			Precursor (a_scope, a_name)
			if l_platform.is_windows then
				disable_case_sensitive
			else
				enable_case_sensitive
			end
			set_matching_strategy ({QL_NAME_CRITERION}.identity_matching_strategy)
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		do
			a_visitor.process_path_criterion (Current)
		end

feature -- Status report

	is_path_criterion: BOOLEAN = True;
			-- Is current a path criterion?

note
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

end
