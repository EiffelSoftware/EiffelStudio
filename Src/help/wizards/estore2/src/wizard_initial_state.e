indexing
	description: "Initial State"
	author: "david S"
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
			Precursor {WIZARD_INITIAL_STATE_WINDOW}
			proceed_with_new_state(Create {DB_CONNECTION}.make(wizard_information))
		end

	display_state_text is
		do
			title.set_text ("THE EIFFELSTORE WIZARD")
			message.set_text ("%TWelcome,%
								%%N%N%NThis wizard will help you to build your first EiffelStore Application.%
								%%N%N%NYou will have to connect to the database you are going to use with%NEiffelStore.%
								%%N%NBy choosing the tables you want to work with, this wizard will generate%Nan Eiffel Project.%
								%%N%NThen, you will be able to use the generated classes to build your own%NProject.")
		end

	pixmap_icon_location: FILE_NAME is
		do
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end

end -- class WIZARD_INITIAL_STATE
