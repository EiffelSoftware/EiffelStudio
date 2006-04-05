indexing
	description: "A picture color button whose borders are drawn %
				% when the mouse pointer enter the button."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ACTIVE_PICT_COLOR_B

inherit
	PICT_COLOR_B
		redefine
			create_ev_widget, implementation
		end

create
	make, make_unmanaged

feature

	create_ev_widget (a_name: STRING;  a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a draw button with `a_name' as identifier
			-- and `a_parent' as parent.
		do
			depth := a_parent.depth + 1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			create implementation.make (Current, a_parent, man);
			implementation.set_widget_default;
			set_active (True)
			set_default
		end

feature -- Status

	active: BOOLEAN is
			-- Is button active? 
			--| False means it will be like a PICT_COLOR_B
		do
			Result := implementation.active
		end

feature -- Update

	set_active (flag: BOOLEAN) is
			-- Set `active' to `flag'.
			--| True means that the button will react to the mouse_enter
			--| and mouse_leave events. False means it will behave like
			--| a PICT_COLOR_B.
		do
			implementation.set_active (flag)
		end

feature {NONE} -- Implementation

	implementation: ACTIVE_PICT_COLOR_B_IMP;
		-- Implementation class

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

end -- class ACTIVE_BORDER_PICT_COLOR_B
