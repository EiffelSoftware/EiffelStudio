indexing
	description: "Provides the help functionality."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HELPABLE

inherit
	G_ANY

	EIFFEL_ENV

	WEL_HELP_CONSTANTS
		rename
			help_index as wel_help_index
		end

feature -- Access

	bench_help_file_name: FILE_NAME is
		once
			Result := Bin_path
			Result.set_file_name ("ebench.hlp")
		end

	associated_help_widget: WIDGET is
		deferred
		end

	help_index: INTEGER is
			-- Index within help file
		deferred
		end

	help_file_name: FILE_NAME is
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Update

	invoke_help is
			-- Invoke help window for Current helpable object.
		local
			wel_win: WEL_WINDOW
		do
			wel_win ?= associated_help_widget.implementation
			wel_win.win_help (bench_help_file_name, Help_context, help_index)
		end

end -- class HELPABLE
