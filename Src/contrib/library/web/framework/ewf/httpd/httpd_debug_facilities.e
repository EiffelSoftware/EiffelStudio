note
	description: " Routines used for debug logging."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTPD_DEBUG_FACILITIES

feature {NONE} -- Output

	dbglog (m: READABLE_STRING_8)
		require
			not m.ends_with_general ("%N")
		local
			s: STRING
		do
			debug ("dbglog")
				create s.make (24)
				s.append ("[EWF/DBG] <#")
				s.append_integer (processor_id_from_object (Current))
				s.append ("> ")
				s.append (generator)
				s.append (create {STRING}.make_filled (' ', (46 - s.count).max (0)))
				s.append (" | ")
				s.append (m)
				s.append ("%N")
				print (s)
			end
		end

feature -- runtime

	frozen processor_id_from_object (a_object: separate ANY): INTEGER_32
		external
			"C inline use %"eif_scoop.h%""
		alias
			"RTS_PID(eif_access($a_object))"
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
