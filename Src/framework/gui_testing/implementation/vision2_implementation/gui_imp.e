indexing
	description:
		"Implementation for a GUI lookip interface which has direct access on EV_APPLICATION"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GUI_IMP

inherit
	GUI_I

feature -- Access

	application_under_test: EV_APPLICATION is
			-- Application under test
		do
			Result := environment.application
		end

	screen: EV_SCREEN is
			-- Screen
		once
			create Result
		end

	active_window: EV_WINDOW
			-- Active window

feature -- Element change

	set_active_window (a_window: like active_window) is
			-- Set `active_window' to `a_window'.
		do
			active_window := a_window
		end

feature -- Identifiable lookup

	window_by_identifier (an_identifier: STRING): EV_WINDOW is
			-- Window which has `an_identifier' as `identifier_name'.
		local
			l_windows: LINEAR [EV_WINDOW]
		do
			l_windows := application_under_test.windows
			from
				l_windows.start
			until
				l_windows.after or Result /= Void
			loop
				-- TODO: regexp match
				if an_identifier.is_equal (l_windows.item.identifier_name) then
					Result := l_windows.item
				end
				l_windows.forth
			end
		end

	windows_by_identifier (an_identifier: STRING): LIST [EV_WINDOW] is
			-- All windows which have `an_identifier' as `identifier_name'.
		local
			l_windows: LINEAR [EV_WINDOW]
		do
			l_windows := application_under_test.windows
			from
				create {LINKED_LIST [EV_WINDOW]}Result.make
				l_windows.start
			until
				l_windows.after
			loop
				-- TODO: regexp match
				if an_identifier.is_equal (l_windows.item.identifier_name) then
					Result.extend (l_windows.item)
				end
				l_windows.forth
			end
		end

	identifiable (a_parent: EV_IDENTIFIABLE; an_identifier: STRING): EV_IDENTIFIABLE is
			-- Identifiable corresponding to `an_identifier' in `a_parent'.
		local
			l_children: LINEAR [EV_IDENTIFIABLE]
		do
			from
				l_children := children (a_parent)
				l_children.start
			until
				l_children.after or Result /= Void
			loop
				-- TODO: regexp match
				if an_identifier.is_equal (l_children.item.identifier_name) then
					Result := l_children.item
				end
				l_children.forth
			end
		end

	identifiables (a_parent: EV_IDENTIFIABLE; an_identifier: STRING): LIST [EV_IDENTIFIABLE] is
			-- All identifiables which correspond to `an_identifier' in `a_parent'.
		local
			l_children: LINEAR [EV_IDENTIFIABLE]
		do
			from
				l_children := children (a_parent)
				l_children.start
				create {LINKED_LIST [EV_IDENTIFIABLE]}Result.make
			until
				l_children.after
			loop
				-- TODO: regexp match
				if an_identifier.is_equal (l_children.item.identifier_name) then
					Result.extend (l_children.item)
				end
				l_children.forth
			end
		end

	identifiable_recursive (a_parent: EV_IDENTIFIABLE; an_identifier: STRING): EV_IDENTIFIABLE is
			-- Identifiable corresponding to `an_identifier' recursive searched starting at `a_parent'.
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

				-- TODO: regexp match
				if an_identifier.is_equal (l_item.identifier_name) then
					Result := l_item
				else
					children (l_item).do_all (agent l_queue.extend (?))
				end
			end
		end

	identifiables_recursive (a_parent: EV_IDENTIFIABLE; an_identifier: STRING): LIST [EV_IDENTIFIABLE] is
			-- All identifiables corresponding to `an_identifier' recursive searched starting at `a_parent'.
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

				-- TODO: regexp match
				if an_identifier.is_equal (l_item.identifier_name) then
					Result.extend (l_item)
				else
					children (l_item).do_all (agent l_queue.extend (?))
				end
			end
		end

feature {NONE} -- Implementation

	environment: EV_ENVIRONMENT is
			-- Vision2 environment
		once
			create Result
		end

	children (an_identifiable: EV_IDENTIFIABLE): LINEAR [EV_IDENTIFIABLE] is
			-- Linear representation of all children of `an_identifiable'.
		require
			an_identifiable_not_void: an_identifiable /= Void
		local
			l_window: EV_WINDOW
			l_container: EV_CONTAINER
			l_item_list: EV_ITEM_LIST [EV_ITEM]
			l_list: LINKED_LIST [EV_IDENTIFIABLE]
			l_linear: LINEAR [EV_IDENTIFIABLE]
		do
			l_container ?= an_identifiable
			if l_container = Void then
				l_item_list ?= an_identifiable
				if l_item_list = Void then
					l_window ?= an_identifiable
					if l_window = Void then
						create {LINKED_LIST [EV_IDENTIFIABLE]}Result.make
					else
						create l_list.make
						l_list.extend (l_window.menu_bar)
						l_list.extend (l_window.upper_bar)
						l_linear := l_window.linear_representation
						l_linear.do_all (agent l_list.extend (?))
						l_list.extend (l_window.lower_bar)
						Result := l_list
					end
				else
					Result := l_item_list.linear_representation
				end
			else
				Result := l_container.linear_representation
			end
		ensure
			result_not_void: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
