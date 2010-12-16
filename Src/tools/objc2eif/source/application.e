note
	description : "wrapper_generator application root class."
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

	SHARED_CONFIGURATION

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			file: RAW_FILE
			objc_simple_parser: OBJC_SIMPLE_PARSER
			wrappers_generator: WRAPPERS_GENERATOR
		do
			create file.make (configuration.framework_headers_folder + "Cocoa.h")
			create objc_simple_parser.make
			objc_simple_parser.parse_objc_header (file)
			if not objc_simple_parser.system_parsed then
					-- Parsing errors
				from
					print ("%NParsing Errors:%N")
					objc_simple_parser.errors.start
				until
					objc_simple_parser.errors.after
				loop
					print (objc_simple_parser.errors.item)
					objc_simple_parser.errors.forth
				end
			end
				-- Debugging
			from
				objc_simple_parser.classes.start
			until
				objc_simple_parser.classes.after
			loop
				print(objc_simple_parser.classes.item_for_iteration.debug_output)
				objc_simple_parser.classes.forth
			end
			from
				objc_simple_parser.protocols.start
			until
				objc_simple_parser.protocols.after
			loop
				print(objc_simple_parser.protocols.item_for_iteration.debug_output)
				objc_simple_parser.protocols.forth
			end
				-- Generate Wrappers
			create wrappers_generator.make (objc_simple_parser.classes, objc_simple_parser.protocols)
			wrappers_generator.generate_wrappers
		end

end
