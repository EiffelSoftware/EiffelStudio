indexing
	description	: "Second step of the wizard"
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
			create left_label.make_with_text ("Generate a wizard with ")
			left_label.align_text_left

				-- ComboBox
			create number_state
			fill_number_state

			create right_label.make_with_text (" states.")
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
			proceed_with_new_state(Create {WIZARD_FINAL_STATE}.make (wizard_information))
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
		do
			title.set_text ("Number of States")
			subtitle.set_text ("You can choose the number of states your wizard will have.")
			message.set_text ("The number of states is limited to 10.")
		end

	number_state: EV_COMBO_BOX
			-- Text field to enter the number of states

end -- class WIZARD_SECOND_STATE
