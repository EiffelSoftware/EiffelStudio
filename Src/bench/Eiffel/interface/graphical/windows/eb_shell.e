indexing
	description: "Abstract notion of a shell for EiffelBench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class EB_SHELL

inherit
	COMPOSITE

feature -- Setting

	display is
			-- Show Current on the screen.
		deferred
		ensure
			realized: realized
		end

	set_icon_pixmap (a_pixmap: PIXMAP) is
		deferred
		end

	set_icon_name (a_name: STRING) is
		deferred
		end

	set_delete_command (c: COMMAND) is
		deferred
		end

	set_title (s: STRING) is
		deferred
		end

	set_iconic_state is
			-- Iconify Current.
		deferred
		end

	set_normal_state is
			-- Deiconify Current.
		deferred
		end

feature -- Properties

	associated_form: FORM is
			-- Associated form used to attach objects to
		deferred
		end

	title: STRING is
			-- Title of Current
		deferred
		end

	icon_name: STRING is
			-- Icon name of Current
		deferred
		end

	is_iconic_state: BOOLEAN is
			-- Is Current iconified?
		deferred
		end

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

end -- class EB_SHELL
