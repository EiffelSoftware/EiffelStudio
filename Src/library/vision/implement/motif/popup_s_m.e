
-- POPUP_S_M: implementation of popup shell.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class POPUP_S_M 

inherit

	SHELL_M;   

	 COMMAND
        	export
            		{NONE} all
        	end;

feature {NONE}

	grab_type: INTEGER;
			-- Type of grab
    
        initialize (a_widget: WIDGET) is
                  -- Initialize the current dialog
              local
                  true_ref, false_ref: BOOLEAN_REF
              do
                  !!popup_actions.make (screen_object, Mpopup, a_widget);
                  !!true_ref;
                  true_ref.set_item (True);
                  popup_actions.add (Current, true_ref);
                  !!popdown_actions.make (screen_object, Mpopdown, a_widget);
                  !!false_ref;
                  false_ref.set_item (False);
                  popdown_actions.add (Current, false_ref)
              end;

        execute (up: ANY) is
        	local
            		bool_ref: BOOLEAN_REF
       	 	do
            		bool_ref ?= up;
            		is_popped_up_ref := bool_ref;
        	end;


feature 
	is_cascade_grab: BOOLEAN is
			-- Is the shell popped up with cascade grab (allowing the other
			-- shells popped up with grab to receive events) ?
		do
			Result := grab_type = 2
		end; -- is_cascade_grab

	is_exclusive_grab: BOOLEAN is
			-- Is the shell popped up with exclusive grab ?
		do
			Result := grab_type = 1
		end; -- is_no_grab

	is_no_grab: BOOLEAN is
			-- Is the shell popped up with no grab ?
		do
			Result := grab_type = 0
		end; -- is_no_grab

feature {NONE}

	is_poped_up: BOOLEAN is
			-- Is the popup widget popped up on screen ?
		obsolete "Use is_popped_up instead, corrected feature spelling."
		do
			Result := is_popped_up_ref.item
		end;

	is_popped_up: BOOLEAN is
			-- Is the popup widget popped up on screen ?
		do
			Result := is_popped_up_ref.item
		end;

	is_popped_up_ref: BOOLEAN_REF;

	is_poped_up_ref: BOOLEAN_REF is
		obsolete "Use is_popped_up_ref instead, corrected feature
spelling."
		do
			Result := is_popped_up-ref
		end

feature {NONE}

    popup_actions: EVENT_HAND_M;
   
    popdown_actions: EVENT_HAND_M;

feature 

	popdown is
			-- Popdown popup shell.
		do
			if is_popped_up then
				xt_popdown (screen_object);
			end;
                	is_popped_up_ref.set_item (False);
		ensure
			not is_popped_up
		end; -- popdown

	popup is
			-- Popup a popup shell.
		do
			if not is_popped_up then
				inspect	grab_type
                		when 0 then
                    			xt_popup_none (screen_object)
               			when 1 then
                    			xt_popup_exclusive (screen_object)
                		when 2 then
                    			xt_popup_non_ex (screen_object)
                		end;
                		is_popped_up_ref.set_item (True)

			end
		ensure
			is_popped_up
		end;

	set_cascade_grab is
			-- Specifies that the shell would be popped up with cascade grab
			-- (allowing the other shells popped up with grab to receive events).
		do
			grab_type := 2
		ensure
			is_cascade_grab
		end; -- set_cascade_grab

	set_exclusive_grab is
			-- Specifies that the shell would be popped up with exclusive grab.
		do
			grab_type := 1
		ensure
			is_exclusive_grab
		end; -- set_exclusive_grab

	set_no_grab is
			-- Specifies that the shell would be popped up with no grab.
		do
			grab_type := 0
		ensure
			is_no_grab
		end

feature {NONE} -- External features

	c_is_poped_up (value: POINTER): BOOLEAN is
		external
			"C"
		end;

	c_add_grab (scr_obj: POINTER; g_type: INTEGER) is
		external
			"C"
		end;

    xt_popup_non_ex (a_popup: POINTER) is
        external
            "C"
        end;

    xt_popup_exclusive (a_popup: POINTER) is
        external
            "C"
        end;

    xt_popup_none (a_popup: POINTER) is
        external
            "C"
        end;

    xt_popdown (scr_obj: POINTER) is
        external
            "C"
        end;



end



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
