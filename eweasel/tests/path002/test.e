class TEST

create
	make
feature

	make
		local
			p: PATH
		do
			p := env.current_working_path
			test_creation
			test_root
			test_one_character_root
			test_entry
			test_one_character_entry
			test_extended
			test_absolute
			trailing_slashes_removed
		end

	test_creation
		local
			p, o: PATH
		do
			counter := 0
			create o.make_from_string ("abc")
			create p.make_from_path (o)
			check_equal ("make_from_path", p ~ o)
			check_equal ("make_from_path", p.name ~ o.name)

			create p.make_from_path (env.current_working_path)
			check_equal ("make_from_path", p ~ env.current_working_path)
			check_equal ("make_from_path", p.name ~ env.current_working_path.name)

		end

	test_root
		local
			p: PATH
		do
			counter := 0
				-- No root.
			create p.make_from_string ("abc")
			check_equal ("root", p.root = Void)
			check_equal ("root", not p.has_root)

			create p.make_from_string ("\abc")
			check_equal ("root", p.root = Void)
			check_equal ("root", not p.has_root)

			create p.make_from_string ("abc\def")
			check_equal ("root", p.root = Void)
			check_equal ("root", not p.has_root)

			create p.make_from_string ("\abc\def")
			check_equal ("root", p.root = Void)
			check_equal ("root", not p.has_root)

				-- UNC like root
			create p.make_from_string ("\\abc")
			check_equal ("root", p.root = Void)
			check_equal ("root", not p.has_root)

			create p.make_from_string ("\\abc\def")
			check_equal ("root", p.root ~ create {PATH}.make_from_string ("\\abc\def"))
			check_equal ("root", p.has_root)

			create p.make_from_string ("\\abc\def\gdb")
			check_equal ("root", p.root ~ create {PATH}.make_from_string ("\\abc\def"))
			check_equal ("root", p.has_root)

				-- Drive letter like root
			create p.make_from_string ("c:abc")
			check_equal ("root", p.root ~ create {PATH}.make_from_string ("c:"))
			check_equal ("root", p.has_root)

			create p.make_from_string ("c:\abc")
			check_equal ("root", p.root ~ create {PATH}.make_from_string ("c:\"))
			check_equal ("root", p.has_root)

			create p.make_from_string ("c:abc\def")
			check_equal ("root", p.root ~ create {PATH}.make_from_string ("c:"))
			check_equal ("root", p.has_root)

			create p.make_from_string ("c:\abc\def")
			check_equal ("root", p.root ~ create {PATH}.make_from_string ("c:\"))
			check_equal ("root", p.has_root)
		end

	test_one_character_root
		local
			p: PATH
		do
			counter := 0
				-- No root.
			create p.make_from_string ("a")
			check_equal ("root", p.root = Void)
			check_equal ("root", not p.has_root)

			create p.make_from_string ("\a")
			check_equal ("root", p.root = Void)
			check_equal ("root", not p.has_root)

			create p.make_from_string ("a\b")
			check_equal ("root", p.root = Void)
			check_equal ("root", not p.has_root)

			create p.make_from_string ("\a\b")
			check_equal ("root", p.root = Void)
			check_equal ("root", not p.has_root)

				-- UNC like root
			create p.make_from_string ("\\a")
			check_equal ("root", p.root = Void)
			check_equal ("root", not p.has_root)

			create p.make_from_string ("\\a\b")
			check_equal ("root", p.root ~ create {PATH}.make_from_string ("\\a\b"))
			check_equal ("root", p.has_root)

			create p.make_from_string ("\\a\b\c")
			check_equal ("root", p.root ~ create {PATH}.make_from_string ("\\a\b"))
			check_equal ("root", p.has_root)

				-- Drive letter like root
			create p.make_from_string ("c:a")
			check_equal ("root", p.root ~ create {PATH}.make_from_string ("c:"))
			check_equal ("root", p.has_root)

			create p.make_from_string ("c:\a")
			check_equal ("root", p.root ~ create {PATH}.make_from_string ("c:\"))
			check_equal ("root", p.has_root)

			create p.make_from_string ("c:a\b")
			check_equal ("root", p.root ~ create {PATH}.make_from_string ("c:"))
			check_equal ("root", p.has_root)

			create p.make_from_string ("c:\a\b")
			check_equal ("root", p.root ~ create {PATH}.make_from_string ("c:\"))
			check_equal ("root", p.has_root)
		end

	test_entry
		local
			p: PATH
		do
			counter := 0
				-- No root.
			create p.make_from_string ("abc")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("abc"))

			create p.make_from_string ("abc\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("abc"))

			create p.make_from_string ("\abc")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("abc"))

			create p.make_from_string ("\abc\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("abc"))

			create p.make_from_string ("abc\def")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("def"))

			create p.make_from_string ("abc\def\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("def"))

			create p.make_from_string ("\abc\def")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("def"))

			create p.make_from_string ("\abc\def\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("def"))

				-- UNC like root
			create p.make_from_string ("\\abc")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("abc"))

			create p.make_from_string ("\\abc\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("abc"))

			create p.make_from_string ("\\abc\def")
			check_equal ("entry", p.entry = Void)

			create p.make_from_string ("\\abc\def\")
			check_equal ("entry", p.entry = Void)

			create p.make_from_string ("\\abc\def\gdb")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("gdb"))

			create p.make_from_string ("\\abc\def\gdb\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("gdb"))

				-- Drive letter like root
			create p.make_from_string ("c:abc")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("abc"))

			create p.make_from_string ("c:abc\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("abc"))

			create p.make_from_string ("c:\abc")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("abc"))

			create p.make_from_string ("c:\abc\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("abc"))

			create p.make_from_string ("c:abc\def")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("def"))

			create p.make_from_string ("c:abc\def\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("def"))

			create p.make_from_string ("c:\abc\def")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("def"))

			create p.make_from_string ("c:\abc\def\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("def"))
		end

	test_one_character_entry
		local
			p: PATH
		do
			counter := 0
				-- No root.
			create p.make_from_string ("a")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("a"))

			create p.make_from_string ("a\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("a"))

			create p.make_from_string ("\a")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("a"))

			create p.make_from_string ("\a\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("a"))

			create p.make_from_string ("a\b")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("b"))

			create p.make_from_string ("a\b\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("b"))

			create p.make_from_string ("\a\b")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("b"))

			create p.make_from_string ("\a\b\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("b"))

				-- UNC like root
			create p.make_from_string ("\\a")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("a"))

			create p.make_from_string ("\\a\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("a"))

			create p.make_from_string ("\\a\b")
			check_equal ("entry", p.entry = Void)

			create p.make_from_string ("\\a\b\")
			check_equal ("entry", p.entry = Void)

			create p.make_from_string ("\\a\b\c")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("c"))

			create p.make_from_string ("\\a\b\c\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("c"))

				-- Drive letter like root
			create p.make_from_string ("c:a")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("a"))

			create p.make_from_string ("c:a\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("a"))

			create p.make_from_string ("c:\a")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("a"))

			create p.make_from_string ("c:\a\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("a"))

			create p.make_from_string ("c:a\b")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("b"))

			create p.make_from_string ("c:a\b\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("b"))

			create p.make_from_string ("c:\a\b")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("b"))

			create p.make_from_string ("c:\a\b\")
			check_equal ("entry", p.entry ~ create {PATH}.make_from_string ("b"))
		end

	test_extended
		local
			p: PATH
		do
			counter := 0
			create p.make_from_string ("C:")
			p := p.extended ("abc.txt")
			check_equal ("extended", p ~ create {PATH}.make_from_string ("C:\abc.txt"))
		end

	test_absolute
		local
			p: PATH
			current_path: PATH
		do
			counter := 0
			current_path := env.current_working_path
			create p.make_from_string ("abc.txt")
			check_equal ("absolute", p.absolute_path.name.same_string (current_path.name + "\" + p.name))
		end

	trailing_slashes_removed
			-- Verify that we always remove trailing directory separator
		local
			p: PATH
		do
			counter := 0
			create p.make_from_string ("abc\")
			check_equal ("slashes", p.name ~ {STRING_32} "abc")
		end

	env: EXECUTION_ENVIRONMENT
		once
			create Result
		end

	counter: INTEGER
			-- Counter to easily identify point of failure.

	check_equal (tag: STRING; b: BOOLEAN)
		do
			counter := counter + 1
			if not b then
				io.put_string ("Error in " + tag + " for iteration #" + counter.out)
				io.put_new_line
			end
		end
end
