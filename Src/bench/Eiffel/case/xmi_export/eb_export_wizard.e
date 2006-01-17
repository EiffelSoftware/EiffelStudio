indexing
	description: "Guides the user through the options for XMI export."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPORT_WIZARD

inherit
	EB_DOCUMENTATION_WIZARD
		redefine
			go_to_page,
			initialize
		end

create
	default_create

feature {EV_ANY} -- Initialization

	initialize is
			-- Sets defaults.
		do
			Precursor
			set_title ("XMI Export")
		end

feature {NONE} -- Implementation

	go_to_page (i: INTEGER) is
			-- Show page number `i' of current wizard.
		do
			inspect i when 1 then
				previous_button.disable_sensitive
				next_button.enable_sensitive
				set_default_push_button (next_button)
				show_cluster_selection
			when 2 then
				previous_button.enable_sensitive
				next_button.disable_sensitive
				finish_button.enable_sensitive
				set_default_push_button (finish_button)
				show_directory_selection
			end
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

end -- class EB_EXPORT_WIZARD
