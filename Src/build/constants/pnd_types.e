indexing
	description: "Pick and drop types."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class PND_TYPES

inherit
	CONSTANTS

feature -- Constants

	argument_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

--	application_object_type: EV_PND_TYPE is
--		once
--			create Result.make_with_cursor (Cursors.application_cursor)
--		end

	attribute_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

	behavior_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.behavior_cursor)
		end

	color_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.color_cursor)
		end

	command_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.command_cursor)
		end

	context_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.context_cursor)
		end

	event_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.event_cursor)
		end

	label_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.label_cursor)
		end

	instance_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.command_instance_cursor)
		end

	new_state_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.state_cursor)
		end

	state_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.state_cursor)
		end

	transition_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.transition_cursor)
		end

	type_data_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.type_cursor)
		end

	window_type: EV_PND_TYPE is
		once
			create Result.make_with_cursor (Cursors.window_cursor)
		end

end -- class PND_TYPES

