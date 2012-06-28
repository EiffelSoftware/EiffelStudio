indexing

	description:

		"Eiffel class processors"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2003-2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class ET_CLASS_PROCESSOR

inherit

	ET_AST_PROCESSOR
		redefine
			make
		end

	ET_SHARED_TOKEN_CONSTANTS
		export {NONE} all end

feature {NONE} -- Initialization

	make is
			-- Create a new processor for given classes.
		do
			current_class := tokens.unknown_class
		end

feature -- Access

	current_class: ET_CLASS
			-- Class being processed

	universe: ET_UNIVERSE is
			-- Universe to which `current_class' belongs
		do
			Result := current_class.universe
		ensure
			universe_not_void: Result /= Void
		end

	current_system: ET_SYSTEM is
			-- Surrounding Eiffel system
			-- (Note: there is a frozen feature called `system' in
			-- class GENERAL of SmartEiffel 1.0)
		do
			Result := current_class.current_system
		ensure
			current_system_not_void: Result /= Void
		end

feature -- Error handling

	error_handler: ET_ERROR_HANDLER is
			-- Error handler
		do
			Result := current_system.error_handler
		ensure
			error_handler_not_void: Result /= Void
		end

invariant

	current_class_not_void: current_class /= Void
	current_class_preparsed: current_class.is_preparsed

end
