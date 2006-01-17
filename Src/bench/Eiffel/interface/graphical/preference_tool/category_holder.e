indexing

	description:
		"Holder for the preference tool."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CATEGORY_HOLDER

inherit
	ISE_CMD_HOLDER
		redefine
			associated_button, associated_menu_entry
		end

create
	make, make_plain

feature {NONE} -- Initialization

	make (a_button: like associated_button; a_menu_entry: like associated_menu_entry) is
			-- Initialize Current.
		do
			associated_button := a_button;
			associated_menu_entry := a_menu_entry
		end;

feature -- Setting

	set_button (a_button: like associated_button) is
			-- Set `associated_button' to `a_button'.
		do
			associated_button := a_button
		end;

	set_menu_entry (a_menu_entry: like associated_menu_entry) is
			-- Set `associated_menu_entry' to `a_menu_entry'.
		do
			associated_menu_entry := a_menu_entry
		end;

	set_selected (selection: BOOLEAN) is
			-- Set both `associated_button' and `associated_menu_entry'
			-- to be selected or not, according `selection'.
		do
			if associated_button /= Void then
				associated_button.set_selected (selection)
			end;
			if associated_menu_entry /= Void then
				associated_menu_entry.set_selected (selection)
			end
		end

feature -- Properties

	associated_button: PREFERENCE_BUTTON;
			-- Button on the toolbar

	associated_menu_entry: PREFERENCE_TICKABLE_MENU_ENTRY;

feature {NONE} -- Useless

	make_plain is do end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class CATEGORY_HOLDER
