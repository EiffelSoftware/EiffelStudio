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
			test_is_simple
			test_one_character_root
			test_entry
			test_parent
			test_one_character_entry
			test_extended
			test_absolute
			test_canonical
			test_components
			test_extension
			trailing_slashes_removed
		end

	test_creation
		local
			p, o: PATH
		do
			counter := 0
			create o.make_from_string ("abc")
			p := o.twin
			check_equal ("make_from_string", p.same_as (o))
			check_equal ("make_from_string", p.name.same_string (o.name))

			p := env.current_working_path.twin
			check_equal ("make_from_string", p.same_as (env.current_working_path))
			check_equal ("make_from_string", p.name.same_string (env.current_working_path.name))

			create p.make_from_string ("c:\\\\foo\\\\\bar")
			check_equal ("make_from_string", p.name.same_string_general ("c:\foo\bar"))

			create p.make_from_string ("c:\\\\foo\\\\\bar\")
			check_equal ("make_from_string", p.name.same_string_general ("c:\foo\bar"))

			create p.make_from_string ("c:\\\\foo\\\\\bar\\\\")
			check_equal ("make_from_string", p.name.same_string_general ("c:\foo\bar"))

			create p.make_from_string ("\\server")
			check_equal ("make_from_string", p.name.same_string_general ("\server"))

			create p.make_from_string ("\\server\")
			check_equal ("make_from_string", p.name.same_string_general ("\server"))

			create p.make_from_string ("\\server\\\\\")
			check_equal ("make_from_string", p.name.same_string_general ("\server"))

			create p.make_from_string ("\\server\share")
			check_equal ("make_from_string", p.name.same_string_general ("\\server\share"))

			create p.make_from_string ("\\server\\\\share")
			check_equal ("make_from_string", p.name.same_string_general ("\\server\share"))

			create p.make_from_string ("\\server\share\")
			check_equal ("make_from_string", p.name.same_string_general ("\\server\share\"))

			create p.make_from_string ("\\server\\\\share\")
			check_equal ("make_from_string", p.name.same_string_general ("\\server\share\"))

			create p.make_from_string ("\\server\\\\share\\\\\")
			check_equal ("make_from_string", p.name.same_string_general ("\\server\share\"))

			create p.make_from_string ("\")
			check_equal ("make_from_string", p.name.same_string_general ("\"))

				-- Special case for UNC path.
			create p.make_from_string ("\\")
			check_equal ("make_from_string", p.name.same_string_general ("\"))

			create p.make_from_string ("\\\\\")
			check_equal ("make_from_string", p.name.same_string_general ("\"))
		end

	test_is_simple
		local
			p: PATH
		do
			create p.make_empty
			check_equal ("is_simple", p.is_simple)

			create p.make_current
			check_equal ("is_simple", p.is_simple)

			create p.make_from_string ("abc")
			check_equal ("is_simple", p.is_simple)

			create p.make_from_string ("abc\")
			check_equal ("is_simple", p.is_simple)

			create p.make_from_string ("abc\a")
			check_equal ("is_simple", not p.is_simple)

			create p.make_from_string ("\")
			check_equal ("is_simple", not p.is_simple)
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
			check_equal ("root", attached p.root as l_root and then l_root.name.same_string_general ("\"))
			check_equal ("root", p.has_root)

			create p.make_from_string ("abc\def")
			check_equal ("root", p.root = Void)
			check_equal ("root", not p.has_root)

			create p.make_from_string ("\abc\def")
			check_equal ("root", attached p.root as l_root and then l_root.name.same_string_general ("\"))
			check_equal ("root", p.has_root)

				-- UNC like root
			create p.make_from_string ("\\abc")
			check_equal ("root", attached p.root as l_root and then l_root.name.same_string_general ("\"))
			check_equal ("root", p.has_root)

			create p.make_from_string ("\\abc\def")
			check_equal ("root", attached p.root as l_root and then l_root.same_as (create {PATH}.make_from_string ("\\abc\def")))
			check_equal ("root", p.has_root)

			create p.make_from_string ("\\abc\def\gdb")
			check_equal ("root", attached p.root as l_root and then l_root.same_as (create {PATH}.make_from_string ("\\abc\def\")))
			check_equal ("root", p.has_root)

				-- Drive letter like root
			create p.make_from_string ("c:abc")
			check_equal ("root", attached p.root as l_root and then l_root.same_as (create {PATH}.make_from_string ("c:")))
			check_equal ("root", p.has_root)

			create p.make_from_string ("c:\abc")
			check_equal ("root", attached p.root as l_root and then l_root.same_as (create {PATH}.make_from_string ("c:\")))
			check_equal ("root", p.has_root)

			create p.make_from_string ("c:abc\def")
			check_equal ("root", attached p.root as l_root and then l_root.same_as (create {PATH}.make_from_string ("c:")))
			check_equal ("root", p.has_root)

			create p.make_from_string ("c:\abc\def")
			check_equal ("root", attached p.root as l_root and then l_root.same_as (create {PATH}.make_from_string ("c:\")))
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
			check_equal ("root", attached p.root as l_root and then l_root.name.same_string_general ("\"))
			check_equal ("root", p.has_root)

			create p.make_from_string ("a\b")
			check_equal ("root", p.root = Void)
			check_equal ("root", not p.has_root)

			create p.make_from_string ("\a\b")
			check_equal ("root", attached p.root as l_root and then l_root.name.same_string_general ("\"))
			check_equal ("root", p.has_root)

				-- UNC like root
			create p.make_from_string ("\\a")
			check_equal ("root", attached p.root as l_root and then l_root.name.same_string_general ("\"))
			check_equal ("root", p.has_root)

			create p.make_from_string ("\\a\b")
			check_equal ("root", attached p.root as l_root and then l_root.same_as (create {PATH}.make_from_string ("\\a\b")))
			check_equal ("root", p.has_root)

			create p.make_from_string ("\\a\b\c")
			check_equal ("root", attached p.root as l_root and then l_root.same_as (create {PATH}.make_from_string ("\\a\b\")))
			check_equal ("root", p.has_root)

				-- Drive letter like root
			create p.make_from_string ("c:a")
			check_equal ("root", attached p.root as l_root and then l_root.same_as (create {PATH}.make_from_string ("c:")))
			check_equal ("root", p.has_root)

			create p.make_from_string ("c:\a")
			check_equal ("root", attached p.root as l_root and then l_root.same_as (create {PATH}.make_from_string ("c:\")))
			check_equal ("root", p.has_root)

			create p.make_from_string ("c:a\b")
			check_equal ("root", attached p.root as l_root and then l_root.same_as (create {PATH}.make_from_string ("c:")))
			check_equal ("root", p.has_root)

			create p.make_from_string ("c:\a\b")
			check_equal ("root", attached p.root as l_root and then l_root.same_as (create {PATH}.make_from_string ("c:\")))
			check_equal ("root", p.has_root)
		end

	test_entry
		local
			p: PATH
			s: STRING_32
		do
			counter := 0
				-- No root.
			create p.make_from_string ("abc")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("abc")))

			create p.make_from_string ("abc\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("abc")))

			create p.make_from_string ("\abc")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("abc")))

			create p.make_from_string ("\abc\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("abc")))

			create p.make_from_string ("abc\def")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("def")))

			create p.make_from_string ("abc\def\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("def")))

			create p.make_from_string ("\abc\def")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("def")))

			create p.make_from_string ("\abc\def\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("def")))

				-- UNC like root
			create p.make_from_string ("\\abc")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("abc")))

			create p.make_from_string ("\\abc\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("abc")))

			create p.make_from_string ("\\abc\def")
			check_equal ("entry", p.entry = Void)

			create p.make_from_string ("\\abc\def\")
			check_equal ("entry", p.entry = Void)

			create p.make_from_string ("\\abc\def\gdb")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("gdb")))

			create p.make_from_string ("\\abc\def\gdb\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("gdb")))

				-- Drive letter like root
			create p.make_from_string ("c:abc")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("abc")))

			create p.make_from_string ("c:abc\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("abc")))

			create p.make_from_string ("c:\abc")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("abc")))

			create p.make_from_string ("c:\abc\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("abc")))

			create p.make_from_string ("c:abc\def")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("def")))

			create p.make_from_string ("c:abc\def\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("def")))

			create p.make_from_string ("c:\abc\def")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("def")))

			create p.make_from_string ("c:\abc\def\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("def")))

			create s.make (2)
			s.append_string_general ("C:\")
			s.append_character ('%/119070/')
			s.append_string_general ("\calc")
			create p.make_from_string (s)
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("calc")))

			create s.make (2)
			s.append_string_general ("C:\")
			s.append_character ('%/119070/')
			s.append_string_general ("\calc\calc.ecf")
			create p.make_from_string (s)
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("calc.ecf")))
		end

	test_one_character_entry
		local
			p: PATH
		do
			counter := 0
				-- No root.
			create p.make_from_string ("a")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("a")))

			create p.make_from_string ("a\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("a")))

			create p.make_from_string ("\a")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("a")))

			create p.make_from_string ("\a\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("a")))

			create p.make_from_string ("a\b")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("b")))

			create p.make_from_string ("a\b\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("b")))

			create p.make_from_string ("\a\b")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("b")))

			create p.make_from_string ("\a\b\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("b")))

				-- UNC like root
			create p.make_from_string ("\\a")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("a")))

			create p.make_from_string ("\\a\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("a")))

			create p.make_from_string ("\\a\b")
			check_equal ("entry", p.entry = Void)

			create p.make_from_string ("\\a\b\")
			check_equal ("entry", p.entry = Void)

			create p.make_from_string ("\\a\b\c")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("c")))

			create p.make_from_string ("\\a\b\c\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("c")))

				-- Drive letter like root
			create p.make_from_string ("c:a")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("a")))

			create p.make_from_string ("c:a\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("a")))

			create p.make_from_string ("c:\a")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("a")))

			create p.make_from_string ("c:\a\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("a")))

			create p.make_from_string ("c:a\b")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("b")))

			create p.make_from_string ("c:a\b\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("b")))

			create p.make_from_string ("c:\a\b")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("b")))

			create p.make_from_string ("c:\a\b\")
			check_equal ("entry", attached p.entry as l_entry and then l_entry.same_as (create {PATH}.make_from_string ("b")))
		end

	test_parent
		local
			p: PATH
			s: STRING_32
		do
			counter := 0
				-- No root.
			create p.make_from_string ("abc")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_current))

			create p.make_from_string ("abc\")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_current))

			create p.make_from_string ("\abc")
			check_equal ("parent", attached p.root as l_root and then l_root.name.same_string_general ("\"))
			check_equal ("parent", p.parent.same_as (p.root))

			create p.make_from_string ("\abc\")
			check_equal ("parent", attached p.root as l_root and then l_root.name.same_string_general ("\"))
			check_equal ("parent", p.parent.same_as (p.root))

			create p.make_from_string ("abc\def")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("abc")))

			create p.make_from_string ("abc\def\")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("abc")))

			create p.make_from_string ("\abc\def")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("\abc")))

			create p.make_from_string ("\abc\def\")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("\abc")))

				-- Simple root
			create p.make_from_string ("\")
			check_equal ("parent", p.parent.same_as (p.root))

				-- UNC like root
			create p.make_from_string ("\\abc")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("\")))

			create p.make_from_string ("\\abc\")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("\")))

			create p.make_from_string ("\\abc\def")
			check_equal ("parent", p.parent.same_as (p))

			create p.make_from_string ("\\abc\def\")
			check_equal ("parent", p.parent.same_as (p))

			create p.make_from_string ("\\abc\def\gdb")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("\\abc\def\")))

			create p.make_from_string ("\\abc\def\gdb\")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("\\abc\def\")))

				-- Drive letter like root
			create p.make_from_string ("c:abc")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("c:")))

			create p.make_from_string ("c:abc\")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("c:")))

			create p.make_from_string ("c:\abc")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("c:\")))

			create p.make_from_string ("c:\abc\")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("c:\")))

			create p.make_from_string ("c:abc\def")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("c:abc")))

			create p.make_from_string ("c:abc\def\")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("c:abc")))

			create p.make_from_string ("c:\abc\def")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("c:\abc")))

			create p.make_from_string ("c:\abc\def\")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string ("c:\abc")))

			create s.make (2)
			s.append_string_general ("C:\")
			s.append_character ('%/119070/')
			s.append_string_general ("\calc")
			create p.make_from_string (s)
			p := p.extended ("calc.ecf")
			check_equal ("parent", p.parent.same_as (create {PATH}.make_from_string (s)))
		end

	test_extended
		local
			p, o: PATH
		do
			counter := 0
			create p.make_from_string ("C:")
			create o.make_from_string ("abc.txt")
			check_equal ("extended", p.extended (o.name).name.same_string_general ("C:abc.txt"))
			check_equal ("extended", p.extended_path (o).name.same_string_general ("C:abc.txt"))

			create p.make_from_string ("C:\")
			check_equal ("extended", p.extended (o.name).name.same_string_general ("C:\abc.txt"))
			check_equal ("extended", p.extended_path (o).name.same_string_general ("C:\abc.txt"))

			create p.make_empty
			check_equal ("extended", p.extended (o.name).name.same_string_general ("abc.txt"))
			check_equal ("extended", p.extended_path (o).name.same_string_general ("abc.txt"))

			create p.make_empty
			create o.make_from_string ("\abc.txt")
			check_equal ("extended", p.extended (o.name).name.same_string_general ("\abc.txt"))
			check_equal ("extended", p.extended_path (o).name.same_string_general ("\abc.txt"))

			create p.make_empty
			create o.make_from_string ("abc")
			p := p.extended ("\abc")
			check_equal ("extended", p.extended (o.name).name.same_string_general ("\abc\abc"))
			check_equal ("extended", p.extended_path (o).name.same_string_general ("\abc\abc"))

			create p.make_empty
			create o.make_from_string ("abc\abc\abc")
			check_equal ("extended", p.extended (o.name).name.same_string_general ("abc\abc\abc"))
			check_equal ("extended", p.extended_path (o).name.same_string_general ("abc\abc\abc"))
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

			create p.make_from_string ("C:abc.txt")
			create current_path.make_from_string ("C:\foo\bar")
			check_equal ("absolute_in", p.absolute_path_in (current_path).name.same_string (current_path.name + "\" + "abc.txt"))
		end

	test_canonical
		local
			s: STRING_32
			p: PATH
		do
			create s.make (2)
			s.append_string_general ("C:\")
			s.append_character ('%/119070/')
			s.append_string_general ("\calc\calc.ecf")
			create p.make_from_string (s)
			check_equal ("entry", (create {PATH}.make_from_string ("calc.ecf")).same_as (p.entry))

			check_equal ("canonical_path", p.canonical_path.same_as (p))
		end

	test_components
		local
			p: PATH
		do
			create p.make_empty
			check_equal ("components", p.components.is_empty)

			create p.make_from_string ("\")
			check_equal ("components", p.components.count = 1)
			check_equal ("components", p.components.first.same_as (p))

			create p.make_from_string ("C:")
			check_equal ("components", p.components.count = 1)
			check_equal ("components", p.components.first.same_as (p))
			check_equal ("components", p.components.first.name.same_string_general ("C:"))

			create p.make_from_string ("C:\a\b")
			check_equal ("components", p.components.count = 3)
			check_equal ("components", p.components.i_th (1).same_as (p.root))
			check_equal ("components", p.components.first.name.same_string_general ("C:\"))
			check_equal ("components", p.components.i_th (1).name.same_string_general ("C:\"))
			check_equal ("components", p.components.i_th (2).name.same_string_general ("a"))
			check_equal ("components", p.components.i_th (3).name.same_string_general ("b"))

			create p.make_from_string ("C:a\b")
			check_equal ("components", p.components.count = 3)
			check_equal ("components", p.components.i_th (1).same_as (p.root))
			check_equal ("components", p.components.first.name.same_string_general ("C:"))
			check_equal ("components", p.components.i_th (1).name.same_string_general ("C:"))
			check_equal ("components", p.components.i_th (2).name.same_string_general ("a"))
			check_equal ("components", p.components.i_th (3).name.same_string_general ("b"))

			create p.make_from_string ("\\server\share")
			check_equal ("components", p.components.count = 1)
			check_equal ("components", p.components.i_th (1).same_as (p.root))
			check_equal ("components", p.components.i_th (1).name.same_string_general ("\\server\share"))

			create p.make_from_string ("\\server\share\")
			check_equal ("components", p.components.count = 1)
			check_equal ("components", p.components.i_th (1).same_as (p.root))
			check_equal ("components", p.components.i_th (1).name.same_string_general ("\\server\share\"))

			create p.make_from_string ("\\server\share\a")
			check_equal ("components", p.components.count = 2)
			check_equal ("components", p.components.i_th (1).same_as (p.root))
			check_equal ("components", p.components.i_th (1).name.same_string_general ("\\server\share\"))
			check_equal ("components", p.components.i_th (2).name.same_string_general ("a"))
		end

	test_extension
		local
			p: PATH
		do
			create p.make_empty
			check_equal ("extension", not p.has_extension ("some"))
			check_equal ("extension", p.extension = Void)

			create p.make_from_string (".")
			check_equal ("extension", not p.has_extension ("some"))
			check_equal ("extension", p.extension = Void)

			create p.make_from_string ("..")
			check_equal ("extension", not p.has_extension ("some"))
			check_equal ("extension", p.extension = Void)

			create p.make_from_string (".a")
			check_equal ("extension", p.has_extension ("a"))
			check_equal ("extension", not p.has_extension ("b"))
			check_equal ("extension", attached p.extension as l_ext and then l_ext.same_string_general ("a"))

			create p.make_from_string ("file.a")
			check_equal ("extension", p.has_extension ("a"))
			check_equal ("extension", not p.has_extension ("b"))
			check_equal ("extension", attached p.extension as l_ext and then l_ext.same_string_general ("a"))

			create p.make_from_string ("other.file.a")
			check_equal ("extension", p.has_extension ("a"))
			check_equal ("extension", not p.has_extension ("b"))
			check_equal ("extension", attached p.extension as l_ext and then l_ext.same_string_general ("a"))

			create p.make_from_string ("\\server\share\file.a")
			check_equal ("extension", p.has_extension ("a"))
			check_equal ("extension", not p.has_extension ("b"))
			check_equal ("extension", attached p.extension as l_ext and then l_ext.same_string_general ("a"))

			create p.make_from_string ("c:file.a")
			check_equal ("extension", p.has_extension ("a"))
			check_equal ("extension", not p.has_extension ("b"))
			check_equal ("extension", attached p.extension as l_ext and then l_ext.same_string_general ("a"))

			create p.make_from_string ("c:\file.a")
			check_equal ("extension", p.has_extension ("a"))
			check_equal ("extension", not p.has_extension ("b"))
			check_equal ("extension", attached p.extension as l_ext and then l_ext.same_string_general ("a"))
		end

	trailing_slashes_removed
			-- Verify that we always remove trailing directory separator
		local
			p: PATH
		do
			counter := 0
			create p.make_from_string ("abc\")
			check_equal ("slashes", p.name.same_string_general ("abc"))
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

