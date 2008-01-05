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

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Creation

	make
			-- Create and initialize processor.
		do
			reset_all
		end

feature -- Status setting

	reset
			-- Reset state settings from last call to 'set_current_class_and_feature_name'
		do
			current_class := Void
			current_feature_name := Void
			is_dotnet := False
		end

	reset_all
			-- Completely reset all settings so that no state information is kept.
		do
			reset
			previous_built_in_code_path := ""
			previous_class_as := Void
		end

	set_current_class_and_feature_name (a_class: like current_class; a_feature_name: like current_feature_name; a_is_dotnet: BOOLEAN)
			-- Initialize current with `a_class' and `a_feature_name'
		require
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature_name /= Void
		do
			current_class := a_class
			current_feature_name := a_feature_name
			is_dotnet := a_is_dotnet
		ensure
			current_class_set: current_class = a_class
			current_feature_name_set: current_feature_name = a_feature_name
			is_dotnet_set: is_dotnet = a_is_dotnet
		end

feature -- Access

	current_class: CLASS_C
	current_feature_name: STRING
			-- Class and feature associated being processed

	is_dotnet: BOOLEAN
			-- Are we targetting .NET code?

feature -- Status report

	ast_node: FEATURE_AS
			-- Get AST from `built_in_code_path'. If Void, it means that it is
			-- not a recognized built_in.
		local
			l_parser: like eiffel_parser
			l_file: KL_BINARY_INPUT_FILE
			retried: BOOLEAN
			l_class_as: CLASS_AS
			l_code_path_neutral, l_code_path_dependent: STRING
			l_reuse_previous_as: BOOLEAN
			l_empty_str: STRING
		do
			if not retried then
				l_empty_str := once ""
				l_parser := eiffel_parser
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
					l_class_as := previous_class_as
				elseif l_file /= Void then
					check l_file_is_open_read: l_file.is_open_read end
					l_parser.parse_class (l_file, current_class)
					l_file.close
					l_class_as := l_parser.root_node
				end

				if l_class_as /= Void then
					Result := l_class_as.feature_with_name (Names_heap.id_of (current_feature_name))
				else
					previous_built_in_code_path := l_empty_str
				end
				previous_class_as := l_class_as
			else
				if l_file /= Void and not l_file.is_closed then
					l_file.close
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

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

	previous_class_as: CLASS_AS
		-- Class Abstract Syntax retrieved from previous parse.

	previous_built_in_code_path: STRING
		-- Location where code of previous parse was located.

invariant
	current_feature_name_not_void: current_feature_name /= Void implies current_class /= Void

end
