note
	description: "Eiffel tests that can be executed by testing tool."
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_CRITERIA_FACTORY

inherit
	EQA_TEST_SET

feature -- Test routines

	impl_test_criteria_from_string (s: READABLE_STRING_GENERAL; fac: CRITERIA_FACTORY [ANY])
		local
			f: detachable CRITERIA [ANY]
			t: READABLE_STRING_32
			p: CRITERIA_PRINTER [ANY]
		do
			f := fac.criteria_from_string (s)
			if f /= Void then
				create p.make_default
				t := p.text (f)
				if not s.same_string (t) then
					f := fac.criteria_from_string (t)
					if f /= Void then
						assert ("criteria string same as source", t.same_string (p.text (f)))
					else
						assert ("criteria string same as source", s.same_string (t))
					end
				end
			else
				assert ("criteria created", False)
			end
		end

	include_all_classes
		do
			-- mainly to include all classes from the library
		end

	test_criteria_from_string
			-- New test routine
		local
			ff: CRITERIA_FACTORY [ANY]
		do
			create ff.make
			impl_test_criteria_from_string ({STRING_32} "not has:foo ", ff)
			impl_test_criteria_from_string ({STRING_32} "not not has:foo ", ff)

			impl_test_criteria_from_string ({STRING_32} "has:foo and tag:oh and not (-is:bar or tag:oups)", ff)
			impl_test_criteria_from_string ({STRING_32} "has:foo and tag:oh and (-is:bar or tag:oups)", ff)

			impl_test_criteria_from_string ({STRING_32} "has:foo -is:%"foo bar%"", ff)

			impl_test_criteria_from_string ({STRING_32} "has:foo and -is:bar", ff)
			impl_test_criteria_from_string ({STRING_32} "has:foo -is:bar", ff)
			impl_test_criteria_from_string ({STRING_32} "has:foo -is:%"foo bar%" and guess:what", ff)

			impl_test_criteria_from_string ({STRING_32} "has:foo or -is:bar", ff)
			impl_test_criteria_from_string ({STRING_32} "has:foo and tag:oh or -is:bar", ff)
			impl_test_criteria_from_string ({STRING_32} "has:foo and tag:oh or -is:bar and tag:oups", ff)
			impl_test_criteria_from_string ({STRING_32} "has:foo and tag:oh and -is:bar or tag:oups", ff)
			impl_test_criteria_from_string ({STRING_32} "has:foo or tag:oh and -is:bar or tag:oups", ff)
		end

	test_criteria_match
		local
			ff: CRITERIA_FACTORY [like new_entry]
			lst: ARRAYED_LIST [like new_entry]
		do
			create ff.make
			ff.register_builder ("state", agent (n,s: READABLE_STRING_32): detachable CRITERIA [like new_entry]
					local
						f_agent: CRITERIA_AGENT [like new_entry]
					do
						create f_agent.make (n + ":" + s, agent (e: like new_entry; b: BOOLEAN): BOOLEAN
								do
									Result := e.state = b
								end (?, s.same_string ("on"))
							)
						Result := f_agent
					end
				)
			ff.register_builder ("is", agent (n,s: READABLE_STRING_32): detachable CRITERIA [like new_entry]
					local
						f_agent: CRITERIA_AGENT [like new_entry]
					do
						create f_agent.make (n + ":" + s, agent (e: like new_entry; k: READABLE_STRING_GENERAL): BOOLEAN
								do
									Result := e.key.same_string (k)
								end (?, s)
							)
						Result := f_agent
					end
				)

			ff.register_builder ("gt", agent (n,s: READABLE_STRING_32): detachable CRITERIA [like new_entry]
					local
						f_agent: CRITERIA_AGENT [like new_entry]
						i: INTEGER
					do
						if s.is_integer then
							i := s.to_integer
							create f_agent.make (n + ":" + s, agent (e: like new_entry; v: INTEGER): BOOLEAN
									do
										Result := e.number > v
									end (?, i)
								)
							Result := f_agent
						end
					end
				)
			ff.register_default_builder ("is")

			create lst.make (10)
			lst.force (new_entry ("a", 1, True))
			lst.force (new_entry ("b", 2, False))
			lst.force (new_entry ("c", 3, True))
			lst.force (new_entry ("d", 4, False))
			lst.force (new_entry ("e", 5, True))


			impl_test_criteria_match (ff, lst, "state:on", [3, "ace"])
			impl_test_criteria_match (ff, lst, "b or c", [2, "bc"])
			impl_test_criteria_match (ff, lst, "is:b or is:c", [2, "bc"])
			impl_test_criteria_match (ff, lst, "is:b +is:c", [2, "bc"])
			impl_test_criteria_match (ff, lst, "is:b   +is:c", [2, "bc"]) -- With spaces
			impl_test_criteria_match (ff, lst, "+is:b +is:c", [2, "bc"])  -- with leading + token
			impl_test_criteria_match (ff, lst, "-is:b +is:c", [4, "acde"])  -- with leading - token
			impl_test_criteria_match (ff, lst, "is:b or +is:c", [2, "bc"]) -- Flexible syntax			
			impl_test_criteria_match (ff, lst, "is:b and +is:c", [0, ""]) -- Flexible syntax
			impl_test_criteria_match (ff, lst, "-is:b and +is:c", [1, "c"])


			impl_test_criteria_match (ff, lst, "gt:4", [1, "e"])
			impl_test_criteria_match (ff, lst, "-state:on and (gt:3 OR is:b)", [2, "bd"])
			impl_test_criteria_match (ff, lst, "not state:on and (gt:3 OR is:b)", [2, "bd"])
		end

	impl_test_criteria_match (ff: CRITERIA_FACTORY [like new_entry]; lst: LIST [like new_entry]; s: READABLE_STRING_32; l_expected: TUPLE [nb: INTEGER; str: STRING])
		do
			if
				attached ff.criteria_from_string (s) as f and then
				attached meet_criteria_list (lst, f) as f_lst
			then
				assert ("has " + l_expected.nb.out + " items", f_lst.count = l_expected.nb and list_to_string (f_lst).same_string (l_expected.str))
			end
		end

	test_foo_criteria
		local
			ff: CRITERIA_FACTORY [FOO]
			lst: ARRAYED_LIST [FOO]
		do
			create ff.make
			ff.register_builder ("foo", agent (n,s: READABLE_STRING_32): detachable CRITERIA [FOO]
					do
						create {FOO_CRITERIA} Result.make (create {BAR}.make (s))
					end
				)

			create lst.make (10)
			lst.force (create {FOO}.make ("A"))
			lst.force (create {FOO}.make ("B"))
			lst.force (create {FOO}.make ("A"))
			lst.force (create {FOO}.make ("B"))
			lst.force (create {FOO}.make ("A"))

			lst.force (create {FOO}.make ("B"))
			lst.force (create {FOO}.make ("C"))
			lst.force (create {FOO}.make ("a"))
			lst.force (create {FOO}.make ("b"))
			lst.force (create {FOO}.make ("c"))

			impl_test_foo_criteria (ff, lst, "foo:B", [3, "BBB"])
			impl_test_foo_criteria (ff, lst, "not foo:B", [7, "AAACabc"])
			impl_test_foo_criteria (ff, lst, "(not foo:B) and (not foo:A)", [4, "Cabc"])
			impl_test_foo_criteria (ff, lst, "foo:b", [1, "b"])
			impl_test_foo_criteria (ff, lst, "bar:foo", [10, "ABABABCabc"])
		end

	impl_test_foo_criteria (ff: CRITERIA_FACTORY [FOO]; lst: LIST [FOO]; s: READABLE_STRING_32; l_expected: TUPLE [nb: INTEGER; str: STRING])
		do
			if
				attached ff.criteria_from_string (s) as f and then
				attached meet_foo_criteria_list (lst, f) as f_lst
			then
				assert ("has " + l_expected.nb.out + " items", f_lst.count = l_expected.nb and list_foo_to_string (f_lst).same_string (l_expected.str))
			end
		end

	list_foo_to_string (lst: LIST [FOO]): STRING_32
		do
			create Result.make (lst.count)
			across
				lst as c
			loop
				Result.append_string_general (c.bar.value)
			end
		end

	meet_foo_criteria_list (lst: LIST [FOO]; f: detachable CRITERIA [FOO]): LIST [FOO]
		do
			if f /= Void then
				create {ARRAYED_LIST [FOO]} Result.make (lst.count)
				across
					lst as c
				loop
					if f.meet (c) then
						Result.extend (c)
					end
				end
			else
				Result := lst
			end
		end

feature -- Implementation

	list_to_string (lst: LIST [like new_entry]): STRING_32
		do
			create Result.make (lst.count)
			across
				lst as c
			loop
				Result.append_string_general (c.key)
			end
		end

	meet_criteria_list (lst: LIST [like new_entry]; f: detachable CRITERIA [like new_entry]): LIST [like new_entry]
		do
			if f /= Void then
				create {ARRAYED_LIST [like new_entry]} Result.make (lst.count)
				across
					lst as c
				loop
					if f.meet (c) then
						Result.extend (c)
					end
				end
			else
				Result := lst
			end
		end

	new_entry (k: READABLE_STRING_GENERAL; a_number: INTEGER; a_state: BOOLEAN): TUPLE [key: READABLE_STRING_GENERAL; number: INTEGER; state: BOOLEAN]
		do
			Result := [k, a_number, a_state]
		end

end


