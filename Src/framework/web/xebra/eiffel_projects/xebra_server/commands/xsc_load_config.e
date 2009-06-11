note
	description: "Summary description for {XSC_LOAD_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XSC_LOAD_CONFIG

inherit
	XS_COMMAND

create
	make

feature -- Basic operations

	execute (a_server: XS_MAIN_SERVER)
			-- <Precursor>	
		local
			l_webapp_handler: XS_WEBAPP_HANDLER
			l_webapp_finder: XS_WEBAPP_FINDER
			l_config_reader: XS_CONFIG_READER
		do
			o.iprint ("Reading config...")
			create l_config_reader.make
			if attached l_config_reader.process_file (config.args.config_filename) as l_config then
				config.file := l_config
				create l_webapp_finder.make
				config.file.set_webapps (l_webapp_finder.search_webapps (config.file.webapps_root))
				o.dprint (config.file.print_configuration, 2)
				o.iprint ("Done.")
			end
		end

end
