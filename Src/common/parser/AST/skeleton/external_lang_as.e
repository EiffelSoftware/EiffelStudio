indexing
	description: "AST representation of an external structure."
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_LANG_AS

inherit

	AST_EIFFEL
		redefine
			is_equivalent
		end
	EXTERNAL_CONSTANTS
	COMPILER_EXPORTER

feature {AST_FACTORY} -- Initialization

	initialize (l: like language_name; s: INTEGER) is
			-- Create a new EXTERNAL_LANGUAGE AST node.
		require
			l_not_void: l /= Void
		do
			language_name := l
			start_position := s
			parse
		ensure
			language_name_set: language_name = l
			start_position_set: start_position = s
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			language_name ?= yacc_arg (0)
			start_position := yacc_position
			parse
		ensure then
			language_name /= Void
		end

feature -- Properties

	language_name: STRING_AS;
			-- Language name
			-- might be replaced by external_declaration or external_definition


	start_position: INTEGER
			-- Start position of AST

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- FIXME: is_equivalent should be done on EXTERNAL_EXTENSION_AS
			Result := language_name.is_equivalent (other.language_name)
		end

feature {NONE} -- Implementation

	parse is
			-- Parse external declaration
		do
			-- nothing --JOCE--

		end

	raise_external_error (msg: STRING; start_p: INTEGER; end_p: INTEGER) is
			-- Raises error occured while parsing
		local
			ext_error: EXTERNAL_SYNTAX_ERROR
			line_start: INTEGER
		do
			!!ext_error.init
			line_start := ext_error.start_position
			ext_error.set_start_position (line_start + start_p)
			ext_error.set_end_position (line_start + end_p)
			ext_error.set_external_error_message (msg)
			Error_handler.insert_error (ext_error)
			Error_handler.raise_error
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.format_ast (language_name)
		end

end -- class EXTERNAL_LANG_AS
