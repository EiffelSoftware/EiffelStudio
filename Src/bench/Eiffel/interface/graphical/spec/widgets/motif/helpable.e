deferred class HELPABLE

feature -- Access

	associated_help_widget: WIDGET is
		deferred
		end;

	help_index: INTEGER is
			-- Index within help file
		deferred
		end;

	help_file_name: FILE_NAME is
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Update

	invoke_help is
			-- Invoke help window for Current helpable object.
		--local
			--wel_win: WEL_WINDOW
		do
			--wel_win ?= associated_help_widget.implementation;
			--wel_win.help_file (help_file_name, 0, 0) 
		end

end -- class HELPABLE
