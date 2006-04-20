indexing
	description: "Notion of a toolbar that can be added to and %
			%removed from the user interface."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	TOOLBAR

inherit
	FORM

	COMMAND_W

create
	make

feature -- Initialization

	init_toggle (toggle: TOGGLE_B) is
			-- Init arm action.
		do
			associated_toggle := toggle;
			toggle.add_activate_action (Current, Void);
			toggle.set_toggle_on
		end;

feature -- Access

	associated_toggle: TOGGLE_B;
			-- associated toggle button with toolbar

feature -- User Interface

	add is
		do
			manage_separator (True);
			manage;
			parent.unmanage; -- Shake it (for HP)
			parent.manage;
			associated_toggle.set_toggle_on
		end;

	remove is
		do
			manage_separator (False);
			unmanage;
			parent.unmanage; -- Shake it (for HP)
			parent.manage; 
			associated_toggle.set_toggle_off
		end;

feature {NONE} -- Execution

	work (argument: ANY) is
		do
			if associated_toggle.state then
				add
			else
				remove
			end;
		end

feature {NONE} -- Implementation

	manage_separator (b: BOOLEAN) is
			-- Find the right separator (ie. below Current if
			-- Current is not the lowest toolbar, or else above Current).
		local
			s: SEPARATOR;
			sibs: ARRAYED_LIST [WIDGET];
		do
			sibs := parent.children;
				-- sibs are in reverse order of creation
			from
				sibs.start
			until
				sibs.item = Current or else sibs.after
			loop
				sibs.forth
			end;
			if not sibs.after then
				sibs.forth
				s ?= sibs.item
					--| Can fail since a toolbar doesn't always have a SEPARATOR
				if s /= Void then
					if b then
						s.manage
					else
						s.unmanage
					end
				end
			end
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

end -- class TOOLBAR
