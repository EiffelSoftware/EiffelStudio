indexing
	description: "Obejcts which are closeable"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EC_CLOSEABLE

feature -- Properties

	exit_window(args: EV_ARGUMENT1 [ ECASE_WINDOW ]; data: EV_EVENT_DATA) is
		local
			win: ECASE_WINDOW
		do
			win ?= args.first
			if win /= Void then
				win.destroy
			end
		end

	prepare_exit( win: ECASE_WINDOW ) is
		local
			com: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [ ECASE_WINDOW ]
		do
			!! com.make (~exit_window )
			!! arg.make ( win )
			win.add_close_command ( com , arg )
		end
			
end -- class CLOSEABLE
