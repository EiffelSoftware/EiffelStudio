indexing
	description	: "Page in which the user choose where he wants to generate the sources."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "David Solal"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_THIRD_STATE

inherit
	BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
		do 
			create icon_location.make (Current)
			icon_location.set_textfield_string (wizard_information.icon_location)
			icon_location.set_label_string_and_size ("Project icon", 10)
			icon_location.enable_file_browse_button ("*.ico")
			icon_location.generate

			choice_box.set_padding (Default_padding_size)
			choice_box.extend (icon_location.widget)
			choice_box.disable_item_expand(icon_location.widget)
			choice_box.extend (create {EV_CELL}) -- Expandable item

			set_updatable_entries(<<icon_location.change_actions>>)
		end

	proceed_with_current_info is 
		do
			Precursor
			proceed_with_new_state(Create {WIZARD_FINAL_STATE}.make(wizard_information))
		end

	update_state_information is
			-- Check User Entries
		local
			icon_path: FILE_NAME
		do
			if not icon_location.text.is_equal ("") then
				wizard_information.set_icon_location (icon_location.text)
			else
				create icon_path.make_from_string (wizard_resources_path)
				icon_path.set_file_name ("eiffel")
				icon_path.add_extension ("ico")
				wizard_information.set_icon_location (icon_path)
			end
			Precursor
		end


feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("Project icon")
			subtitle.set_text ("Choose an icon for you project.")
			message.set_text (
				"You have chosen to build a Frame-Based Application.%N%
				%You can provide an icon or use the default icon")
		end

	icon_location: WIZARD_SMART_TEXT_FIELD;
			-- Label and Textfield for the icon location.

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
end -- class WIZARD_SECOND_STATE
