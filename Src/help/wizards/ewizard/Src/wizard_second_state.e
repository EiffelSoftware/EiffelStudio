indexing
	description	: "Second step of the wizard"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_SECOND_STATE

inherit
	BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

	WIZARD_WIZARD_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
		local
			hbox: EV_HORIZONTAL_BOX
			vbox: EV_VERTICAL_BOX
			left_label: EV_LABEL
			right_label: EV_LABEL
		do 
				-- Label
			create left_label.make_with_text (Interface_names.l_Number_of_state1)
			left_label.align_text_left

				-- ComboBox
			create number_state
			fill_number_state

			create right_label.make_with_text (Interface_names.l_Number_of_state2)
			right_label.align_text_left

				-- Vision2 architechture
			create hbox
			hbox.set_padding (5)
				create vbox
				vbox.extend (create {EV_CELL})
				vbox.extend (left_label)
				vbox.disable_item_expand (left_label)
				vbox.extend (create {EV_CELL})
			hbox.extend (vbox)
			hbox.disable_item_expand (vbox)
			hbox.extend (number_state)
			hbox.disable_item_expand (number_state)
				create vbox
				vbox.extend (create {EV_CELL})
				vbox.extend (right_label)
				vbox.disable_item_expand (right_label)
				vbox.extend (create {EV_CELL})
			hbox.extend (vbox)
			hbox.disable_item_expand (vbox)
			hbox.extend (create {EV_CELL})
			choice_box.extend (hbox)

			set_updatable_entries(<<number_state.change_actions>>)
		end

	fill_number_state is
		local
			i: INTEGER
			list_item: EV_LIST_ITEM
		do
			from
				i := 1
			until
				i > 10
			loop
				create list_item
				list_item.set_text (i.out)
				number_state.extend (list_item)
			
				if i = wizard_information.number_state then
					list_item.enable_select
				end
				i := i + 1
			end

				-- Select the first item if none is selected.
			if number_state.selected_item = Void then
				number_state.start
				number_state.item.enable_select
			end
		end

	proceed_with_current_info is 
		do
			Precursor
			proceed_with_new_state(create {WIZARD_FINAL_STATE}.make (wizard_information))
		end

	update_state_information is
			-- Check User Entries
		local
			num: INTEGER
		do
			num := number_state.text.to_integer
			wizard_information.set_number_state (num)
			Precursor
		end

feature {NONE} -- Implementation

	display_state_text is
			-- Display message text relative to current state.
		do
			title.set_text (Interface_names.t_Second_state)
			subtitle.set_text (Interface_names.st_Second_state)
			message.set_text (Interface_names.m_Second_state)
		end

	number_state: EV_COMBO_BOX;
			-- Text field to enter the number of states

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
