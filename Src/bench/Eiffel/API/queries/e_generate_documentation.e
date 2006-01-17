indexing

	description: 
		"Command to generate documentation for an Eiffel project."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_GENERATE_DOCUMENTATION

inherit
	E_CMD

	SHARED_EIFFEL_PROJECT
	
	SHARED_TEXT_ITEMS

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EIFFEL_ENV
		export
			{NONE} all
		end

create
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
			if has_documentation_generation and not retried then
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
				doc.set_excluded_indexing_items (preferences.flat_short_data.excluded_indexing_items.linear_representation)
				doc.generate (generate_window)
			end
		rescue
			error_window.put_string (
				(create {WARNING_MESSAGES}).w_invalid_directory_or_cannot_be_created (dir.name))
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
			create processed.make;
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
			f_name := file_name.twin
			f_name.add_extension (ext)
			create file_window.make (f_name);
			file_window.open_file;
			if not file_window.exists then
				error_window.put_string ("Cannot create file: ");
				error_window.put_string (f_name);
				error_window.put_new_line;
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

end -- class E_GENERATE_DOCUMENTATION
