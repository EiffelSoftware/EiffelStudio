indexing
	description: "Allows persisting and retrieving combo content from and to registry"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SAVED_SETTINGS

inherit
	WIZARD_REGISTRY_STORE
		export
			{NONE} all
		end

feature -- Basic Operations

	initialize_combo (a_combo: EV_COMBO_BOX; a_name: STRING) is
			-- Fill `a_combo' with saved values with key `a_name' if any.
			-- Will persist combo values in key with name `a_name'.
		require
			non_void_combo: a_combo /= Void
		local
			l_list: LIST [STRING]
		do
			a_combo.set_data (agent save_list (?, a_name))
			if is_saved_list (a_name) then
				l_list := saved_list (a_name)
				fill_combo (a_combo, l_list)
			end
		end

	add_combo_item (a_entry: STRING; a_combo: EV_COMBO_BOX) is
			-- Add entry `a_entry' to combo box `a_combo' if not there already.
			-- Persist combo box strings.
		local
			l_save_routine: ROUTINE [ANY, TUPLE [LIST [STRING]]]
			l_list, l_new_list: LIST [STRING]
		do
			if not a_entry.is_empty then
				l_list := a_combo.strings
				l_list.compare_objects
				if not l_list.has (a_entry) then
					if a_combo.count >= Max_combo_count then
						a_combo.finish
						a_combo.remove
					end
					a_combo.put_front (create {EV_LIST_ITEM}.make_with_text (a_entry))
					l_save_routine ?= a_combo.data
					if l_save_routine /= Void then
						l_save_routine.call ([a_combo.strings])
					end
				else
					if not a_combo.strings.first.is_equal (a_entry) then
						create {ARRAYED_LIST [STRING]} l_new_list.make (l_list.count)
						l_new_list.extend (a_entry)
						l_list.prune (a_entry)
						l_new_list.append (l_list)
						a_combo.change_actions.block
						a_combo.set_strings (l_new_list)
						a_combo.change_actions.resume
					end
				end
			end
		end

feature {NONE} -- Implementation

	fill_combo (a_combo: EV_COMBO_BOX; a_list: LIST [STRING]) is
			-- Fill `a_combo' with strings in `a_list'.
		require
			non_void_combo: a_combo /= Void
			non_void_list: a_list /= Void
		do
			a_combo.wipe_out
			if not a_list.is_empty then
				from
					a_list.start
				until
					a_list.after
				loop
					a_combo.extend (create {EV_LIST_ITEM}.make_with_text (a_list.item))
					a_list.forth
				end
				a_combo.set_text (a_list.first)
			end
		end

feature {NONE} -- Private Access

	Max_combo_count: INTEGER is 10
			-- Maximum combo entries

end -- class WIZARD_SAVED_SETTINGS
