indexing
	description: "Abstraction of a status bar"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_STATUS_BAR

feature -- Status setting

	display_message (mess: STRING) is
			-- Display a one-line message.
		require
			one_line_message: mess /= Void and then (not mess.has ('%N') and not mess.has ('%R'))
		deferred
		ensure
			message_displayed: message.is_equal (mess)
		end

feature -- Status report

	message: STRING is
			-- Currently displayed message.
		deferred
		ensure
			no_void_message: Result /= Void
		end

feature -- Access

	widget: EV_STATUS_BAR is
			-- Widget that represents `Current'.
		deferred
		ensure
			not_void: Result /= Void
			constant: Result = widget
		end

end -- class EB_STATUS_BAR
