class RENAME_COMMAND

inherit

	COMMAND
	WINDOWS
		export
			{NONE} all
		end
	
feature 

	new_name: STRING
	named_object: NAMABLE

	execute (arg: ANY) is
		do
			named_object ?= arg
			if named_object /= Void then
				pop_up_namer
				--named_object.set_visual_name (new_name)
			end
		end

	pop_up_namer is
		-- put up a prompter to get user input for our name
		local
			namer_window: NAMER_WINDOW
		do
			!!namer_window.make("namer", eb_screen, Current)
			if namer_window.text.text /= "" then
				new_name := namer_window.text.text  
			end 
		end

	continue_after_popdown (box: MESSAGE_D; ok: BOOLEAN) is
		do 
		end

end -- class RENAME_COMMAND
