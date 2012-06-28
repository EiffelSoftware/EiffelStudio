indexing

	description:

		"Test features of class ET_AST_PRETTY_PRINTER"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_TEST_AST_PRETTY_PRINTER

inherit

	TS_TEST_CASE
		redefine
			set_up, tear_down
		end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	KL_SHARED_EXECUTION_ENVIRONMENT
		export {NONE} all end

	UT_SHARED_ISE_VERSIONS
		export {NONE} all end

create

	make_default

feature -- Test

	test_pretty_printer is
			-- Test pretty-printer with some Eiffel classes.
		local
			a_system: ET_SYSTEM
			an_ast_factory: ET_DECORATED_AST_FACTORY
			a_cluster: ET_XACE_CLUSTER
			a_class: ET_CLASS
			a_filename: STRING
			a_class_name: ET_IDENTIFIER
		do
			create a_system.make
			create an_ast_factory.make
			an_ast_factory.set_keep_all_breaks (True)
			a_system.set_ast_factory (an_ast_factory)
			a_system.set_ise_version (ise_latest)
			a_system.activate_processors
			create a_cluster.make ("dt_cluster_name", ".", a_system)
			create a_class_name.make ("PRETTY_PRINTED1")
			a_filename := input_filename1
			a_class := a_system.eiffel_class (a_class_name)
			a_class.set_filename (a_filename)
			a_class.set_group (a_cluster)
			check_class (a_class)
		end

feature {NONE} -- Test

	check_class (a_class: ET_CLASS) is
			-- Check that after parsing `a_class' and printing back its AST,
			-- we get two files containing the same text.
		require
			a_class_not_void: a_class /= Void
		local
			l_printer: ET_AST_PRETTY_PRINTER
			l_file: KL_TEXT_OUTPUT_FILE
			l_prefixed_name: STRING
			l_full_test: BOOLEAN
		do
			if a_class.is_in_cluster then
				l_full_test := variables.has ("full_test")
				l_prefixed_name := a_class.group.prefixed_name
				if l_full_test or else (l_prefixed_name.count > 2 and then (l_prefixed_name.item (1) = 'd' and l_prefixed_name.item (2) = 't')) then
					a_class.process (a_class.current_system.eiffel_parser)
					assert (a_class.lower_name + "_parsed", a_class.is_parsed)
					assert (a_class.lower_name + "_no_syntax_error", not a_class.has_syntax_error)
					create l_file.make ("gobo.txt")
					l_file.open_write
					assert ("is_open_write", l_file.is_open_write)
					create l_printer.make_null
					l_printer.set_file (l_file)
					a_class.process (l_printer)
					l_printer.set_null_file
					l_file.close
					assert_files_equal (a_class.lower_name + "_diff", a_class.filename, "gobo.txt")
				end
			end
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

	testdir: STRING is "Ttools"
			-- Name of temporary directory where to run the test

	input_filename1: STRING is
			-- Filename of Eiffel class to be pretty-printed
		once
			Result := file_system.nested_pathname ("${GOBO}", <<"test", "tools", "data", "pretty_printed1.txt">>)
			Result := Execution_environment.interpreted_string (Result)
		ensure
			input_filename1_not_void: Result /= Void
			input_filename1_not_empty: Result.count > 0
		end

end
