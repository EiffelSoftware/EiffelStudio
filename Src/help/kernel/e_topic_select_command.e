indexing
	description: "Gets called when the user selects a topic from a tree or something"
	author: "Vincent Brendel"

class
	E_TOPIC_SELECT_COMMAND

inherit
	EV_COMMAND 

creation
	make

feature -- Initialization

	make(statbar: EV_STATUS_BAR; displ:E_TOPIC_DISPLAY) is
			-- Initialize
		do
			display := displ
			create id_field.make(statbar)
			id_field.set_width(150)
			create loc_field.make(statbar)
			loc_field.set_width(250)
		end

	execute(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			arg: EV_ARGUMENT1[E_TOPIC]
		do
			arg ?= args
			arg.first.display(display)
			id_field.set_text(arg.first.id)
			loc_field.set_text(arg.first.location)
		end

	id_field, loc_field: EV_STATUS_BAR_ITEM
	display: E_TOPIC_DISPLAY

end -- class E_TOPIC_SELECT_COMMAND
