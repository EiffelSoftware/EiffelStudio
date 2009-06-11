note
	description: "[
		Contains all configuartion info for the xebra server including the list of webapps
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_FILE_CONFIG

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER
	XS_SHARED_SERVER_OUTPUTTER
	XI_CONFIG
		redefine
			make_empty
		end

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
			create assume_webapps_are_running.make_empty
	--		create arg_config.make_empty
			create taglib.make_empty
		ensure then
			taglib_attached: taglib /= Void
--			arg_config_attached: arg_config /= Void
			webapps_attached: webapps /= Void
			webapps_root_attached: webapps_root /= Void
			compiler_attached: compiler /= Void
			translator_attached: translator /= Void
			finalize_webapps_attached: finalize_webapps /= Void
			assume_webapps_are_running_attached: assume_webapps_are_running /= Void
		end


feature -- Access

	webapps:  HASH_TABLE [XS_WEBAPP, STRING]
			-- The webapps the server knows about

--	arg_config: XS_ARG_CONFIG
--			-- The config settings read from the execute arguments.		

	webapps_root:  SETTABLE_STRING assign set_webapps_root
			-- The webapps root directory. Read from config.ini

	compiler:  SETTABLE_STRING assign set_compiler
			-- The compiler (ec) filename. Read from config.ini

	translator:  SETTABLE_STRING assign set_translator
			-- The compiler (xebra_translator) filename. Read from config.ini

	taglib:  SETTABLE_STRING assign set_taglib
			-- The folder that contains the taglibs. Read from config.ini

	finalize_webapps:  SETTABLE_BOOLEAN assign set_finalize_webapps
			-- Specifies whether webapps should be finalized. Read from config.ini

	assume_webapps_are_running:  SETTABLE_BOOLEAN assign set_assume_webapps_are_running
			-- Specifies whether webapps should be finalized. Read from config.ini


	compiler_filename: FILE_NAME
			-- Returns 'compiler' converted to a FILE_NAME
		require
			compiler_set: compiler.is_set
		do
			create Result.make_from_string (compiler)
		ensure
			Result_attached: Result /= Void
		end

	translator_filename: FILE_NAME
			-- Returns 'translator' converted to a FILE_NAME
		require
			translator_set: translator.is_set
		do
			create Result.make_from_string (translator)
		ensure
			Result_attached: Result /= Void
		end

	webapps_root_filename: FILE_NAME
			-- Returns 'webapps_root' converted to a FILE_NAME
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
			Result := "%N---------------- Server Configuration ----------------"
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
							"%N-Translator in '" + translator.out +
							"%N-Finalize webapps '" + finalize_webapps.out +  "'" +
							"%N-Assume webapps are running  '" + assume_webapps_are_running.out + "'")
		--	Result.append (arg_config.print_configuration)
			Result.append ("%N------------------------------------------------------")

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
--			from
--				webapps.start
--			until
--				webapps.after
--			loop
--				webapps.item_for_iteration.set_server_config (current)
--				webapps.forth
--			end
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

	set_taglib (a_taglib: like taglib)
			-- Sets taglib.
		require
			a_taglib_attached: a_taglib /= Void
		do
			taglib  := a_taglib
		ensure
			taglib_set: taglib  = a_taglib
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

	set_assume_webapps_are_running (a_assume_webapps_are_running: like assume_webapps_are_running)
			-- Sets assume_webapps_are_running.
		require
			a_assume_webapps_are_running_attached: a_assume_webapps_are_running /= Void
		do
			assume_webapps_are_running := a_assume_webapps_are_running
		ensure
			assume_webapps_are_running_set: assume_webapps_are_running = a_assume_webapps_are_running
		end

invariant
	taglib_attached: taglib /= Void
--	arg_config_attached: arg_config /= Void
	webapps_root_attached: webapps_root /= Void
	webapps_attached: webapps /= Void
	compiler_attached: compiler /= Void
	translator_attached: translator /= Void
	finalize_webapps_attached: finalize_webapps /= Void
	assume_webapps_are_running_attached: assume_webapps_are_running /= Void
end
