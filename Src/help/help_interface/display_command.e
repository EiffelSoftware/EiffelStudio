indexing
	description:	"Command to display selected XML file"
	author:	 	"Parker Abercrombie"
	date:		"$Date$"

class
	DISPLAY_COMMAND

inherit
	EV_COMMAND

create
	default_create

feature -- Basic Operations

	execute (args: EV_ARGUMENT3 [STRING, EV_LIST, HELP_DOCUMENT_DISPLAY]; data: EV_EVENT_DATA) is
			-- Prepend the path in `args.first' to `args.second' and display the file in `args.third'.
		require else
			args_not_void: args /= Void
		local
			file_name: STRING
			color: EV_COLOR
		do
			file_name := clone (args.first)
			file_name.append (args.second.selected_item.data.out)

			create color.make_rgb (255, 255, 255)

			display := args.third
			display.load_file (file_name)
			display.set_editable (False)
			display.set_background_color (color)
		end;

	display: HELP_DOCUMENT_DISPLAY
		-- Box that will display the document.

end -- class DISPLAY_COMMAND
