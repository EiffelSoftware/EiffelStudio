indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_TOOLTIP_CMD

inherit
	MEL_COMMAND

creation
	make

feature -- Initialization

	make (text_field_imp: TEXT_FIELD_I) is
			-- Create the tootip command
		local
			imp: TEXT_FIELD_IMP
		do
			imp ?= text_field_imp
			imp.set_motion_verify_callback (Current, Void)
			imp.disable_verify_bell
		end

feature -- execution

	execute (arg: ANY) is
		local
			cbs:MEL_TEXT_VERIFY_CALLBACK_STRUCT
		do	
			cbs ?= callback_struct
			if cbs /= Void then
				if cbs.event = Void then
					cbs.unset_do_it
				end
			end
		end

end -- class DEBUG_TOOLTIP_CMD
