indexing

	description:
		"Popup a list of all targets in the tool's history. %
		%The contents is created in the descendants."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHOW_HISTORY_CMD

inherit
	EB_TEXT_TOOL_CMD

creation
	make

feature -- Properties

--	name: STRING is
--			-- Name of the command
--		do
--			Result := Interface_names.f_List_targets
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_List_targets
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--			Result := Interface_names.t_empty
--		end

feature {NONE} -- Execution

feature {NONE} -- Implementation

	create_and_show_choices is
			-- Creates the choice window, fills it,
			-- and pops it up.
		local
			a_list: TWO_WAY_LIST [STRING]
			choice: EB_CHOICE_DIALOG
		do
			create choice.make_default (~retarget_text_area (?))
			create a_list.make
			fill_list (a_list)
			choice.set_title (tool.history_dialog_title)
			choice.set_list (a_list)
			choice.select_item (tool.history.index)
--| FIXME
--| Christophe, 10 nov 1999
--| the `select_item' instruction triggers an event.
--| This event MUST NOT occur.
			choice.show
		end

	fill_list (list: TWO_WAY_LIST [STRING]) is
			-- Fill `list' with strings.
			--| Be careful: `fill_list' may not change
			--| the position of the active item!!
		local
			cur: CURSOR
			a_string: STRING
			history: STONE_HISTORY
		do
			history := tool.history
			cur := history.cursor
			from
				history.start
			until
				history.after
			loop
				list.extend (history.item.history_name)
				history.forth
			end
			history.go_to (cur)
		end

	retarget_text_area (pos: INTEGER) is
			-- Retarget `text_area' with the item number `pos'.
		local
			history: STONE_HISTORY
			i: INTEGER
		do
			if pos /= 0 then
				history := tool.history
				from
					i := 1
					history.start
				until
					i = pos
				loop
					history.forth
					i := i + 1
				end
				history.set_do_not_update (True)
--				tool.receive (history.item)
				tool.set_stone (history.item)
--| FIXME
--| Christophe, 2 nov 1999
--| `receive' does not exist. looking for something to replace it.
				history.set_do_not_update (False)
			end
		end

end -- class EB_SHOW_HISTORY_CMD
