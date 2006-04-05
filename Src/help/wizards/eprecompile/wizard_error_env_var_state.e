indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ERROR_ENV_VAR_STATE

inherit
	WIZARD_ERROR_STATE_WINDOW

create
	make

feature -- Access

	final_message: STRING is
		do
			create Result.make (100)
			Result.append ("The following environment variables are not set:%N")
			if Eiffel_installation_dir_name = Void then
				Result.append (" - ISE_EIFFEL%N")
			end
			if Eiffel_platform = Void then
				Result.append (" - ISE_PLATFORM%N")
			end
			Result.append ("%N%N")
			Result.append ("Fix the problem and restart the wizard.")
		end

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Precompile Wizard.
		once
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end
	
feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("Environment variables Error")
			message.set_text (final_message)
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
end -- class WIZARD_ERROR_ENV_VAR_STATE
