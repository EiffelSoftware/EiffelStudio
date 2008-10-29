indexing

	description:

		"Common pathnames"

	library: "AutoTest Library"
	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_PATHNAMES

inherit

	AUT_SHARED_REGISTRY
		export {NONE} all end

	KL_SHARED_EXECUTION_ENVIRONMENT
		export {NONE} all end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

create

	make

feature {AUT_SHARED_PATHNAMES}

	make is
			-- Create new object.
		do
		end

feature -- Directory names

	auto_test_dirname: STRING is
			-- Directory where AutoTest has been installed.
			-- First the registry (if available) will be queried for the dirname
			-- then the ${AUTO_TEST} environment variable will be used.
			-- If no other information is available, the current directly will be assumed.
		once
			if registry.is_available then
				Result := registry.string_value (auto_test_key_name + "\AUTO_TEST")
			end
			if Result = Void then
				Result := execution_environment.variable_value ("AUTO_TEST")
			end
			if Result = Void then
				Result := ""
			end
		ensure
			directory_not_void: Result /= Void
		end

	runtime_dirname: STRING is
			-- Directory where runtime files are stored
		once
			Result := execution_environment.variable_value ("ERL_G")
			if Result /= Void then
				Result := file_system.nested_pathname (Result, <<"library", "runtime">>)
			else
				Result := file_system.pathname (auto_test_dirname, "runtime")
			end
		ensure
			directory_not_void: Result /= Void
		end

	image_dirname: STRING is
			-- Directory where images are stored
		do
			Result := file_system.pathname (auto_test_dirname, "image")
		ensure
			dirname_not_void: Result /= Void
		end

	misc_dirname: STRING is
			-- Directory where miscelaneous files are stored
		do
			Result := file_system.pathname (auto_test_dirname, "misc")
		ensure
			dirname_not_void: Result /= Void
		end

	misc_html_dirname: STRING is
			-- Directory where miscelaneous files are stored
		do
			Result := file_system.pathname (misc_dirname, "html")
		ensure
			dirname_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	auto_test_key_name: STRING is "HKEY_LOCAL_MACHINE\software\AutoTest"
			-- Name of AutoTest key

end
