note
	description: "[
		Contains all configuartion info for the xebra server including the list of webapps that 
		are read from a config file.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_FILE_CONFIG

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER
	XS_SHARED_SERVER_OUTPUTTER
--	XI_CONFIG
--		redefine
--			make_empty
--		end

create
	 make_empty

feature {NONE} -- Initialization

	make_empty
			-- Creates an empty XS_CONFIG with unset attributes.
		do
			create webapps.make (1)
			create webapps_root.make_empty
			create compiler.make_empty
			create translator.make_empty
			create finalize_webapps.make_empty
			create lib.make_empty
			create compiler_flags.make_empty
		ensure then
			compiler_flags_attached: compiler_flags /= Void
			lib_attached: lib /= Void
			webapps_attached: webapps /= Void
			webapps_root_attached: webapps_root /= Void
			compiler_attached: compiler /= Void
			translator_attached: translator /= Void
			finalize_webapps_attached: finalize_webapps /= Void

		end


feature -- Access

	webapps:  HASH_TABLE [XS_WEBAPP, STRING]
			-- The webapps the server knows about

	webapps_root:  SETTABLE_STRING
			-- The webapps root directory

	compiler:  SETTABLE_STRING
			-- The compiler (ec) filename

	compiler_flags: SETTABLE_STRING
			-- Flags to compiler the webapps and servlet_gens

	translator:  SETTABLE_STRING
			-- The compiler (xebra_translator) filename

	lib:  SETTABLE_STRING
			-- The folder that contains the xebra libraries

	finalize_webapps:  SETTABLE_BOOLEAN
			-- Specifies whether webapps should be finalized

	compiler_filename: FILE_NAME
			-- Returns 'compiler' converted to a FILE_NAME.
		require
			compiler_set: compiler.is_set
		do
			create Result.make_from_string (compiler)
		ensure
			Result_attached: Result /= Void
		end

	translator_filename: FILE_NAME
			-- Returns 'translator' converted to a FILE_NAME.
		require
			translator_set: translator.is_set
		do
			create Result.make_from_string (translator)
		ensure
			Result_attached: Result /= Void
		end

	webapps_root_filename: FILE_NAME
			-- Returns 'webapps_root' converted to a FILE_NAME.
		require
			webapps_root_set: webapps_root.is_set
		do
			create Result.make_from_string (webapps_root)
		ensure
			Result_attached: Result /= Void
		end

feature -- Stauts Report

	print_configuration: STRING
			-- Renders the configuration to a string
		do
			Result := "%N---------------- Server Configuration File ----------------"
			Result.append("%N-Webapps: " + webapps.count.out + " webapps at '" + webapps_root.out + "'")

			from
				webapps.start
			until
				webapps.after
			loop
				Result.append ("%N--'" + webapps.item_for_iteration.app_config.name.out + "' on "+ webapps.item_for_iteration.app_config.host.out + "@" + webapps.item_for_iteration.app_config.port.out)
				webapps.forth
			end

			Result.append ( "%N-Compiler in '" + compiler.out +
							"%N-Compiler Flags '" + compiler_flags.out +
							"%N-Translator in '" + translator.out +
							"%N-Libraries in '" + lib.out +
							"%N-Finalize webapps '" + finalize_webapps.out +  "'")
			Result.append ("%N-----------------------------------------------------------")

		ensure
			Result_attached: Result /= Void
		end

feature -- Setters

	set_webapps (a_webapps: like webapps)
			-- Sets webapps and assignes current to all webapps in the list.
		require
			a_webapps_attached: a_webapps /= Void
		do
			webapps := a_webapps
		ensure
			webapps_set: equal (webapps, a_webapps)
		end


	set_webapps_root (a_webapps_root: like webapps_root)
			-- Sets webapps_root.
		require
			a_webapps_root_attached: a_webapps_root /= Void
		do
			webapps_root := a_webapps_root
		ensure
			webapps_root_set: webapps_root = a_webapps_root
		end

	set_compiler  (a_compiler: like compiler)
			-- Sets compiler.
		require
			a_compiler_attached: a_compiler /= Void
		do
			compiler  := a_compiler
		ensure
			compiler_set: compiler  = a_compiler
		end

	set_translator (a_translator: like translator)
			-- Sets translator.
		require
			a_translator_attached: a_translator /= Void
		do
			translator  := a_translator
		ensure
			translator_set: translator  = a_translator
		end

	set_lib (a_lib: like lib)
			-- Sets lib.
		require
			a_lib_attached: a_lib /= Void
		do
			lib  := a_lib
		ensure
			lib_set: lib  = a_lib
		end

	set_compiler_flags (a_compiler_flags: like compiler_flags)
			-- Sets compiler_flags.
		require
			a_compiler_flags_attached: a_compiler_flags /= Void
		do
			compiler_flags  := a_compiler_flags
		ensure
			compiler_flags_set: compiler_flags  = a_compiler_flags
		end

	set_finalize_webapps (a_finalize_webapps: like finalize_webapps)
			-- Sets finalize_webapps.
		require
			a_finalize_webapps_attached: a_finalize_webapps /= Void
		do
			finalize_webapps := a_finalize_webapps
		ensure
			finalize_webapps_set: finalize_webapps = a_finalize_webapps
		end

invariant
	lib_attached: lib /= Void
	webapps_root_attached: webapps_root /= Void
	webapps_attached: webapps /= Void
	compiler_attached: compiler /= Void
	translator_attached: translator /= Void
	finalize_webapps_attached: finalize_webapps /= Void
	compiler_flags_attached: compiler_flags /= Void
end
