indexing

	description:
		"Notion of a top shell used for creation of a %
		%tool as a form.";
	date: "$Date$";
	revision: "$Revision$"

class EB_TOP_SHELL

inherit

	TOOLTIP_INITIALIZER;
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
	WINDOWS;
	EB_CONSTANTS;
	SYSTEM_CONSTANTS

creation
	make

feature -- Initialization

	make (an_id: INTEGER; a_screen: SCREEN) is
			-- Initialize Current.
		require
			valid_screen: a_screen /= Void
		do
			if Platform_constants.is_windows then
					-- For windows we need the id for the Icon
				old_make (an_id.out, a_screen)
			else
					-- For unix we need this for the X resource file
				old_make (Interface_names.n_X_resource_name, a_screen)
			end

			tooltip_initialize (Current)
			!! associated_form.make ("", Current)
		ensure
			screen_set: equal (screen, a_screen)
		end

feature -- Properties

	associated_form: FORM
			-- Associated form

feature -- Display

	display is
			-- Show Current on the screen
		do
			if realized then
				show
			else
				realize
				tooltip_realize
			end
			raise
		end

feature {NONE} -- Implementation

	implementation: TOP_SHELL_I

end -- class EB_TOP_SHELL
