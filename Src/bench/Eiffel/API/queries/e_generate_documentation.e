indexing

	description: 
		"Command to generate documentation for an Eiffel project.";
	date: "$Date$";
	revision: "$Revision $"

class E_GENERATE_DOCUMENTATION

inherit
	E_CMD

	SHARED_EIFFEL_PROJECT

	SHARED_TEXT_ITEMS

creation
	make_flat, 
	make_flat_short, 
	make_short, 
	make_text

feature -- Initialization

	make_flat (f_name: like filter_name; a_window: like generate_window) is
			-- Initialize document generation to flat.
		require
			valid_window: a_window /= Void
		do
			format_type := flat_type;
			filter_name := f_name;
			generate_window := a_window
		end;

	make_flat_short (f_name: like filter_name; a_window: like generate_window) is
			-- Initialize document generation to flat_short.
		require
			valid_window: a_window /= Void
		do
			format_type := flat_short_type;
			filter_name := f_name;
			generate_window := a_window
		end;

	make_text (f_name: like filter_name; a_window: like generate_window) is
			-- Initialize document generation to text.
		require
			valid_window: a_window /= Void
		do
			format_type := text_type;
			filter_name := f_name;
			generate_window := a_window
		end;

	make_short (f_name: like filter_name; a_window: like generate_window) is
			-- Initialize document generation to text.
		require
			valid_window: a_window /= Void
		do
			format_type := short_type;
			filter_name := f_name;
			generate_window := a_window
		end;

feature -- Status report

	do_parents: BOOLEAN
			-- Print the parents as well?

	feature_clause_order: ARRAY [STRING]
			-- Array of orderd feature clause comments

	generate_window: DEGREE_OUTPUT
			-- Generate window

feature -- Status setting

	set_error_window (a_window: like error_window) is
			-- Set `error_window' to `a_window'.
		do
			error_window := a_window
		ensure
			set: error_window = a_window
		end;

	set_do_parents is
			-- Set `do_parents' to True;
		do
			do_parents := True
		ensure
			do_parents: do_parents
		end;

	set_feature_clause_order (fco: like feature_clause_order) is
			-- Set `feature_clause_order' to `fco'.
		do
			feature_clause_order := fco
		ensure
			set: feature_clause_order = fco
		end;

feature -- Execution

	execute is
			-- Show classes in universe
		local
			clusters: LINKED_LIST [CLUSTER_I];
			classes: EXTEND_TABLE [CLASS_I, STRING];
			list: LINKED_LIST [E_CLASS];
			a_class: E_CLASS;
			a_cluster: CLUSTER_I;
			filter: TEXT_FILTER;
			class_formatter: CLASS_TEXT_FORMATTER;
			file_name: FILE_NAME;
			d_name: DIRECTORY_NAME;
			dir: DIRECTORY;
			d_output: DEGREE_OUTPUT;
			type: STRING;
			st, text_st: STRUCTURED_TEXT;
			s_name: STRING
		do
			clusters := Eiffel_universe.clusters;
			if not clusters.empty then
				error_window.clear_window;
				if filter_name /= Void and then not filter_name.empty then
					!! filter.make (filter_name);
				end;
				file_name := Eiffel_system.document_file_name;
				if file_name /= Void then
					d_name := Eiffel_system.document_path;
					if d_name /= Void then
						!! dir.make (d_name);
						if not dir.exists then
							dir.create_dir
						end
					end;
					!! st.make;
					st.add (ti_Before_cluster_declaration);
					st.add (ti_Before_cluster_header);
					s_name := clone (Eiffel_System.name);
					s_name.to_upper;
					st.add_string (s_name);
					st.add (ti_After_cluster_header);
					st.add_new_line;
					st.add_new_line;
					generate_cluster_list (st, Eiffel_system.sub_clusters, 1);
					st.add (ti_After_cluster_declaration);
					generate_output (filter, file_name, st);
				end;
				!! list.make;
				from 
					clusters.start 
				until 
					clusters.after 
				loop
					a_cluster := clusters.item;
					if not a_cluster.is_precompiled or else
						Eiffel_system.is_precompiled 
					then
						d_name := a_cluster.document_path;
						if d_name /= Void then
							!! dir.make (d_name);
							if not dir.exists then
								dir.create_dir
							end;
							file_name := a_cluster.document_file_name;
							if file_name /= Void then
								!! st.make;
								a_cluster.generate_class_list (st);
								generate_output (filter, file_name, st)
							end
						end;
						classes := a_cluster.classes;
						from 
							classes.start 
						until 
							classes.after 
						loop
							a_class := classes.item_for_iteration.compiled_eclass;
							if a_class /= Void then
								list.put_front (a_class);
							end	
							classes.forth
						end
					end;
					clusters.forth
				end;
				!! class_formatter;
				class_formatter.set_feature_clause_order (feature_clause_order);
				inspect
					format_type
				when flat_type then
					type := "flat"
				when flat_short_type then
					class_formatter.set_is_short;
					type := "flat/short"
				when text_type then
					class_formatter.set_order_same_as_text;
					class_formatter.set_one_class_only
					type := "text"
				when short_type then
					class_formatter.set_is_short;
					class_formatter.set_one_class_only
					type := "short"
				end
				if not list.empty then
					d_output := generate_window;
					d_output.put_start_documentation (list.count, type);
					from 
						list.start 
					until 
						list.after 
					loop
						a_class := list.item;
						file_name := a_class.lace_class.document_file_name;
						if file_name = Void then
							d_output.skip_entity
						else
							d_output.put_class_document_message (a_class);
							!! st.make;
							if do_parents then	
								append_parents (st, a_class)
							end;
							class_formatter.format (a_class);
							text_st := class_formatter.text;
							from
								st.finish
							until	
								st.before
							loop
								text_st.put_front (st.item);
								st.back
							end;
							generate_output (filter, file_name, text_st)
						end;
						list.forth
					end;
					d_output.finish_degree_output
				end;
				error_window.display;
			end
		end;

feature {NONE} -- Implementation

	filter_name: STRING
			-- Filter name

	format_type: INTEGER;
			-- Format type

	flat_short_type, short_type, flat_type, text_type: INTEGER is unique

	error_window: OUTPUT_WINDOW;
			-- Output window used to display erros during the
			-- execution of Current

	append_parents (st: STRUCTURED_TEXT; e_class: E_CLASS) is
			-- Append parents to `st' for `e_class'.
		require
			valid_args: st /= Void and then e_class /= Void
		local
			parents: FIXED_LIST [CL_TYPE_A];
			processed: LINKED_LIST [E_CLASS];
			c: E_CLASS;
		do
			!! processed.make;
			processed.put_front (Eiffel_system.any_class.compiled_eclass)
			parents := e_class.parents;
			from
				parents.start
			until
				parents.after
			loop
				c := parents.item.associated_eclass;
				if not processed.has (c) then
					processed.extend (c)
				end;
				parents.forth
			end;
			processed.start; -- Remove class any
			processed.remove;
			if not processed.empty then
				if processed.count = 1 then
					st.add_string ("Ancestor:")
				else
					st.add_string ("Ancestors:")
				end;
				st.add_new_line;
				from
					processed.start
				until
					processed.after
				loop
					c := processed.item;
					st.add_indent;
					st.add_classi (c.lace_class, c.name_in_upper);
					st.add_new_line;
					processed.forth
				end;
				st.add_new_line;
			end
		end;

	generate_output (filter: TEXT_FILTER; file_name: FILE_NAME; st: STRUCTURED_TEXT) is
			-- Generate output with `filter' to file `file_name'
		require
			valid_f_name: file_name /= Void;
			valid_st: st /= Void
		local
			file_window: FILE_WINDOW;
			image, ext: STRING;
			f_name: FILE_NAME
		do
			if filter /= Void then
				filter.set_file_name (file_name);
				ext := filter.file_suffix
			end;
			if ext = Void then
				ext := "txt"
			end;
			f_name := clone (file_name);
			f_name.add_extension (ext)
			!! file_window.make (f_name);
			file_window.open_file;
			if not file_window.exists then
				error_window.put_string ("Cannot create file: ");
				error_window.put_string (f_name);
				error_window.new_line;
			else
				if filter /= Void then
					filter.process_text (st)
					image := filter.image;
					filter.wipe_out_image
				else
					image := st.image;
				end;
				file_window.put_string (image);
				file_window.close
			end;
		end;

	generate_cluster_list (st: STRUCTURED_TEXT; 
				clusters: ARRAYED_LIST [CLUSTER_I]; 
				indent: INTEGER) is
			-- Generate the cluster list for universe to `st'.
		require
			valid_st: st /= Void
		local
			c: CLUSTER_I;
			s_name: STRING
		do
			from
				clusters.start
			until
				clusters.after
			loop
				c := clusters.item;
				add_tabs (st, indent);
				st.add_indent;
				st.add_cluster (c, c.name_in_upper);
				st.add_new_line;
				generate_cluster_list (st, c.sub_clusters, indent + 1);
				clusters.forth
			end
		end;

end -- class E_GENERATE_DOCUMENTATION
