indexing

	description: 
		"Command to generate documentation for an Eiffel project.";
	date: "$Date$";
	revision: "$Revision $"

class E_GENERATE_DOCUMENTATION

inherit

	E_CMD;
	SHARED_EIFFEL_PROJECT

creation
	make_flat, 
	make_flat_short, 
	make_short, 
	make_text

feature -- Initialization

	make_flat (f_name: like filter_name) is
			-- Initialize document generation to flat.
		do
			format_type := flat_type;
			filter_name := f_name;
		end;

	make_flat_short (f_name: like filter_name) is
			-- Initialize document generation to flat_short.
		do
			format_type := flat_short_type;
			filter_name := f_name
		end;

	make_text (f_name: like filter_name) is
			-- Initialize document generation to text.
		do
			format_type := text_type;
			filter_name := f_name
		end;

	make_short (f_name: like filter_name) is
			-- Initialize document generation to text.
		do
			format_type := short_type;
			filter_name := f_name
		end;

feature -- Status report

	do_parents: BOOLEAN
			-- Print the parents as well?

	feature_clause_order: ARRAY [STRING]
			-- Array of orderd feature clause comments

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
			file_window: FILE_WINDOW;
			d_name: DIRECTORY_NAME;
			dir: DIRECTORY;
			image, ext: STRING;
			d_output: DEGREE_OUTPUT
		do
			clusters := Eiffel_universe.clusters;
			if not clusters.empty then
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
								dir.create
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
				when flat_short_type then
					class_formatter.set_is_short
				when text_type then
					class_formatter.set_order_same_as_text;
					class_formatter.set_one_class_only
				when short_type then
					class_formatter.set_is_short;
					class_formatter.set_one_class_only
				end
				if filter_name /= Void and then not filter_name.empty then
					!! filter.make (filter_name);
				end;
				if not list.empty then
					d_output := Degree_output;
					d_output.put_start_documentation (list.count);
					error_window.clear_window;
					from 
						list.start 
					until 
						list.after 
					loop
						a_class := list.item;
						d_output.put_class_document_message (a_class);
						file_name := a_class.lace_class.document_file_name;
						if file_name /= Void then
							if filter /= Void then
								ext := filter.file_suffix
							end;
							if ext = Void then	
								ext := "txt"
							end;
							file_name.add_extension (ext)
							!! file_window.make (file_name);
							file_window.open_file;
							if not file_window.exists then
								error_window.put_string ("Cannot create file: ");
								error_window.put_string (file_name);
								error_window.new_line;
							else
								if do_parents then	
									append_parents (file_window, filter, a_class)
								end
							-- FIXME **** testing class_formatter.format (a_class);
								if filter /= Void then
									filter.process_text (class_formatter.text)
									image := filter.image;
									filter.wipe_out_image
								else
									--image := class_formatter.text.image;
									image := "" -- testing
								end;
								file_window.put_string (image);
							end;
							file_window.close
						end;
						list.forth
					end;
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

	append_parents (file_window: FILE_WINDOW; filter: TEXT_FILTER; e_class: E_CLASS) is
			-- Append parents to `file_window' for `e_class'.
		require
			valid_args: file_window /= Void and then e_class /= Void
		local
			parents: FIXED_LIST [CL_TYPE_A];
			processed: LINKED_LIST [E_CLASS];
			c: E_CLASS;
			st: STRUCTURED_TEXT
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
				!! st.make;
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
				if filter = Void then
					file_window.put_string (st.image)
				else
					filter.process_text (st);
				end
			end
		end;

end -- class E_GENERATE_DOCUMENTATION
