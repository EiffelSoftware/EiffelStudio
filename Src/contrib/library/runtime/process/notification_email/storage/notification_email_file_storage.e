note
	description: "Store email in specific file (could also be stderr, ...)."
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFICATION_EMAIL_FILE_STORAGE

inherit
	NOTIFICATION_EMAIL_STORAGE

create
	make

feature {NONE} -- Initialization

	make (a_output_file: FILE)
		require
			a_output_file_valid: a_output_file.exists
		do
			output := a_output_file
		end

	output: FILE

feature -- Status report

	is_available: BOOLEAN
			-- Is associated storage available?
		do
			Result := output.exists and output.is_access_writable
		end

	has_error: BOOLEAN
			-- Last operation reported an error?

feature -- Storage

	put (a_email: NOTIFICATION_EMAIL)
			-- Store `a_email'.
		local
			retried: BOOLEAN
			l_close_needed: BOOLEAN
		do
			if not retried then
				has_error := False
				if not output.is_open_write then
					output.open_append
					l_close_needed := True
				end
				output.put_string ("%N----%N" + a_email.message)
				if l_close_needed then
					output.close
				else
					output.flush
				end
			end
		rescue
			retried := True
			has_error := True
			retry
		end

;note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
