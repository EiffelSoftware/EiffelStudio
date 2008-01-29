indexing
	description: "Process BUILT_IN_AS nodes."
	date: "$Date$"
	revision: "$Revision$"

class
	BUILT_IN_PROCESSOR

inherit

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
			{AST_COMPILER_FACTORY} names_heap
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

	EIFFEL_PARSER
		rename
			reset as parser_reset
		export
			{NONE} all
		redefine
			make, current_class, file_buffer
		end

create
	make

feature {NONE} -- Creation

	make
			-- Create and initialize processor.
		do
			make_with_factory (create {AST_ROUNDTRIP_COMPILER_LIGHT_FACTORY})
			reset_all
		end

feature -- Status setting

	reset
			-- Reset state settings from last call to 'set_current_class_and_feature_name'
		do
			current_class := Void
			is_dotnet := False
		end

	reset_all
			-- Completely reset all settings so that no state information is kept.
		do
			reset
			previous_built_in_code_path := ""
			class_as := Void
		end

	parse_current_class (a_class: like current_class; a_is_dotnet: BOOLEAN)
			-- Initialize current with `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			current_class := a_class
			is_dotnet := a_is_dotnet

				-- Set the parsing of `Current'.
			il_parser := shared_eiffel_parser.il_parsing

			class_as := internal_class_as
		ensure
			is_dotnet_set: is_dotnet = a_is_dotnet
		end

feature -- Access

	current_class: CLASS_C

	is_dotnet: BOOLEAN
			-- Are we targetting .NET code?

	class_as: CLASS_AS
			-- Class AS parsed from the last call to

feature {NONE} -- Implementation

	internal_class_as: CLASS_AS
			-- Get AST from `built_in_code_path'. If Void, it means that it is
			-- not a recognized built_in.
		local
			l_file: KL_BINARY_INPUT_FILE
			retried: BOOLEAN
			l_class_as: CLASS_AS
			l_code_path_neutral, l_code_path_dependent: STRING
			l_reuse_previous_as: BOOLEAN
			l_empty_str: STRING
		do
			if not retried then
				l_empty_str := once ""
					-- First search for platform specific implementation.
				l_code_path_neutral := built_in_code_path (False)
				l_reuse_previous_as :=  l_code_path_neutral.is_equal (previous_built_in_code_path)
				if not l_reuse_previous_as then
					l_code_path_dependent := built_in_code_path (True)
					l_reuse_previous_as := l_code_path_dependent.is_equal (previous_built_in_code_path)
				end

				if not l_reuse_previous_as then
					create l_file.make (l_code_path_neutral)
					l_file.open_read
					if not l_file.is_open_read then
						create l_file.make (l_code_path_dependent)
						l_file.open_read
						if not l_file.is_open_read then
							l_file := Void
							previous_built_in_code_path := l_empty_str
						else
							previous_built_in_code_path := l_code_path_dependent
						end
					else
						previous_built_in_code_path := l_code_path_neutral
					end
				end

				if l_reuse_previous_as then
					l_class_as := class_as
				elseif l_file /= Void then
					check l_file_is_open_read: l_file.is_open_read end
					parse_class (l_file, current_class)
					l_file.close
					l_class_as := root_node
				end

				if l_class_as /= Void then
					Result := l_class_as
				else
					previous_built_in_code_path := l_empty_str
				end
				class_as := l_class_as
			else
				if l_file /= Void and not l_file.is_closed then
					l_file.close
				end
			end
		rescue
			retried := True
			retry
		end

	built_in_code_path (a_neutral: BOOLEAN): STRING
			-- Location where code for current built_in is_located.
		local
			l_path: FILE_NAME
		do
			create l_path.make_from_string (eiffel_layout.built_ins_path (a_neutral, is_dotnet))
			l_path.set_file_name (current_class.name)
			l_path.add_extension (eiffel_extension)
			Result := l_path.string
		ensure
			built_in_code_path_not_void: Result /= Void
		end

	previous_built_in_code_path: STRING
		-- Location where code of previous parse was located.

	shared_eiffel_parser: SHARED_EIFFEL_PARSER
			-- Shared Eiffel Parser used for querying 'il_parsing'.
		once
			create Result
		end

	File_buffer: YY_FILE_BUFFER is
			-- Parser input file buffer
			-- Redefined as nested parsing causes assertion violations.
		once
			create Result.make_with_size ((create {KL_STANDARD_FILES}).input, 10000)
		end

end
