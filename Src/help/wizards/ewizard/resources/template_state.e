indexing
	description: "Page in which the user choose where he wants to generate the sources."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	<FL_WIZARD_CLASS_NAME>

inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
		local
		do 
			set_updatable_entries(<<>>)
		end

	proceed_with_current_info is 
		local
			dir: DIRECTORY
		do
			Precursor
--			proceed_with_new_state(Create {NEXT_STATE}.make(wizard_information))
		end

	update_state_information is
			-- Check User Entries
		do

			Precursor
		end


feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("MY STATE")
			message.set_text ("My message")
		end

end -- class <FL_WIZARD_CLASS_NAME>
