
class BUTTON_EVENTS 

inherit
	
	EVENT_PAGE
		rename
			make as page_create
		redefine
			is_optional
		end

creation

	make
	
feature {CATALOG}

	is_optional: BOOLEAN is True;
	
feature {NONE}

	but_act_ev: BUT_ACT_EV is
		once
			!!Result.make
		end;

	but_rel_ev: BUT_REL_EV is
		once
			!!Result.make
		end;

	but_arm_ev: BUT_ARM_EV is
		once
			!!Result.make
		end;

	value_changed_ev: VALUE_CHANGED_EV is
		once
			!!Result.make
		end;

feature 

	make (page_n: STRING; a_symbol: PIXMAP; cat: EVENT_CATALOG) is
		do
			page_create (page_n, a_symbol, cat);
			button_type := not_set;
		end;

feature {NONE}

	button_type: INTEGER;

	not_set, toggle, other: INTEGER is UNIQUE;

feature 

	update_content (a_context: CONTEXT) is
		local
			toggle_b_c: TOGGLE_B_C;
			new_type: INTEGER;
		do
			toggle_b_c ?= a_context;
			if not (toggle_b_c = Void) then
				new_type := toggle
			else
				new_type := other
			end;
			if new_type /= button_type then
				button_type := new_type;
				wipe_out;
				add (but_arm_ev);
				add (but_rel_ev);
				if (toggle_b_c = Void) then
					add (but_act_ev);
				else
					add (value_changed_ev);
				end;
			end;
		end;

end
