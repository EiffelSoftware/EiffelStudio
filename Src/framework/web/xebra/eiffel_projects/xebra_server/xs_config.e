note
	description: "[
		Contains all configuartion info for the xebra server including the list of webapps
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_CONFIG

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER
	XU_SHARED_OUTPUTTER
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
		ensure then
			webapps_attached: webapps /= Void
			webapps_root_attached: webapps_root /= Void
			compiler_attached: compiler /= Void
			translator_attached: translator /= Void
			finalize_webapps_attached: finalize_webapps /= Void
			assume_webapps_are_running_attached: assume_webapps_are_running /= Void
		end

feature -- Access

	webapps:  HASH_TABLE [XS_WEBAPP, STRING]
	webapps_root:  SETTABLE_STRING assign set_webapps_root
	compiler:  SETTABLE_STRING assign set_compiler
	translator:  SETTABLE_STRING assign set_translator
	finalize_webapps:  SETTABLE_BOOLEAN assign set_finalize_webapps
	assume_webapps_are_running:  SETTABLE_BOOLEAN assign set_assume_webapps_are_running

feature -- Constants

	servlet_gen_path: STRING = "servlet_gen"
	servlet_gen_exe: STRING = "servlet_gen/EIFGENs/servlet_gen/W_code/servlet_gen"
	servlet_gen_ecf: STRING = "servlet_gen/servlet_gen.ecf"

feature -- Stauts Report

	print_configuration: STRING
			-- Renders the configuration to a string
		do
			Result := "%NServer Configuration:" +
			"%T" + webapps.count.out + " webapps at '" + webapps_root.out + "'"

			from
				webapps.start
			until
				webapps.after
			loop
				Result := Result + "%N%T%T" + webapps.item_for_iteration.config.host.out + "/" + webapps.item_for_iteration.config.name.out + "@" + webapps.item_for_iteration.config.port.out
				webapps.forth
			end

			Result := Result + "%N%TCompiler in '" + compiler.out +
								"%N%TTranslator in '" + translator.out +
								"%N%TFinalize webapps '" + finalize_webapps.out +  "'" +
								"%N%TAssume webapps are running  '" + assume_webapps_are_running.out + "'"

		ensure
			Result_attached: Result /= Void
		end

feature -- Setters

	set_webapps (a_webapps: like webapps)
			-- Sets webapps and assignes current to all webapps in the list
		require
			a_webapps_attached: a_webapps /= Void
		do
			webapps := a_webapps
			from
				webapps.start
			until
				webapps.after
			loop
				webapps.item_for_iteration.set_server_config (current)
				webapps.forth
			end
		ensure
			webapps_set: equal (webapps, a_webapps)
		end


	set_webapps_root (a_webapps_root: like webapps_root)
			-- Sets webapps_root
		require
			a_webapps_root_attached: a_webapps_root /= Void
		do
			webapps_root := a_webapps_root
		ensure
			webapps_root_set: webapps_root = a_webapps_root
		end

	set_compiler  (a_compiler: like compiler)
			-- Sets compiler
		require
			a_compiler_attached: a_compiler /= Void
		do
			compiler  := a_compiler
		ensure
			compiler_set: compiler  = a_compiler
		end

	set_translator (a_translator: like translator)
			-- Sets translator
		require
			a_translator_attached: a_translator /= Void
		do
			translator  := a_translator
		ensure
			translator_set: translator  = a_translator
		end

	set_finalize_webapps (a_finalize_webapps: like finalize_webapps)
			-- Sets finalize_webapps
		require
			a_finalize_webapps_attached: a_finalize_webapps /= Void
		do
			finalize_webapps := a_finalize_webapps
		ensure
			finalize_webapps_set: finalize_webapps = a_finalize_webapps
		end

	set_assume_webapps_are_running (a_assume_webapps_are_running: like assume_webapps_are_running)
			-- Sets assume_webapps_are_running
		require
			a_assume_webapps_are_running_attached: a_assume_webapps_are_running /= Void
		do
			assume_webapps_are_running := a_assume_webapps_are_running
		ensure
			assume_webapps_are_running_set: assume_webapps_are_running = a_assume_webapps_are_running
		end

invariant
	webapps_root_attached: webapps_root /= Void
	webapps_attached: webapps /= Void
	compiler_attached: compiler /= Void
	translator_attached: translator /= Void
	finalize_webapps_attached: finalize_webapps /= Void
	assume_webapps_are_running_attached: assume_webapps_are_running /= Void
end
