indexing
	description: "Display a FORM with the title `Hello world'"
	
class
	HELLO_WORLD

inherit
	WINFORMS_FORM
		rename
			make as make_form
		end
	
create
	make

feature {NONE} -- Initialization

	make is
			--| Set title with "hello_world".
			-- Entry point.
		local
			dummy: SYSTEM_OBJECT
		do
			set_text (("Hello world").to_cil)
			feature {WINFORMS_APPLICATION}.run_form (Current)
		end	

end -- class HELLO_WORLD
