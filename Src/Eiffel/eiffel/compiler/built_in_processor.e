indexing
	description: "Process BUIL_IN_AS nodes."
	date: "$Date$"
	revision: "$Revision$"

class
	BUILT_IN_PROCESSOR

inherit
	ANY

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

feature -- Initialization

	make (a_class: like current_class; a_feature_name: like current_feature_name; a_is_dotnet: BOOLEAN) is
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
		do
			if not retried then
				l_parser := eiffel_parser
					-- First search for platform specific implementation.
				create l_file.make (built_in_code_path (False))
				l_file.open_read
				if not l_file.is_open_read then
						-- Then look for platform independent implementation.
					create l_file.make (built_in_code_path (True))
					l_file.open_read
					if not l_file.is_open_read then
						l_file := Void
					end
				end
				if l_file /= Void then
					check l_file_is_open_read: l_file.is_open_read end
					l_parser.parse_class (l_file, current_class)
					l_class_as := l_parser.root_node
					l_file.close
					if l_class_as /= Void then
						Result := l_class_as.feature_with_name (Names_heap.id_of (current_feature_name))
					end
				end
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

invariant
	current_class_not_void: current_class /= Void
	current_feature_name_not_void: current_feature_name /= Void

end
