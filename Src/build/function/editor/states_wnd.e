
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
		do
			caller := c;
			choice_make (a_parent);
		end;

feature {NONE}

	continue_after_popdown is
		do
			caller.set_state (list.selected_item.value)
		end;

end
