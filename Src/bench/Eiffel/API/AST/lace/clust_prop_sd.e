indexing
	description: "Cluster property description for Ace"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

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

create
	initialize,
	default_create

feature {NONE} -- Initialization

	initialize (dep: like dependencies; us: like use_name; iop: like include_option;
		eo: like exclude_option; ao: like adapt_option;
		dop: like default_option; o: like options;
		vo: like visible_option) is
			-- Create a new CLUST_PROP AST node.
		do
			dependencies := dep
			use_name := us
			include_option := iop
			exclude_option := eo
			adapt_option := ao
			default_option := dop
			options := o
			visible_option := vo
		ensure
			dependencies_set: dependencies = dep
			use_name_set: use_name = us
			include_option_set: include_option = iop
			exclude_option_set: exclude_option = eo
			adapt_option_set: adapt_option = ao
			default_option_set: default_option = dop
			options_set: options = o
			visible_option_set: visible_option = vo
		end

feature -- Properties

	dependencies: LACE_LIST [DEPEND_SD]
			-- External dependencies.

	use_name: ID_SD;
			-- Use file

	include_option: LACE_LIST [FILE_NAME_SD];
			-- File name to include

	exclude_option: LACE_LIST [FILE_NAME_SD];
			-- File names to exclude from current cluster

	adapt_option: LACE_LIST [CLUST_ADAPT_SD];
			-- List of cluster adaptations

	default_option: LACE_LIST [D_OPTION_SD];
			-- List of default options

	options: LACE_LIST [O_OPTION_SD];
			-- List of specific options

	visible_option: LACE_LIST [CLAS_VISI_SD];
			-- Visibility

feature -- Setting

	set_include_option (l: like include_option) is
			-- Assign `l' to `include_option'.
		do
			include_option := l
		ensure
			include_option_set: include_option = l
		end

	set_exclude_option (l: like exclude_option) is
			-- Assign `l' to `exclude_option'.
		do
			exclude_option := l
		ensure
			exclude_option_set: exclude_option = l
		end

	set_default_option (l: like default_option) is
			-- Assign `l' to `default_option'.
		do
			default_option := l
		ensure
			default_option_set: default_option = l
		end

	set_visible_option (l: like visible_option) is
			-- Assign `l' to `visible_option'.
		do
			visible_option := l
		ensure
			visible_option_set: visible_option = l
		end

	set_use_name (s: like use_name) is
			-- Assign `s' to `use_name'.
		do
			use_name := s
		ensure
			use_name_set: use_name = s
		end

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object
		do
			create Result.initialize (
				duplicate_ast (dependencies),
				duplicate_ast (use_name), duplicate_ast (include_option),
				duplicate_ast (exclude_option), duplicate_ast (adapt_option),
				duplicate_ast (default_option), duplicate_ast (options),
				duplicate_ast (visible_option))
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Is `other' same as Current?
		do
			Result := other /= Void and then same_ast (dependencies, other.dependencies)
					and then same_ast (use_name, other.use_name)
					and then same_ast (include_option, other.include_option)
					and then same_ast (exclude_option, other.exclude_option)
					and then same_ast (adapt_option, other.adapt_option)
					and then same_ast (default_option, other.default_option)
					and then same_ast (options, other.options)
					and then same_ast (visible_option, other.visible_option)
		end

feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Save current in `st'.
		local
			need_end: BOOLEAN
		do
			if dependencies /= Void and then not dependencies.is_empty then
				need_end := True
				st.put_string ("depend")
				st.put_new_line
				st.indent
				use_name.save (st)
				st.exdent
				st.put_new_line
			end

			if use_name /= Void and then not use_name.is_empty then
				need_end := True
				st.put_string ("use")
				st.put_new_line
				st.indent
				use_name.save (st)
				st.exdent
				st.put_new_line
			end

			if include_option /= Void and then not include_option.is_empty then
				need_end := True
				st.put_string ("include")
				st.put_new_line
				st.indent
				include_option.save_with_separator (st, "; ")
				st.exdent
				st.put_new_line
			end

			if exclude_option /= Void and then not exclude_option.is_empty then
				need_end := True
				st.put_string ("exclude")
				st.put_new_line
				st.indent
				exclude_option.save_with_separator (st, "; ")
				st.exdent
				st.put_new_line
			end

			if adapt_option /= Void and then not adapt_option.is_empty then
				need_end := True
				st.put_string ("adapt")
				st.put_new_line
				st.indent
				adapt_option.save_with_separator (st, "; ")
				st.exdent
				st.put_new_line
			end

			if default_option /= Void and then not default_option.is_empty then
				need_end := True
				st.put_string ("default")	
				st.put_new_line
				st.indent
				default_option.save_with_new_line (st)
				st.exdent
			end

			if options /= Void and then not options.is_empty then
				need_end := True
				st.put_string ("option")	
				st.put_new_line
				st.indent
				options.save_with_new_line (st)
				st.exdent
			end

			if visible_option /= Void and then not visible_option.is_empty then
				need_end := True
				st.put_string ("visible")
				st.put_new_line
				st.indent
				visible_option.save_with_new_line (st)
				st.exdent
			end
			
			if need_end then
				st.put_string ("end")
			end
		end

feature {COMPILER_EXPORTER} -- Lace compilation

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
				path := Environ.interpreted_string (use_name);
				create use_file_path.make_from_string (cluster.path);
				use_file_path.set_file_name (path);
				create use_file.make (use_file_path);
				if (not use_file.exists) or else use_file.is_directory then
					create vd02;
					vd02.set_cluster (cluster);
					vd02.set_use_name (use_file_path);
					Error_handler.insert_error (vd02);
					Error_handler.raise_error;
				elseif not use_file.is_readable then
					create vd21;
					vd21.set_file_name (use_file_path);
					vd21.set_cluster (cluster);
					Error_handler.insert_error (vd21);
				else
					use_file.open_read
						-- Parse local ace file
					Parser.parse_file (use_file_path, True);
					cluster_prop ?= Parser.ast;
					if cluster_prop /= Void then	
							-- Local ace cannot have a use clause
						if cluster_prop.use_name /= Void then
							create vduc;
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
			if dependencies /= Void then
				dependencies.adapt;
			end
				-- First include additonal classes
			if include_option /= Void then
				include_option.adapt;
			end;
				-- Second exclude classes
			if exclude_option /= Void then
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
				clust_prop := Use_properties.item (context.current_cluster.path);
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
					if d.option.is_system_level_only then
						create vd36;
						vd36.set_cluster (context.current_cluster);
						vd36.set_option_name (d.option.option_name);
						Error_handler.insert_error (vd36);
					end;
				else
					create vd32;
					vd32.set_option_name (d.option.option_name);
					Error_handler.insert_error (vd32);
				end
				l.forth
			end;
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CLUST_PROP_SD


