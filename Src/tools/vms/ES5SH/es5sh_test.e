indexing
    description: "Tester facilities for ES5SH"
    author: "David Schwartz"
    original: 01,Jan,1995
    last: 22,Aug,1998
    modified_by: "David Schwartz (ds), VMS diehard"

class ES5SH_TEST

inherit
	ES5SH
		rename test as es5sh_test
	end

feature

    test (a_verbose: BOOLEAN) is
    	local
    		l_msg: STRING
		do
		    count := 0; passed := 0; failed := 0
		    test_all_vms_filespec (a_verbose)
		    test_all_is_relative_filespec (a_verbose)
		    test_all_dirname_basename (a_verbose)
		    l_msg := total_count.out + " tests run; " + total_passed.out + " passed, " + total_failed.out + " failed"
		    if total_failed > 0 then
		    	print ("Error: " + l_msg + "!%N")
		    else
		    	print (l_msg + ".%N")
		    end
		end


    test_all_dirname_basename (a_verbose: BOOLEAN) is
		do
			reset_counts
		    print (" test dirname_basename: "+ dirname_basename_test_cases.count.out + " test cases.%N")
		    dirname_basename_test_cases.do_all (agent test_dirname_basename_case (a_verbose, ?))
		    if failed > 0 or else True then
				print ("Results: " + passed.out + " passed, " + failed.out + " failed.%N%N")
		    else
				print ("Results: " + passed.out + " passed, none failed.%N%N")
		    end
		end


    test_dirname_basename_case (a_verbose: BOOLEAN; a_test_case: TUPLE [STRING,STRING,STRING]) is
		local
		    l_filespec, l_expected_dirname, l_expected_basename: STRING
		    l_dirname, l_basename: STRING
		do
		    l_filespec ?= a_test_case @ 1
		    l_expected_dirname ?= a_test_case @ 2
		    l_expected_basename ?= a_test_case @ 3
		    print ("  test case: '" + l_filespec + "' -- expect dirname: '" + l_expected_dirname + "', basename: '" + l_expected_basename + "'  -- ")
		    l_dirname := dirname (l_filespec)
		    l_basename := basename (l_filespec)
		    if not l_dirname.is_equal (l_expected_dirname) or else not l_basename.is_equal (l_expected_basename) then
				failed := failed + 1
				print (" FAILED.%N      ")
				if not l_dirname.is_equal (l_expected_dirname) then
				    print ("actual dirname: '" + l_dirname + "'   ")
				end
				if not l_basename.is_equal (l_expected_basename) then
				    print ("actual basename: '" + l_basename + "'   ")
				end
				print ("%N")
		    else
				passed := passed + 1
				print (" passed.%N")
		    end
		end


    test_all_vms_filespec (a_verbose: BOOLEAN) is
		local
		    --l_foo: EXTENDABLE_BOUNDED_ARRAY[BOOLEAN]
		    --l_bar: ROSE_LINEAR_ARRAY[INTEGER]
		do
		    reset_counts
		    print (" test as_vms_filespec: " + vms_filespec_test_cases.count.out + " test cases.%N")
		    vms_filespec_test_cases.do_all (agent test_vms_filespec_case (a_verbose, ?))
		    if failed > 0 or else True then
				print ("Results: " + passed.out + " passed, " + failed.out + " failed.%N%N")
		    else
				print ("Results: " + passed.out + " passed, none failed.%N%N")
		    end
		end


    test_vms_filespec_case (a_verbose: BOOLEAN; a_test_case: TUPLE [STRING,STRING]) is
		local
		    l_test, l_test_copy, l_expected, l_actual: STRING
		do
		    count := count + 1
		    l_test ?= a_test_case.item(1)
		    l_test_copy := l_test.twin
		    l_expected ?= a_test_case.item(2)
		    print ("  test case: transform '" + l_test + "' ==> '" + l_expected + "'  -- ")
		    l_actual := as_vms_filespec (l_test)
		    if not l_actual.is_equal (l_expected) or else not l_test.is_equal (l_test_copy) then
				failed := failed + 1
				if not l_actual.is_equal (l_expected) then
				    print (" FAILED: actual result: '" + l_actual + "'%N")
				elseif not l_test.is_equal (l_test_copy) then
				    print (" FAILED: input changed to: '" + l_test + "'%N")
				else
				    print (" UNSPECIFIED ERROR!%N")
				end
		    else
				print (" passed.%N")
				passed := passed + 1
		    end
		end

    test_all_is_relative_filespec (a_verbose: BOOLEAN) is
		local
		do
		    reset_counts
		    print (" test is_relative_filespec: " + is_relative_filespec_test_cases.count.out + " test cases.%N")
		    is_relative_filespec_test_cases.do_all (agent test_is_relative_filespec_case (a_verbose, ?))
		    if failed > 0 or else True then
				print ("Results: " + passed.out + " passed, " + failed.out + " failed.%N%N")
		    else
				print ("Results: " + passed.out + " passed, none failed.%N%N")
		    end
		end


    test_is_relative_filespec_case (a_verbose: BOOLEAN; a_test_case: TUPLE [STRING, BOOLEAN]) is
		local
		    l_test: STRING
		    l_expected, l_actual: BOOLEAN
		    l_bool: BOOLEAN_REF
		do
		    count := count + 1
		    l_test ?= a_test_case.item(1)
		    l_bool ?= a_test_case.item(2)
		    if l_bool /= Void then
				l_expected := l_bool.item
		    end
		    print ("  test case: is_relative: '" + l_test + "' : " + l_expected.out + "  -- ")
		    l_actual := is_relative_filespec (l_test)
		    if l_actual /= l_expected then
				failed := failed + 1
				print (" FAILED: actual result: " + l_actual.out + "%N")
		    else
				print (" passed.%N")
				passed := passed + 1
		    end
		end

feature
    count, passed, failed: INTEGER
    total_count, total_failed, total_passed: INTEGER

    reset_counts is
    	do
			total_count := total_count + count
		    total_passed := total_passed + passed
		    total_failed := total_failed + failed
		    count := 0; passed := 0; failed := 0
    	end


    vms_filespec_test_cases: ARRAY [ TUPLE [ STRING,STRING ] ] is
		once
			-- notes: a:b == a:[]b: "/a/b" ==> "a:b (a:[]b)
		    create Result.make_from_array ( <<
		    	["", ""],
		    	-- FAILS: [".", "[]"], ["a\", "[.a]"], ["\a",       "a:"    ],
				["a",       "a"      ], ["a/",       "[.a]"    ], ["/a",       "a:"    ], ["/a/",      "a:[]"    ],
				["$(a)",    "a:"     ], ["$(a)/",    "a:[]"    ], ["/$(a)",    "a:"    ], ["/$(a)/",   "a:[]"    ],
				["a/b",     "[.a]b"  ], ["a/b/",     "[.a.b]"  ], ["/a/b",     "a:b"   ], ["/a/b/",    "a:[b]"   ],
				["$(a)/b",  "a:b"    ], ["$(a)/b/",  "a:[b]"   ], ["/$(a)/b",  "a:b"   ], ["/$(a)/b/", "a:[b]"   ],
				["a/b/c",   "[.a.b]c"], ["a/b/c/",   "[.a.b.c]"], ["/a/b/c",   "a:[b]c"], ["/a/b/c/",  "a:[b.c]" ],
				["$(a)/b/c","a:[b]c" ], ["$(a)/b/c/","a:[b.c]" ], ["/$(a)/b/c","a:[b]c"], ["$(a)/b/c/","a:[b.c]" ],
				["c:\temp\", "c:[temp]"], ["c:\temp", "c:temp"], ["c:\temp\foo.bar", "c:[temp]foo.bar"]
				-- ***FIXME*** add test cases for . ==> [], ./ ==> [], ./a ==> []a, ./a/ ==> [.a]
			>> )
		end

    is_relative_filespec_test_cases: ROSE_LINEAR_ARRAY [ TUPLE [ STRING,BOOLEAN ] ] is
		once
		    create Result.make_from_array ( <<
			    	["",True], [".",True], ["a",True], ["./a",True], ["./a/",True],
					["/",False], ["/a",False], ["/a/",False],
					["[]",True], ["[.a]",True], ["[.a]b",True],
					["a:",True], ["a:[]",True], ["a:[.b]",True],
					["[a]",False], ["a:[b]",False], ["[b]",False],
					["c:\temp\foo", False], ["\temp\foo.bar", True], ["c:temp", True], ["temp\", True]
				>> )
		end

    dirname_basename_test_cases: ROSE_LINEAR_ARRAY [ TUPLE [STRING, STRING, STRING] ] is
		once
		    create Result.make_from_array ( << ["","",""], ["/", "/", ""],
				["a", "", "a"], ["a/", "a/", ""], ["a/b", "a/", "b"],
				[":", ":", ""], ["[a]","[a]",""], ["[a]b", "[a]", "b"],
				["a:", "a:", ""], ["a:[b.c]d.e", "a:[b.c]", "d.e"] >> )
		end

--|--------------------------------------------------------------------------
--
-- History:
--
-- 28-Nov-2004	add test facility for dirname, basename
--
-- 19-Oct-2004	add test facility for is_relative_filespec
--
--|--------------------------------------------------------------------------

end -- ES5SH_TEST

