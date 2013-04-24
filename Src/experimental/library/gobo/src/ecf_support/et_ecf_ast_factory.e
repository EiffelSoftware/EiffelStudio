indexing

	description:"Ecf Abstract Syntax Tree factories"
	author: "Patrick Ruckstuhl <patrick@tario.org>"
	date: "$Date$"
	revision: "$Revision$"

class ET_ECF_AST_FACTORY

create

	make

feature {NONE} -- Initialization

	make is
			-- Create a new AST factory.
		do
		end

feature -- AST factory

	new_file_rule (a_exclude: DS_HASH_SET [STRING]; a_include: DS_HASH_SET [STRING]): ET_ECF_FILE_RULE is
			-- New file rule
		require
			no_void_exclude: a_exclude /= Void implies not a_exclude.has (Void)
			no_void_include: a_include /= Void implies not a_include.has (Void)
		do
			create Result.make (a_exclude, a_include)
		ensure
			file_rule_not_void: Result /= Void
		end

	new_assembly (a_name: STRING; a_pathname: STRING; a_universe: ET_ECF_SYSTEM): ET_ECF_DOTNET_ASSEMBLY is
			-- New assembly
		require
			a_name_not_void: a_name /= Void
		do
			create Result.make (a_name, a_pathname, a_universe)
		ensure
			assembly_not_void: Result /= Void
		end

	new_assemblies: ET_ECF_DOTNET_ASSEMBLIES is
			-- New assembly list
		do
			create Result.make_empty
		ensure
			assemblies_not_void: Result /= Void
		end

	new_cluster (a_name: STRING; a_pathname: STRING; a_universe: ET_ECF_SYSTEM): ET_ECF_CLUSTER is
			-- New cluster
		require
			a_name_not_void: a_name /= Void
		do
			create Result.make (a_name, a_pathname, a_universe)
		ensure
			cluster_not_void: Result /= Void
		end

	new_clusters: ET_ECF_CLUSTERS is
			-- New cluster list
		do
			create Result.make_empty
		ensure
			clusters_not_void: Result /= Void
		end

feature -- Eiffel AST factory

	new_ast_factory: ET_AST_FACTORY is
			-- New Eiffel AST factory
		do
			if ast_factory /= Void then
				Result := ast_factory
			else
				create Result.make
			end
		ensure
			ast_factory_not_void: Result /= Void
		end

	new_error_handler: ET_ERROR_HANDLER is
			-- New error handler for Eiffel parser
		do
			if error_handler /= Void then
				Result := error_handler
			else
				create Result.make_standard
			end
		ensure
			error_handler_not_void: Result /= Void
		end

feature -- Configuration

	ast_factory: ET_AST_FACTORY
			-- Return this AST factory in `new_ast_factory'
			-- if not void

	error_handler: ET_ERROR_HANDLER
			-- Return this error handler in `new_error handler'
			-- if not void

feature -- Configuration setting

	set_ast_factory (a_factory: like ast_factory) is
			-- Set `ast_factory' to `a_factory'.
		do
			ast_factory := a_factory
		ensure
			ast_factory_set: ast_factory = a_factory
		end

	set_error_handler (a_handler: like error_handler) is
			-- Set `error_handler' to `a_handler'.
		do
			error_handler := a_handler
		ensure
			error_handler_set: error_handler = a_handler
		end

end
