indexing

	description:

		"Kernel test cases"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class KL_TEST_CASE

inherit

	TS_TEST_CASE
		redefine
			tear_down, set_up
		end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

feature -- Filenames

	new_filename (a_prefix, an_extension: STRING): STRING is
			-- New unique filename
		require
			a_prefix_not_void: a_prefix /= Void
			an_extension_not_void: an_extension /= Void
		local
			nb: INTEGER
		do
			from
				nb := counter.item + 1
				counter.put (nb)
				Result := a_prefix + nb.out + an_extension
			until
				not file_system.file_exists (Result)
			loop
				nb := counter.item + 1
				counter.put (nb)
				Result := a_prefix + nb.out + an_extension
			end
		ensure
			filename_not_void: Result /= Void
		end

	booleans_filename: STRING is
			-- Full filename of "booleans.txt"
		once
			Result := file_system.pathname (data_dirname, "booleans.txt")
		ensure
			booleans_filename_not_void: Result /= Void
		end

	empty_filename: STRING is
			-- Full filename of "empty.txt"
		once
			Result := file_system.pathname (data_dirname, "empty.txt")
		ensure
			empty_filename_not_void: Result /= Void
		end

	gobo_filename: STRING is
			-- Full filename of "gobo.txt"
		once
			Result := file_system.pathname (data_dirname, "gobo.txt")
		ensure
			gobo_filename_not_void: Result /= Void
		end

	hello_filename: STRING is
			-- Full filename of "hello.txt"
		once
			Result := file_system.pathname (data_dirname, "hello.txt")
		ensure
			hello_filename_not_void: Result /= Void
		end

	integers_filename: STRING is
			-- Full filename of "integers.txt"
		once
			Result := file_system.pathname (data_dirname, "integers.txt")
		ensure
			integers_filename_not_void: Result /= Void
		end

feature -- Directory names

	new_dirname (a_prefix: STRING): STRING is
			-- New unique directory name
		require
			a_prefix_not_void: a_prefix /= Void
		local
			nb: INTEGER
		do
			from
				nb := counter.item + 1
				counter.put (nb)
				Result := a_prefix + nb.out
			until
				not file_system.directory_exists (Result)
			loop
				nb := counter.item + 1
				counter.put (nb)
				Result := a_prefix + nb.out
			end
		ensure
			dirname_not_void: Result /= Void
		end

	data_dirname: STRING is
			-- Full directory name of "$GOBO/test/kernel/data"
		once
			Result := file_system.pathname (kernel_dirname, "data")
		ensure
			data_dirname_not_void: Result /= Void
		end

	kernel_dirname: STRING is
			-- Full directory name of "$GOBO/test/kernel"
		once
			Result := file_system.nested_pathname ("$GOBO", <<"test", "kernel">>)
		ensure
			kernel_dirname_not_void: Result /= Void
		end

feature -- Execution

	set_up is
			-- Setup for a test.
		local
			a_testdir: STRING
		do
			a_testdir := testdir
			-- assert (a_testdir + "_not_exists", not file_system.directory_exists (a_testdir))
			old_cwd := file_system.cwd
			file_system.create_directory (a_testdir)
			assert (a_testdir + "_exists", file_system.directory_exists (a_testdir))
			file_system.cd (a_testdir)
		end

	tear_down is
			-- Tear down after a test.
		do
			if old_cwd /= Void then
				file_system.cd (old_cwd)
				-- file_system.recursive_delete_directory (testdir)
				old_cwd := Void
			end
		end

	old_cwd: STRING
			-- Initial current working directory

feature {NONE} -- Implementation

	testdir: STRING is "Tkernel"
			-- Name of temporary directory where to run the test

	counter: KL_CELL [INTEGER] is
			-- Filename counter
		once
			create Result.make (0)
		ensure
			counter_not_void: Result /= Void
		end

end
