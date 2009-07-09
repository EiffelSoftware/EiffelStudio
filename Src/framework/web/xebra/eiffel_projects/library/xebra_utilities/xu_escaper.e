note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_ESCAPER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

feature -- Constants

	cookie_escape: ARRAYED_LIST [TUPLE [STRING, STRING]]
			-- Represents wich string is replaced with which string
		once
			create Result.make (4)
			Result.force ([{XU_CONSTANTS}.Cookie_eq, "_ceq_"])
			Result.force ([{XU_CONSTANTS}.Cookie_sq, "_csq_"])
			Result.force ([{XU_CONSTANTS}.Cookie_end, "_ce_"])
			Result.force ([{XU_CONSTANTS}.Request_end, "_end_"])
		end

feature -- Basic operations

	escape_cookie_text (a_string: STRING): STRING
			-- Escapes text for cookie names or values
		require
			a_string_attached: a_string /= Void
		do
			Result := a_string.twin
			from
				cookie_escape.start
			until
				cookie_escape.after
			loop
				if attached {STRING} cookie_escape.item [1] as l_replacee and
				 attached {STRING} cookie_escape.item [2] as l_replacer then
					Result.replace_substring_all (l_replacee, l_replacer)
				end
				cookie_escape.forth
			end
		ensure
			result_attached: Result /= Void
		end

	unescape_cookie_text (a_string: STRING): STRING
			-- Unescapes text for cookie names or values
		require
			a_string_attached: a_string /= Void
		do
			Result := a_string.twin
			from
				cookie_escape.start
			until
				cookie_escape.after
			loop
				if attached {STRING} cookie_escape.item [2] as l_replacee and
				 attached {STRING} cookie_escape.item [1] as l_replacer then
					Result.replace_substring_all (l_replacee, l_replacer)
				end
				cookie_escape.forth
			end
		ensure
			result_attached: Result /= Void
		end
end

