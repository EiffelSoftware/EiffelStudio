note
	description: "[
				Options used by WSF_SERVICE_LAUNCHER
				Built from ini configuration file
		]"

class
	WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI

inherit
	WSF_SERVICE_LAUNCHER_OPTIONS

create
	make_from_file,
	make_from_file_and_defaults

feature {NONE} -- Initialization

	make_from_file (a_filename: READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		do
			make
			import (a_filename)
		end

	make_from_file_and_defaults (a_filename: READABLE_STRING_GENERAL; dft: detachable WSF_SERVICE_LAUNCHER_OPTIONS)
			-- Initialize `Current'.
		do
			make

			if dft /= Void then
				append_options (dft)
			end

			import (a_filename)
		end

feature {NONE} -- Implementation

	import (a_filename: READABLE_STRING_GENERAL)
			-- Import ini file content
		local
			f: PLAIN_TEXT_FILE
			l,v: STRING_8
			p: INTEGER
		do
			create f.make_with_name (a_filename)
			if f.exists and f.is_readable then
				f.open_read
				from
					f.read_line
				until
					f.exhausted
				loop
					l := f.last_string
					l.left_adjust
					if not l.is_empty and then l[1] /= '#' then
						p := l.index_of ('=', 1)
						if p > 1 then
							v := l.substring (p + 1, l.count)
							l.keep_head (p - 1)
							v.left_adjust
							v.right_adjust
							l.right_adjust
							set_option (l.as_lower, v)
						end
					end
					f.read_line
				end
				f.close
			end
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
