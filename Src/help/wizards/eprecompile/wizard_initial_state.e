indexing
	description: "Initial State"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INITIAL_STATE

inherit
	WIZARD_INITIAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end

create
	make

feature -- basic Operations

	proceed_with_current_info is
		do
			Precursor
			if Eiffel_platform /= Void and Eiffel_installation_dir_name /= Void then
				proceed_with_new_state (create {WIZARD_FIRST_STATE}.make(wizard_information))
			else
				proceed_with_new_state (create {WIZARD_ERROR_ENV_VAR_STATE}.make(wizard_information))
			end
		end

	display_state_text is
		do
			title.set_text ("Welcome to the%NPrecompilation Wizard")
			message.set_text (
				"Using this wizard you can precompile any Eiffel library.%N%
				%You will be able to precompile the shipped libraries%N%
				%but also your own libraries by providing the corresponding Ace file.%N%
				%%N%
				%If you precompile a library already precompiled, the previous%N%
				%version will be overwritten%N%
				%%N%
				%%N%
				%To continue, click Next.")
		end

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Precompile Wizard
		once
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
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
end -- class WIZARD_INITIAL_STATE
