note
	description: "[
		A EiffelStudio discardable informative prompt.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_DISCARDABLE_INFORMATION_PROMPT

inherit
	ES_DISCARDABLE_PROMPT
		redefine
			build_prompt_interface
		end

create
	make,
	make_standard

feature {NONE} -- User interface initialization

	build_prompt_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			-- Note: Redefine to add widgets before the discardable check.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		do
			Precursor {ES_DISCARDABLE_PROMPT} (a_container)
			set_title (interface_names.t_eiffelstudio_info)
		end

feature {NONE} -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := large_icon
		end

	large_icon: EV_PIXEL_BUFFER
			-- The dialog's large icon, shown on the left
		do
			Result := os_stock_pixmaps.information_pixel_buffer
		end

	standard_buttons: DS_HASH_SET [INTEGER]
			-- Standard set of buttons for a current prompt
		once
			Result := dialog_buttons_helper.ok_cancel_buttons
		end

	standard_default_button: INTEGER
			-- Standard buttons `standard_buttons' default button
		once
			Result := dialog_buttons_helper.ok_button
		end

	standard_default_confirm_button: INTEGER
			-- Standard buttons `standard_buttons' default confirm button
		do
			Result := dialog_buttons.ok_button
		end

	standard_default_cancel_button: INTEGER
			-- Standard buttons `standard_buttons' default cancel button
		do
			Result := dialog_buttons.ok_button
		end

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
