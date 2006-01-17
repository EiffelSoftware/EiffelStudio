indexing

	description:
		"Notion of a top shell used for creation of a %
		%tool as a form."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class EB_TOP_SHELL

inherit

	TOOLTIP_INITIALIZER;
	EB_SHELL
		undefine
			screen, top
		redefine
			implementation
		end;
	TOP_SHELL
		rename
			make as old_make
		redefine
			implementation
		end;
	WINDOWS;
	EB_CONSTANTS;
	SYSTEM_CONSTANTS

create
	make

feature -- Initialization

	make (an_id: INTEGER; a_screen: SCREEN) is
			-- Initialize Current.
		require
			valid_screen: a_screen /= Void
		do
			if Platform_constants.is_windows then
					-- For windows we need the id for the Icon
				old_make (an_id.out, a_screen)
			else
					-- For unix we need this for the X resource file
				old_make (Interface_names.n_X_resource_name, a_screen)
			end

			tooltip_initialize (Current)
			create associated_form.make ("", Current)
		ensure
			screen_set: equal (screen, a_screen)
		end

feature -- Properties

	associated_form: FORM
			-- Associated form

feature -- Display

	display is
			-- Show Current on the screen
		do
			if realized then
				show
			else
				realize
				tooltip_realize
			end
			raise
		end

feature {NONE} -- Implementation

	implementation: TOP_SHELL_I;

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

end -- class EB_TOP_SHELL
