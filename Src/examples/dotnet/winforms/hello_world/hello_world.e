indexing
	description: "Display a FORM with the title `Hello world'"
	
class
	HELLO_WORLD

--inherit
--	WINFORMS_FORM
	
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point."
		local
			dummy: SYSTEM_OBJECT
		do
			create my_window.make
			my_window.set_text (("Hello world").to_cil)			
			dummy := my_window.show_dialog
		end
		
feature -- Access

	my_window: WINFORMS_FORM
			-- Main window.


end -- class HELLO_WORLD
