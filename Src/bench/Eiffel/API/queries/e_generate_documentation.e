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

	EB_FLAT_SHORT_DATA
		export
			{NONE} all
		end

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

feature -- Execution

	execute is
			-- Show classes in universe
		local
			doc: DOCUMENTATION
			dir: DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				create doc.make
				doc.set_filter (filter_name)
	
				doc.set_class_formats (
					format_type = text_type,
					format_type = flat_type,
					format_type = short_type,
					format_type = flat_short_type,
					True,
					True
				)
	
				create dir.make (Eiffel_system.document_path)
				doc.set_directory (dir)
				doc.set_all_universe
				doc.set_cluster_formats (True, False)
				doc.set_system_formats (True, True, True)
				doc.set_excluded_indexing_items (excluded_indexing_items.linear_representation)
				doc.generate (generate_window)
			end
		rescue
			error_window.put_string (
				"'" + dir.name +
				"' is not a valid directory and/or cannot be created")
			error_window.new_line
			error_window.put_string ("Please choose a valid and writable directory.")
			retried := True
			retry
		end

feature {NONE} -- Implementation

	filter_name: STRING
			-- Filter name

	format_type: INTEGER;
			-- Format type

	flat_short_type, short_type, flat_type, text_type: INTEGER is unique

	error_window: OUTPUT_WINDOW;
			-- Output window used to display erros during the
			-- execution of Current

	append_parents (st: STRUCTURED_TEXT; e_class: CLASS_C) is
			-- Append parents to `st' for `e_class'.
		require
			valid_args: st /= Void and then e_class /= Void
		local
			parents: FIXED_LIST [CL_TYPE_A];
			processed: LINKED_LIST [CLASS_C];
			c: CLASS_C;
		do
			!! processed.make;
			processed.put_front (Eiffel_system.any_class.compiled_class)
			parents := e_class.parents;
			from
				parents.start
			until
				parents.after
			loop
				c := parents.item.associated_class;
				if not processed.has (c) then
					processed.extend (c)
				end;
				parents.forth
			end;
			processed.start; -- Remove class any
			processed.remove;
			if not processed.is_empty then
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

feature {NONE} -- Implementation

	add_tabs (st:STRUCTURED_TEXT; i: INTEGER) is
			-- Add `i' tabs to `structured_text'.
		local
			j: INTEGER
		do
			from
				j := 1;
			until
				j > i
			loop
				st.add_indent;
				j := j + 1
			end;
		end;

end -- class E_GENERATE_DOCUMENTATION
