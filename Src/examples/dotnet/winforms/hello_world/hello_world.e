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
		do
			set_text ("Hello world")
			{WINFORMS_APPLICATION}.run_form (Current)
		end	

end -- class HELLO_WORLD
