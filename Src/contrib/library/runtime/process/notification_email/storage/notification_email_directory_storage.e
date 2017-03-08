note
	description: "Store emails in specific folder."
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFICATION_EMAIL_DIRECTORY_STORAGE

inherit
	NOTIFICATION_EMAIL_STORAGE

create
	make

feature {NONE} -- Initialization

	make (a_dir_path: PATH)
		do
			path := a_dir_path
		end

	path: PATH

feature -- Status report

	is_available: BOOLEAN
			-- Is associated storage available?
		local
			d: DIRECTORY
		do
			create d.make_with_path (path)
			Result := d.exists and d.is_writable
		end

	has_error: BOOLEAN
			-- Last operation reported an error?

feature -- Storage

	put (a_email: NOTIFICATION_EMAIL)
			-- Store `a_email'.
		local
			retried: BOOLEAN
			l_close_needed: BOOLEAN
			f,w: RAW_FILE
			dt: DATE_TIME
			p: PATH
			fn: STRING
			i: INTEGER
		do
			if not retried then
				has_error := False
				create dt.make_now_utc
				p := path.extended (dt.year.out).extended (dt.month.out).extended (dt.day.out)
				safe_create_directory (p)

				create fn.make (10)
				if dt.hour < 10 then
					fn.append_character ('0')
				end
				fn.append_integer (dt.hour)
				fn.append_character ('h')
				if dt.minute < 10 then
					fn.append_character ('0')
				end
				fn.append_integer (dt.minute)
				fn.append_character ('m')
				if dt.second < 10 then
					fn.append_character ('0')
				end
				fn.append_integer (dt.second)
				fn.append_character ('s')
				fn.append (dt.fine_second.out)

				p := p.extended (fn)

				from
					create f.make_with_path (p)
					w := new_file_opened_for_writing (f)
				until
					w /= Void or i > 100
				loop
					i := i + 1
					w := new_file_opened_for_writing (create {RAW_FILE}.make_with_path (p.appended (i.out)))
				end
				if w /= Void then
					w.put_string (a_email.message)
					w.close
				end
			end
		rescue
			retried := True
			has_error := True
			retry
		end

	safe_create_directory (p: PATH)
		local
			d: DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				create d.make_with_path (p)
				if not d.exists then
					d.recursive_create_dir
				end
			end
		rescue
			retried := True
			retry
		end

	new_file_opened_for_writing (f: RAW_FILE): detachable RAW_FILE
			-- Returns a new file object opened for writing if possible
			-- otherwise returns Void.
		local
			retried: BOOLEAN
		do
			if not retried then
				if not f.exists then
					f.open_write
					if f.is_open_write then
						Result := f
					elseif not f.is_closed then
						f.close
					end
				end
			end
		ensure
			Result /= Void implies Result.is_open_write
		rescue
			retried := True
			retry
		end

;note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
