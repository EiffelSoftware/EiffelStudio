
class STATES_WND

inherit

	CHOICE_WND
		rename
			make as choice_make
		undefine
			continue_after_popdown
		end;

creation

	make

feature

	caller: B_STATE_H;

	make (a_parent: COMPOSITE; c: B_STATE_H) is
		local
			Nothing: ANY
		do
			caller := c;
			choice_make (a_parent);
		end;

feature {NONE}

	continue_after_popdown is
		do
			caller.reset_callback;
			if not equal (list.selected_item, "Cancel") then
				caller.set_state (list.selected_item)
			end
		end;

end
