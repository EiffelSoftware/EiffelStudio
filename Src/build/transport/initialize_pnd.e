indexing
	description: "Command to initialize pick and drop."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INITIALIZE_PND

inherit
	EV_COMMAND

	WINDOWS

creation
	make

feature {NONE} -- Initialization

	make (src: EV_PND_SOURCE) is
		do
			source := src
		end

feature -- Command

	execute (arg: EV_ARGUMENT2 [EV_PND_TYPE, ANY]; ev_data: EV_BUTTON_EVENT_DATA) is
		local
			nm: NAMABLE
			ed: EDITABLE
		do
			source.set_transported_data (Void)
			if ev_data.shift_key_pressed then
					-- Rename command
				nm ?= arg.second
				if nm /= Void then
					change_name (nm)
				end
			elseif ev_data.control_key_pressed then
					-- Create editor command
				ed ?= arg.second
				if ed /= Void then
					ed.create_editor
				end
			else	-- Pick and drop can start
				source.set_data_type (arg.first)
				source.set_transported_data (arg.second)
			end
		end

feature {NONE} -- Implementation

	source: EV_PND_SOURCE

end -- class INITIALIZE_PND

