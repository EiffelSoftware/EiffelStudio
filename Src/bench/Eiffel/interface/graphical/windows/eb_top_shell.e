indexing

	description:
		"Notion of a top shell used for creation of a %
		%tool as a form.";
	date: "$Date$";
	revision: "$Revision$"

class EB_TOP_SHELL

inherit
	EB_SHELL
		undefine
			screen, top
		redefine
			implementation
		end;
	TOP_SHELL
		rename
			make as old_make
		redefine
			implementation
		end;
	WINDOWS

creation
	make

feature -- Initialization

	make (a_name: STRING; a_screen: SCREEN) is
			-- Initialize Current.
		require
			valid_name: a_name /= Void
			valid_screen: a_screen /= Void
		do
			old_make (a_name, a_screen);
			!! associated_form.make ("", Current);
		ensure
			screen_set: equal (screen, a_screen);
			identifier_set: identifier.is_equal (a_name)
		end;

feature -- Properties

	associated_form: FORM
			-- Associated form

feature -- Display

	display is
			-- Show Current on the screen
		do

			if realized then
				if shown then
					raise
				else
					show
				end
			else
				realize;
				focus_label.initialize_focusables
			end
		end;

feature {NONE} -- Implementation

	implementation: TOP_SHELL_I

end -- class EB_TOP_SHELL
