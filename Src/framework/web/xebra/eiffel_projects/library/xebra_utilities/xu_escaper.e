note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_ESCAPER

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

feature -- Escaping

	escape_cookie_text (a_string: STRING): STRING
			-- Escapes text for cookie names or values
		require
			a_string_attached: a_string /= Void
		do
			Result := replace (a_string, cookie_escape, False)
		ensure
			result_attached: Result /= Void
		end

	unescape_cookie_text (a_string: STRING): STRING
			-- Unescapes text for cookie names or values
		require
			a_string_attached: a_string /= Void
		do
			Result := replace (a_string, cookie_escape, True)
		ensure
			result_attached: Result /= Void
		end

	unescape_html (a_string: STRING): STRING
			-- Unescapes html special characters
		require
			a_string_attached: a_string /= Void
		local
			i: INTEGER
			l_tmp_c: STRING
			l_replace: STRING
		do
				Result := a_string.twin
				from
					i := 1
				until
					i > Result.count
				loop
					if Result.at (i).is_equal ('+') then
						Result.replace_substring (" ", i, i)
					end
					if Result.at (i).is_equal ('%%') then
						l_tmp_c := Result.substring (i + 1, i + 2)
						l_replace := hex_to_integer_32 (l_tmp_c).to_character_8.out
						if not l_replace.is_empty then
							Result.replace_substring (l_replace, i, i + 2)
						end
					end
					i := i + 1
				end

		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Interal		

	replace	(a_string: STRING; a_replace_list: ARRAYED_LIST [TUPLE [STRING, STRING]]; a_inv: BOOLEAN): STRING
			-- Replaces all occurrences of first tuple item in a_replace_list with
			-- second tuple item in a_replace_list in a_string. If a_inv is true, the replacement
			-- takes place the other way around. Returns the new string.
		require
			a_string_attached: a_string /= Void
			a_replace_list_attached: a_replace_list /= Void
		do
			Result := a_string.twin
			from
				a_replace_list.start
			until
				a_replace_list.after
			loop
				if attached {STRING} a_replace_list.item [1] as l_replacee and
				 attached {STRING} a_replace_list.item [2] as l_replacer then
					if a_inv then
						Result.replace_substring_all (l_replacer, l_replacee)
					else
						Result.replace_substring_all (l_replacee, l_replacer)
					end

				end
				a_replace_list.forth
			end
		ensure
			result_attached: Result /= Void
		end


	hex_to_integer_32 (s: STRING): INTEGER_32
			-- Hexadecimal string `s' converted to INTEGER_32 value
			-- COPIED FROM $EIFFEL_SRC/eiffel_src/framework/utilities/hexadecimal_string_converter.e
		require
			s_not_void: s /= Void
		local
			i, nb: INTEGER;
			char: CHARACTER
		do
			nb := s.count

			if nb >= 2 and then s.item (2) = 'x' then
				i := 3
			else
				i := 1
			end

			from
			until
				i > nb
			loop
				Result := Result * 16
				char := s.item (i)
				if char >= '0' and then char <= '9' then
					Result := Result + (char |-| '0')
				else
					Result := Result + (char.lower |-| 'a' + 10)
				end
				i := i + 1
			end
		end



end

