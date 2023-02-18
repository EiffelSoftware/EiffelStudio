note
	description:
		"Implementation for a GUI lookup interface which has direct access on EV_APPLICATION"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GUI_IMP

inherit
	GUI_I

feature -- Access

	application_under_test: EV_APPLICATION
			-- Application under test
		do
			Result := environment.application
		end

	screen: EV_SCREEN
			-- Screen
		once
			create Result
		end

	active_window: EV_WINDOW
			-- Active window

feature -- Element change

	set_active_window (a_window: like active_window)
			-- Set `active_window' to `a_window'.
		do
			active_window := a_window
		end

feature -- Window lookup

	window_by_identifier (an_identifier: READABLE_STRING_32): EV_WINDOW
			-- Window which has `an_identifier' as `identifier_name'.
		do
			Result ?= window ([an_identifier, Void])
		end

	windows_by_identifier (an_identifier: READABLE_STRING_32): LIST [EV_WINDOW]
			-- All windows which have `an_identifier' as `identifier_name'.
		do
			-- TODO: check if this cast is valid
			Result ?= windows ([an_identifier, Void])
		end

feature -- Identifiable lookup

	identifiable (a_pattern: READABLE_STRING_32): EV_IDENTIFIABLE
			-- Identifiable corresponding to `a_pattern'.
		local
--			l_tokens: LIST [READABLE_STRING_32]
--			l_token: READABLE_STRING_32
--			l_indirect: BOOLEAN

			l_list: LIST [EV_IDENTIFIABLE]
		do
			l_list := identifiables (a_pattern)
			if not l_list.is_empty then
				Result := l_list.first
			end

-- This algorithm is flawed in the case that it is greedy. As soon as it finds a path it will follow it
-- and stay on the path even if the end result will not be found this way. For example a search for:
-- 'a.b' will follow the first identifiable with name 'a' even if it does not have a child with name 'b'
-- and there exist a second identifiable with name 'a' which has a child with name 'b'.
-- Thus the current solution by searching for all and returning the first result is not the optimal
-- way but at least correct.
--	juliant, 22. November 2006

				-- check window syntax
--			l_tokens := a_pattern.split (':')
--			if l_tokens.count = 1 then
--				Result := active_window
--			elseif l_tokens.count = 2 then
--				Result := window (parse_info_token (l_tokens.first))
--			else
--				check
--					invalid_pattern: false
--				end
--			end
--				-- parse pattern
--			from
--				l_tokens := l_tokens.last.split ('.')
--				l_tokens.start
--				l_indirect := true
--			until
--				l_tokens.after or Result = Void
--			loop
--				l_token := l_tokens.item
--				if l_token.is_empty then
--						-- we have a double dot, hence the next child is a direct or indirect parent
--					check
--						indirect_not_set: not l_indirect -- three dots if l_indirect is alredy set and thus an invalid pattern
--					end
--					l_indirect := true
--				else
--						-- look for child
--					if l_indirect then
--						Result := identifiable_child_recursive (Result, parse_info_token (l_token))
--					else
--						Result := identifiable_child (Result, parse_info_token (l_token))
--					end
--					l_indirect := false
--				end
--				l_tokens.forth
--			end
		end

	identifiables (a_pattern: READABLE_STRING_32): LIST [EV_IDENTIFIABLE]
			-- All identifiablkes corresponding to `a_pattern.
		local
			l_active_elements: LIST [EV_IDENTIFIABLE]
			l_tokens: LIST [READABLE_STRING_32]
			l_token: READABLE_STRING_32
			l_token_info: TUPLE [name, type: READABLE_STRING_32]
			l_indirect: BOOLEAN
		do
				-- check window syntax
			l_tokens := a_pattern.split (':')
			if l_tokens.count = 1 then
				create {LINKED_LIST [EV_IDENTIFIABLE]}l_active_elements.make
				l_active_elements.extend (active_window)
			elseif l_tokens.count = 2 then
				l_active_elements := windows (parse_info_token (l_tokens.first))
			else
				check
					invalid_pattern: false	-- raise exception
				end
			end
				-- parse pattern
			from
				l_tokens := l_tokens.last.split ('.')
				l_tokens.start
				l_indirect := true
			until
				l_tokens.after or l_active_elements.count = 0
			loop
				l_token := l_tokens.item
				if l_token.is_empty then
						-- we have a double dot, hence the next child is a direct or indirect parent
					check
						indirect_not_set: not l_indirect -- three dots if l_indirect is alredy set and thus an invalid pattern
					end
					l_indirect := true
				else
						-- look for children of all active elements
					create {LINKED_LIST [EV_IDENTIFIABLE]}Result.make
					from
						l_token_info := parse_info_token (l_token)
						l_active_elements.start
					until
						l_active_elements.after
					loop
							-- Lookup next token with active elements
						if l_indirect then
							Result.append (identifiable_children_recursive (l_active_elements.item, l_token_info))
						else
							Result.append (identifiable_children (l_active_elements.item, l_token_info))
						end
						l_active_elements.forth
					end
					l_active_elements := Result
				end
				l_tokens.forth
			end
		end

feature {NONE} -- Implementation

	environment: EV_ENVIRONMENT
			-- Vision2 environment
		once
			create Result
		end

	children (an_identifiable: EV_IDENTIFIABLE): LINEAR [EV_IDENTIFIABLE]
			-- Linear representation of all direct children of `an_identifiable'.
		require
			an_identifiable_not_void: an_identifiable /= Void
		local
			l_window: EV_WINDOW
			l_container: EV_CONTAINER
			l_item_list: EV_ITEM_LIST [EV_ITEM]
			l_list: LINKED_LIST [EV_IDENTIFIABLE]
			l_linear: LINEAR [EV_IDENTIFIABLE]
		do
			l_window ?= an_identifiable
			if l_window = Void then
				l_container ?= an_identifiable
				if l_container = Void then
					l_item_list ?= an_identifiable
					if l_item_list = Void then
						create {LINKED_LIST [EV_IDENTIFIABLE]}Result.make
					else
						Result := l_item_list.linear_representation
					end
				else
					Result := l_container.linear_representation
				end
			else
				create l_list.make
				if l_window.menu_bar /= Void then
					l_list.extend (l_window.menu_bar)
				end
				l_linear := l_window.linear_representation
				l_linear.do_all (agent l_list.extend (?))
				Result := l_list
			end
		ensure
			result_not_void: Result /= Void
		end

	parse_info_token (a_token: READABLE_STRING_32): TUPLE [name, type: READABLE_STRING_32]
			-- Parse `a_token'.
		require
			a_token_not_void: a_token /= Void
			a_token_not_empty: not a_token.is_empty
		local
			l_brace_index: INTEGER
		do
			create Result
			l_brace_index := a_token.index_of ('}', 1)
			if l_brace_index > 0 then
				Result.type := a_token.substring (2, l_brace_index - 1)
				if l_brace_index /= a_token.count then
					Result.name := a_token.substring (l_brace_index+1, a_token.count)
				else
					Result.name := Void
				end
			else
				Result.name := a_token
				Result.type := Void
			end
		ensure
			result_not_void: Result /= Void
			result_has_name_or_type: Result.name /= Void or Result.type /= Void
		end

	matches_info (an_identifiable: EV_IDENTIFIABLE; an_info: TUPLE [name, type: READABLE_STRING_32]): BOOLEAN
			-- Does `an_identifiable' match `an_info's name and type?
		require
			an_identifiable_not_void: an_identifiable /= Void
			an_info_not_void: an_info /= Void
			a_name_or_a_type_set: an_info.name /= Void or an_info.type /= Void
			an_info_name_not_empty: an_info.name /= Void implies not an_info.name.is_empty
			an_info_type_not_empty: an_info.type /= Void implies not an_info.type.is_empty
		do
			-- TODO: regexp match of name
			if an_info.name /= Void and an_info.type /= Void then
				Result := an_identifiable.identifier_name.is_equal (an_info.name) and an_identifiable.generating_type.out.same_string_general (an_info.type)
			elseif an_info.name /= Void then
				Result := an_identifiable.identifier_name.is_equal (an_info.name)
			else
				check
					has_type: an_info.type /= Void
				end
				Result := an_identifiable.generating_type.out.same_string_general (an_info.type)
			end
		end

	window (an_info: TUPLE [name, type: READABLE_STRING_32]): EV_IDENTIFIABLE
			-- Window which has `a_name' and `a_type'
		require
			an_info_not_void: an_info /= Void
			a_name_or_a_type_set: an_info.name /= Void or an_info.type /= Void
			an_info_name_not_empty: an_info.name /= Void implies not an_info.name.is_empty
			an_info_type_not_empty: an_info.type /= Void implies not an_info.type.is_empty
		local
			l_windows: LIST [EV_IDENTIFIABLE]
		do
			l_windows := windows (an_info)
			if not l_windows.is_empty then
				Result := l_windows.first
			end
		end

	windows (an_info: TUPLE [name, type: READABLE_STRING_32]): LIST [EV_IDENTIFIABLE]
			-- Windows which have `a_name' and `a_type'
		require
			an_info_not_void: an_info /= Void
			a_name_or_a_type_set: an_info.name /= Void or an_info.type /= Void
			an_info_name_not_empty: an_info.name /= Void implies not an_info.name.is_empty
			an_info_type_not_empty: an_info.type /= Void implies not an_info.type.is_empty
		local
			l_windows: LINEAR [EV_WINDOW]
			l_window: EV_WINDOW
		do
			l_windows := application_under_test.windows
			from
				create {LINKED_LIST [EV_IDENTIFIABLE]}Result.make
				l_windows.start
			until
				l_windows.after
			loop
				l_window := l_windows.item
				if matches_info (l_window, an_info) then
					Result.extend (l_window)
				end
				l_windows.forth
			end
		ensure
			result_not_void: Result /= Void
		end

	identifiable_child (a_parent: EV_IDENTIFIABLE; an_info: TUPLE [name, type: READABLE_STRING_32]): EV_IDENTIFIABLE
			-- Child identifiable of `a_parent' which match `an_info's name and type
		require
			a_parent_not_void: a_parent /= Void
			an_info_not_void: an_info /= Void
			a_name_or_a_type_set: an_info.name /= Void or an_info.type /= Void
			an_info_name_not_empty: an_info.name /= Void implies not an_info.name.is_empty
			an_info_type_not_empty: an_info.type /= Void implies not an_info.type.is_empty
		local
			l_children: LINEAR [EV_IDENTIFIABLE]
			l_child: EV_IDENTIFIABLE
		do
			from
				l_children := children (a_parent)
				l_children.start
			until
				l_children.after or Result /= Void
			loop
				l_child := l_children.item
				if matches_info (l_child, an_info) then
					Result := l_child
				end
				l_children.forth
			end
		end

	identifiable_children (a_parent: EV_IDENTIFIABLE; an_info: TUPLE [name, type: READABLE_STRING_32]): LIST [EV_IDENTIFIABLE]
			-- All child identifiables of `a_parent' which match `an_info's name and type
		require
			a_parent_not_void: a_parent /= Void
			an_info_not_void: an_info /= Void
			a_name_or_a_type_set: an_info.name /= Void or an_info.type /= Void
			an_info_name_not_empty: an_info.name /= Void implies not an_info.name.is_empty
			an_info_type_not_empty: an_info.type /= Void implies not an_info.type.is_empty
		local
			l_children: LINEAR [EV_IDENTIFIABLE]
			l_child: EV_IDENTIFIABLE
		do
			from
				l_children := children (a_parent)
				l_children.start
				create {LINKED_LIST [EV_IDENTIFIABLE]}Result.make
			until
				l_children.after
			loop
				l_child := l_children.item
				if matches_info (l_child, an_info) then
					Result.extend (l_child)
				end
				l_children.forth
			end
		ensure
			result_not_void: Result /= Void
		end

	identifiable_child_recursive (a_parent: EV_IDENTIFIABLE; an_info: TUPLE [name, type: READABLE_STRING_32]): EV_IDENTIFIABLE
			-- Identifiable matching `an_info's name and type recursive searched starting at `a_parent'.
		require
			a_parent_not_void: a_parent /= Void
			an_info_not_void: an_info /= Void
			a_name_or_a_type_set: an_info.name /= Void or an_info.type /= Void
			an_info_name_not_empty: an_info.name /= Void implies not an_info.name.is_empty
			an_info_type_not_empty: an_info.type /= Void implies not an_info.type.is_empty
		local
			l_queue: QUEUE [EV_IDENTIFIABLE]
			l_item: EV_IDENTIFIABLE
		do
			from
				create {LINKED_QUEUE [EV_IDENTIFIABLE]}l_queue.make
				children (a_parent).do_all (agent l_queue.extend (?))
			until
				l_queue.is_empty or Result /= Void
			loop
				l_item := l_queue.item
				l_queue.remove
				if matches_info (l_item, an_info) then
					Result := l_item
				else
					children (l_item).do_all (agent l_queue.extend (?))
				end
			end
		end

	identifiable_children_recursive (a_parent: EV_IDENTIFIABLE; an_info: TUPLE [name, type: READABLE_STRING_32]): LIST [EV_IDENTIFIABLE]
			-- All identifiables matching `an_info's name and type recursive searched starting at `a_parent'.
		require
			a_parent_not_void: a_parent /= Void
			an_info_not_void: an_info /= Void
			a_name_or_a_type_set: an_info.name /= Void or an_info.type /= Void
			an_info_name_not_empty: an_info.name /= Void implies not an_info.name.is_empty
			an_info_type_not_empty: an_info.type /= Void implies not an_info.type.is_empty
		local
			l_queue: QUEUE [EV_IDENTIFIABLE]
			l_item: EV_IDENTIFIABLE
		do
			from
				create {LINKED_LIST [EV_IDENTIFIABLE]}Result.make
				create {LINKED_QUEUE [EV_IDENTIFIABLE]}l_queue.make
				children (a_parent).do_all (agent l_queue.extend (?))
			until
				l_queue.is_empty
			loop
				l_item := l_queue.item
				l_queue.remove

				if matches_info (l_item, an_info) then
					Result.extend (l_item)
				else
					children (l_item).do_all (agent l_queue.extend (?))
				end
			end
		ensure
			result_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
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

end
