indexing

	description:
		"Notion of a form dialog used for creation of a %
		%tool as a form.";
	date: "$Date$";
	revision: "$Revision$"

class EB_FORM_DIALOG

inherit
	EB_SHELL
		undefine
			raise, lower, parent
		redefine
			implementation, hide, show
		end;
	FORM_D
		rename
			make as old_make
		redefine
			implementation, hide, show
		end;
	WINDOWS

creation
	make

feature -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Initialize Current.
        require
            valid_name: a_name /= Void
            valid_parent: a_parent /= Void
        do
            old_make (a_name, a_parent);
        ensure
            parent_set: parent = a_parent;
            identifier_set: identifier.is_equal (a_name)
        end;

feature -- Properties

	associated_form: FORM is
			-- Associated form
		do
			Result := Current
		end;

	icon_name: STRING is
			-- Icon name of Current
		do
			Result := ""
		end;

feature -- Setting

	set_icon_name (a_string: STRING) is
		do
		end;

	set_delete_command (c: COMMAND) is
		do
		end;

	display is
			-- Show Current on the screen.
		do
			if is_popped_up then
				raise
			else
				popup;
				focus_label.initialize_focusables
			end
		end;

	hide is
			-- Hide Current.
		do
			popdown
		end;

	show is
			-- Show Current.
		do
			popup
		end

feature -- Inapplicable

	is_iconic_state: BOOLEAN is False;

	set_iconic_state is
		do
		end;

	set_normal_state is
		do
		end

feature {NONE} -- Implementation

	implementation: FORM_D_I

end -- class EB_FORM_DIALOG
