indexing

	description:
		"Abstract notion of a shell for EBench.";
	date: "$Date$";
	revision: "$Revision$"

deferred class EB_SHELL

inherit
	COMPOSITE

feature -- Setting

	display is
			-- Show Current on the screen.
		deferred
		ensure
			realized: realized
		end;

	set_icon_pixmap (a_pixmap: PIXMAP) is
		deferred
		end;

	set_icon_name (a_name: STRING) is
		deferred
		end;

	set_delete_command (c: COMMAND) is
		deferred
		end;

	set_title (s: STRING) is
		deferred
		end;

	set_iconic_state is
			-- Iconify Current.
		deferred
		end

	set_normal_state is
			-- Deiconify Current.
		deferred
		end

feature -- Properties

	associated_form: FORM is
			-- Associated form used to attach objects to
		deferred
		end;

	title: STRING is
			-- Title of Current
		deferred
		end;

	icon_name: STRING is
			-- Icon name of Current
		deferred
		end;

	is_iconic_state: BOOLEAN is
			-- Is Current iconified?
		deferred
		end;

end -- class EB_SHELL
