-- Option_clause           : /* empty */
--                         | Use Include Exclude Name_adapt Defaults Options Visible LEX_END
--
-- Use                     : /* empty */
--                         | LEX_USE Name
--
-- Include                 : /* empty */
--                         | LEX_INCLUDE File_list
-- 
-- Exclude                 : /* empty */
--                         | LEX_EXCLUDE File_list
-- 
-- File_list               : File_clause
--                         | File_list LEX_SEMICOLON File_clause
-- 
-- File_clause             : /* empty */
--                         | Name
-- 
-- Name_adapt              : /* empty */
--                         | LEX_ADAPT Cluster_adapt_list
-- 
-- Cluster_adapt_list      : Cluster_adapt_clause
--                         | Cluster_adapt_list LEX_SEMICOLON Cluster_adapt_clause
-- 
-- Options                 : /* empty */
--                         | LEX_OPTION O_option_clause_list
--
-- Visible                 : /* empty */
--                         | LEX_VISIBLE Class_visi_list
--
-- Class_visi_list         : Class_visibility
--                         | Class_visi_list LEX_SEMICOLON Class_visibility



class CLUST_PROP_SD

inherit

	AST_LACE
		redefine
			adapt
		end;
	SHARED_LACE_PARSER;
	SHARED_USE;
	SHARED_ENV;
	SYSTEM_CONSTANTS

feature -- Attributes

	use_name: ID_SD;
			-- Use file

	include_option: LACE_LIST [INCLUDE_SD];
			-- File name to include

	exclude_option: LACE_LIST [EXCLUDE_SD];
			-- File names to exclude from current cluster

	adapt_option: LACE_LIST [CLUST_ADAPT_SD];
			-- List of cluster adaptations

	default_option: LACE_LIST [D_OPTION_SD];
			-- List of default options

	options: LACE_LIST [O_OPTION_SD];
			-- List of specific options

	visible_option: LACE_LIST [CLAS_VISI_SD];
			-- Visibility

feature -- Initialization

	set is
			-- Yacc initialization
		do
			use_name ?= yacc_arg (0);
			include_option ?= yacc_arg (1);
			exclude_option ?= yacc_arg (2);
			adapt_option ?= yacc_arg (3);
			default_option ?= yacc_arg (4);
			options ?= yacc_arg (5);
			visible_option ?= yacc_arg (6)
		end;

feature -- Lace compilation

	adapt_use is
			-- Adapt cluster `cluster' with the use file
		local
			path: STRING;
			use_file_path: FILE_NAME;
			use_file: PLAIN_TEXT_FILE;
			cluster_prop: like Current;
			vd02: VD02;
			vduc: VDUC;
			cluster: CLUSTER_I;
			vd21: VD21;
		do
			cluster := context.current_cluster;
			if use_name /= Void then
				path := Environ.interpret (use_name);
				!!use_file_path.make_from_string (cluster.path);
				use_file_path.set_file_name (path);
				!!use_file.make_open_read (use_file_path.path);
				if 
					(not use_file.exists) or else
					use_file.is_directory
				then
					!!vd02;
					vd02.set_cluster (cluster);
					vd02.set_use_name (use_file_path.path);
					Error_handler.insert_error (vd02);
					Error_handler.raise_error;
				elseif not use_file.readable then
					!!vd21;
					vd21.set_file_name (use_file_path.path);
					vd21.set_cluster (cluster);
					Error_handler.insert_error (vd21);
				else
						-- Parse local ace file
					Parser.parse_file (use_file_path.path);
					cluster_prop ?= Parser.ast;
					if cluster_prop /= Void then	
							-- Local ace cannot have a use clause
						if cluster_prop.use_name /= Void then
							!!vduc;
							vduc.set_cluster (cluster);
							vduc.set_use_name (cluster_prop.use_name);
							Error_handler.insert_error (vduc);
						end;
							-- Use file adaptation
						cluster_prop.adapt;
							-- Keep track of the properties abstract
							-- description for options analysis
						Use_properties.put (cluster_prop, cluster.path);
					end;
				end;
			end;
		end;

	adapt is
			-- Adapt cluster `cluster' with current options
		do
				-- First include additonal classes
			if include_option /= Void then
				include_option.adapt;
			end;
				-- Second exclude classes
			if exclude_option /= void then
                exclude_option.adapt;
            end;
			
				-- Check sum error
			Error_handler.checksum;

				-- Third rename classes form other clusters
			if adapt_option /= Void then
				adapt_option.adapt;
			end;

				-- Fourth check visible paragraph
			if visible_option /= Void then
				visible_option.adapt;
			end;

				-- Check sum error
			Error_handler.checksum;

		end;

	process_options is
			-- Process options declared in a use file
		require
			consitency: use_name /= Void implies
						(Use_properties.has (context.current_cluster.path));
		local
			clust_prop: like Current;
			default_prop: like default_option;
			option_prop: like options;
		do
			if use_name /= Void then
					-- A cluster properties description has been parsed
					-- previously when building universe
				clust_prop := Use_properties.item
												(context.current_cluster.path);
				default_prop := clust_prop.default_option;
				if default_prop /= Void then
						-- Process default options in use file
					check_system_level_options (default_prop);
					default_prop.adapt;
				end;
				option_prop := clust_prop.options;
				if option_prop /= Void then
						-- Process options in use file
					check_system_level_options (option_prop);
					option_prop.adapt;
				end;
			end;
			if default_option /= Void then
				check_system_level_options (default_option);
				default_option.adapt;
			end;
			if options /= Void then
				check_system_level_options (options);
				options.adapt;
			end;
		end;

	check_system_level_options (l: LACE_LIST [D_OPTION_SD]) is
		local
			d: D_OPTION_SD;
			vd36: VD36;
			vd32: VD32
		do
			from
				l.start
			until
				l.after
			loop
				d := l.item;
				if d.option.is_valid then
					if d.option.is_system_level then
						!!vd36;
						vd36.set_cluster (context.current_cluster);
						vd36.set_option_name (d.option.option_name);
						Error_handler.insert_error (vd36);
					end;
				else
					!!vd32;
					vd32.set_option_name (d.option.option_name);
					Error_handler.insert_warning (vd32);
				end
				l.forth
			end;
		end;

end
