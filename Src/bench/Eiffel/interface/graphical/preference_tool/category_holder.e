indexing

	description:
		"Holder for the preference tool.";
	date: "$Date$";
	revision: "$Revision$"

class CATEGORY_HOLDER

inherit
	ISE_CMD_HOLDER
		redefine
			associated_button, associated_menu_entry
		end

create
	make, make_plain

feature {NONE} -- Initialization

	make (a_button: like associated_button; a_menu_entry: like associated_menu_entry) is
			-- Initialize Current.
		do
			associated_button := a_button;
			associated_menu_entry := a_menu_entry
		end;

feature -- Setting

	set_button (a_button: like associated_button) is
			-- Set `associated_button' to `a_button'.
		do
			associated_button := a_button
		end;

	set_menu_entry (a_menu_entry: like associated_menu_entry) is
			-- Set `associated_menu_entry' to `a_menu_entry'.
		do
			associated_menu_entry := a_menu_entry
		end;

	set_selected (selection: BOOLEAN) is
			-- Set both `associated_button' and `associated_menu_entry'
			-- to be selected or not, according `selection'.
		do
			if associated_button /= Void then
				associated_button.set_selected (selection)
			end;
			if associated_menu_entry /= Void then
				associated_menu_entry.set_selected (selection)
			end
		end

feature -- Properties

	associated_button: PREFERENCE_BUTTON;
			-- Button on the toolbar

	associated_menu_entry: PREFERENCE_TICKABLE_MENU_ENTRY;

feature {NONE} -- Useless

	make_plain is do end;

end -- class CATEGORY_HOLDER
