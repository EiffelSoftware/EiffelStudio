indexing
	description: "Initial State"
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INITIAL_STATE

inherit
	WIZARD_INITIAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end

create
	make

feature -- basic Operations

	proceed_with_current_info is
		do
			Precursor
			if Eiffel_platform /= Void and Eiffel_installation_dir_name /= Void then
				proceed_with_new_state (create {WIZARD_FIRST_STATE}.make(wizard_information))
			else
				proceed_with_new_state (create {WIZARD_ERROR_ENV_VAR_STATE}.make(wizard_information))
			end
		end

	display_state_text is
		do
			title.set_text ("Welcome to the%NPrecompilation Wizard")
			message.set_text (
				"Using this wizard you can precompile any Eiffel library.%N%
				%You will be able to precompile the shipped libraries%N%
				%but also your own libraries by providing the corresponding Ace file.%N%
				%%N%
				%If you precompile a library already precompiled, the previous%N%
				%version will be overwritten%N%
				%%N%
				%%N%
				%To continue, click Next.")
		end

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
			-- Icon for the Eiffel Store Wizard

end -- class WIZARD_INITIAL_STATE
