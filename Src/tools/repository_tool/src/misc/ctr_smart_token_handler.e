note
	description: "Summary description for {CTR_SMART_TOKEN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_SMART_TOKEN_HANDLER

feature -- Access

	smart_token_occurrences (a_log: REPOSITORY_LOG; a_token: detachable STRING; a_patterns: detachable ARRAY [detachable STRING]): detachable HASH_TABLE [detachable LIST [STRING], STRING]
		local
			mesg: STRING
			lst: detachable LIST [STRING]
			l_matches: HASH_TABLE [detachable LIST [STRING], STRING]
			t: like smart_pattern_computation
			i, n: INTEGER
		do
			if a_patterns /= Void and then a_patterns.count > 0 then
				if a_token /= Void then
					create l_matches.make (1)
				else
					create l_matches.make (a_patterns.count)
				end
				l_matches.compare_objects
				Result := l_matches
				from
					i := a_patterns.lower
					n := a_patterns.upper
					mesg := a_log.message
				until
					i > n
				loop
					if
						attached a_patterns[i] as k and then
						(a_token = Void or else a_token.is_case_insensitive_equal (k))
					then
						t := smart_pattern_computation (mesg, k)
						mesg := t.mesg
						lst := t.lst
						if lst /= Void and then lst.count > 0 then
							l_matches.force (lst, k)
						end
					end
					i := i + 1
				end
			end
		end

	smart_log_message (a_log: REPOSITORY_LOG; a_patterns: detachable ARRAY [detachable STRING]): TUPLE [message: STRING; matches: HASH_TABLE [detachable LIST [STRING], STRING]]
		local
			mesg: STRING
			lst: detachable LIST [STRING]
			l_matches: HASH_TABLE [detachable LIST [STRING], STRING]
			t: like smart_pattern_computation
			i, n: INTEGER
		do
			if a_patterns /= Void then
				create l_matches.make (a_patterns.count)
			else
				create l_matches.make (0)
			end
			Result := [a_log.message, l_matches] --| message, matches |--
			if a_patterns /= Void and then a_patterns.count > 0 then
				from
					i := a_patterns.lower
					n := a_patterns.upper
					mesg := a_log.message
				until
					i > n
				loop
					if attached a_patterns[i] as k then
						t := smart_pattern_computation (mesg, k)
						mesg := t.mesg
						lst := t.lst
						if lst /= Void and then lst.count > 0 then
							l_matches.force (lst, k)
						end
					end
					i := i + 1
				end
				Result.message := mesg
			end
		end

feature {NONE} -- Implementation

	smart_pattern_computation (m: STRING; k: STRING): TUPLE [mesg: STRING; lst: detachable LIST [STRING]]
		require
			m_attached: m /= Void
			k_not_empty: k /= Void and then k.count > 0
		local
			klen, n,d,e,i,p: INTEGER
			s: STRING
			mesg: STRING
			lst: detachable ARRAYED_LIST [STRING]
		do
			from
				n := m.count
				klen := k.count
				create mesg.make (n)
				create lst.make (1)
				i := 1
				p := 1
			until
				p > n
			loop
				i := m.substring_index (k, p)
				if i > 0 then
						--| skip space					
					from
						d := i + klen
					until
						d > n or else (m[d] = '#' or not m[d].is_space)
					loop
						d := d + 1
					end
					if m[d] = '#' then
						--| Found k + " #"						

						--| skip space
						from
							e := d + 1
						until
							e > n or else not m[e].is_space
						loop
							e := e + 1
						end
						--| get word
						from
							create s.make_empty
						until
							e > n or else not m[e].is_alpha_numeric
						loop
							s.extend (m[e])
							e := e + 1
						end
						if not s.is_empty then
							mesg.append_string (m.substring (p, e.min (n)))
							lst.force (s)
							p := e + 1
						else
							mesg.append_string (m.substring (p, d))
							p := d + 1
						end
					else
						mesg.append_string (m.substring (p, i + klen))
						p := i + 4
					end
				else
					mesg.append_string (m.substring (p, n))
					p := n + 1
				end
			end
			if lst.count = 0 then
				lst := Void
			end
			Result := [mesg, lst]
		end


end
