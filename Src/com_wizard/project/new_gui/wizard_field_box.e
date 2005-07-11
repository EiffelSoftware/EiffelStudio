indexing
	description: "Text field with color validation"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FIELD_BOX

inherit
	WIZARD_FIELD_BOX_IMP
		rename
			field_label as text_label,
			field_combo as text_combo
		export
			{NONE} all
		end

	WIZARD_TEXT_BOX
		undefine
			default_create,
			is_equal,
			copy
		redefine
			on_mouse_leave
		end
	
feature -- Access

	focus_lost_actions: LIST [ROUTINE [ANY, TUPLE[]]] is
			-- Focus lost actions
		do
			if internal_focus_lost_actions = Void then
				create {ARRAYED_LIST [ROUTINE [ANY, TUPLE[]]]} internal_focus_lost_actions.make (10)
			end
			Result := internal_focus_lost_actions
		ensure
			attached_actions: Result /= Void
		end
		
feature {NONE} -- Event Handling

	on_mouse_leave is
			-- Call actions then precursor
		do
			if internal_focus_lost_actions /= Void then
				from
					internal_focus_lost_actions.start
				until
					internal_focus_lost_actions.after
				loop
					internal_focus_lost_actions.item.call (Void)
					internal_focus_lost_actions.forth
				end
			end
		end

feature {NONE} -- Implementation

		internal_focus_lost_actions: LIST [ROUTINE [ANY, TUPLE[]]]
			-- Focus lost actions cache

end -- class WIZARD_FIELD_BOX

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

