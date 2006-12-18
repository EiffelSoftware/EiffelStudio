indexing
	description: "TTY menu."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	TTY_MENU

create
	make

feature {NONE} -- Initialization

	make (a_title: STRING) is
			-- Initialization
		require
			a_title /= Void
		do
			set_title (a_title)
			create entries.make (0)
			create enter_actions
			create quit_actions
			last_entry_index := 0
		end

feature -- Properties

	title: STRING
			-- Title of Current menu.

	enter_actions: ACTION_SEQUENCE [TUPLE]
			-- Action to be called when entering the menu.

	quit_actions: ACTION_SEQUENCE [TUPLE]
			-- Action to be called when quitting the menu.

feature -- Change

	set_title (s: STRING) is
			-- Set menu's title
		require
			s /= Void
		do
			title := s.twin
		end

	add_entry (a_abr: STRING; a_text: STRING; a_action: like action_from) is
			-- Add a new entry
		do
			add_conditional_entry (a_abr, a_text, a_action, Void)
		end

	add_conditional_entry (a_abr: STRING; a_text: STRING; a_action: like action_from; a_cond: FUNCTION [ANY, TUPLE, BOOLEAN]) is
			-- Add a new entry with condition
			-- the entry will be display only if the `a_cond' is satisfied.
		local
			l_abr: STRING
		do
			last_entry_index := last_entry_index + 1
			l_abr := a_abr
			if l_abr = Void then
				l_abr := last_entry_index.out
			end
			entries.force ([last_entry_index, l_abr, a_text, a_action, a_cond])
		end

	add_quit_entry (a_abr, a_text: STRING) is
			-- Add a quit entry
		do
			add_entry (a_abr, a_text, agent quit)
		end

	add_separator (a_text: STRING) is
			-- Add a new entry as a separator
		do
			entries.force ([0, Void, a_text, Void, Void])
		end

feature -- Access

	execute (a_display_entry: BOOLEAN) is
			-- Execute the menu
		local
			menu_shown: BOOLEAN
			menu_asked: BOOLEAN
			retried: BOOLEAN
			e: like entry
		do
			menu_asked := a_display_entry

			if not retried then
				enter_actions.call (Void)
			end
			from
				leave := False
			until
				leave
			loop
				if menu_asked then
					if menu_shown = False then
						display_menu
						menu_shown := True
					end
					print ("  -> ")
				end
				e := get_entry
				if e /= Void then
					if e.action /= Void then
						if entry_enabled (e) then
							e.action.call (Void)
						else
							io.put_string ("  -> Entry disabled %N")
						end
					end
					menu_shown := False
				else
					menu_asked := True
				end
			end
			quit_actions.call (Void)
		rescue
			retried := True
			retry
		end

	quit is
		do
			leave := True
		end

feature {NONE} -- Implementation

	leave: BOOLEAN
			-- Leave when possible.

	action_from (t: like entry): PROCEDURE [ANY, TUPLE] is
			-- Menu action for entry `t'.
		require
			t /= Void
		do
			Result := t.action
		end

	entry_enabled (a_entry: like entry): BOOLEAN is
			-- Is `a_entry' enabled (depending of the condition) ?
		do
			Result := a_entry.cond = Void or else a_entry.cond.item (Void)
		end

	entry (a_index: INTEGER; a_abr: STRING): TUPLE [index:INTEGER; abrev: STRING; text: STRING; action: PROCEDURE [ANY, TUPLE]; cond: FUNCTION [ANY, TUPLE, BOOLEAN]] is
			-- Entry indexed by `a_index'.
		local
			lst: like entries
		do
			lst := entries
			if a_index > 0 then
				from
					lst.start
				until
					lst.after or Result /= Void
				loop
					if lst.item.index = a_index then
						Result := lst.item
					end
					lst.forth
				end
			elseif a_abr /= Void then
				from
					lst.start
				until
					lst.after or Result /= Void
				loop
					if string_started_by (a_abr, lst.item.abrev) then
						Result := lst.item
					end
					lst.forth
				end
			end
		end

	last_entry_index: INTEGER

	entries: ARRAYED_LIST [like entry]
			-- Menu's choices.

feature {NONE} -- Answers implementation

	get_entry: like entry is
			-- return entry according to user answer.
		local
			s: STRING
			i: INTEGER
		do
			io.read_line
			s := io.last_string
			if s.is_integer then
				i := s.to_integer
				Result := entry (i, Void)
			elseif s.is_empty then
				Result := Void
			else
				Result := entry (0, s)
			end
		end

	string_started_by (s: STRING; a_prefix: STRING): BOOLEAN is
			-- Is string `s' started by `a_prefix' string ?
			-- (first blanks are ignored)
		require
			s /= Void
		local
			i,j: INTEGER
		do
			if a_prefix /= Void and then s.count >= a_prefix.count then
				from
					i := 1
					j := 1
					Result := True
				until
					not Result or j > a_prefix.count
				loop

					if s.item (i) /= ' ' then
						Result := s.item (i).as_lower = a_prefix.item (j).as_lower
						j := j + 1
					end
					i := i + 1
				end
			end
		end

	display_menu is
			-- Display menu
		local
			item: like entry
			l_title: STRING
		do
			io.put_string (title)
			io.put_new_line

			from
				entries.start
			until
				entries.off
			loop
				item := entries.item
				if entry_enabled (item) then
					l_title := item.text
					if l_title /= Void and then not l_title.is_empty then
						if item.abrev = Void and item.action = Void then
							io.put_string ("      ")
						else
							io.put_string ("  (")
							if item.abrev /= Void and then not item.abrev.is_empty then
								io.put_string (item.abrev)
							else
								io.put_integer (item.index)
							end
							io.put_string (") ")
						end
						io.put_string (l_title)
						io.put_new_line
					end
				end
				entries.forth
			end
--			io.put_string ("  (0) Quit%N")
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

end
