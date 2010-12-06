note
	description: "When breakpoint hits reset hit count of set of breakpoints..."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BREAKPOINT_WHEN_HITS_ACTION_RESET_HIT_COUNT

inherit
	BREAKPOINT_WHEN_HITS_ACTION_WITH_TAGS_I

create
	make,
	make_with_string_tags

feature {NONE} -- Initialization

	make (a_tags: ARRAY [STRING_32])
		do
			set_tags (a_tags)
		end

	make_with_string_tags (a_string_tags: STRING_32)
		do
			set_tags_from_string (a_string_tags)
		end

feature -- Persistence

	is_persistent: BOOLEAN = True
			-- <Precursor>
			
feature -- Execute

	execute (a_bp: BREAKPOINT; a_dm: DEBUGGER_MANAGER)
		local
			lst: LIST [BREAKPOINT]
			bp: BREAKPOINT
		do
			lst := a_dm.breakpoints_manager.breakpoints_tagged (tags, True)
			if lst /= Void and then not lst.is_empty then
				from
					lst.start
				until
					lst.after
				loop
					bp := lst.item_for_iteration
					if bp /= Void then
						bp.reset_hits_count
					end
					lst.forth
				end
				a_dm.breakpoints_manager.notify_breakpoints_changes
			end
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
