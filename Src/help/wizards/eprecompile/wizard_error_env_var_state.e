indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ERROR_ENV_VAR_STATE

inherit
	WIZARD_ERROR_STATE_WINDOW

create
	make

feature -- Access

	final_message: STRING is
		do
			create Result.make (100)
			Result.append ("The following environment variables are not set:%N")
			if Eiffel_installation_dir_name = Void then
				Result.append (" - ISE_EIFFEL%N")
			end
			if Eiffel_platform = Void then
				Result.append (" - ISE_PLATFORM%N")
			end
			Result.append ("%N%N")
			Result.append ("Fix the problem and restart the wizard.")
		end

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Precompile Wizard.
		once
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end
	
feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("Environment variables Error")
			message.set_text (final_message)
		end

end -- class WIZARD_ERROR_ENV_VAR_STATE
