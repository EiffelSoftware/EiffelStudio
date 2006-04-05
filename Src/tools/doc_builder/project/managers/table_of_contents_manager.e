indexing
	description: "Manager for Table of Contents."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_CONTENTS_MANAGER

inherit
	SHARED_OBJECTS
	
	XML_ROUTINES
	
	TABLE_OF_CONTENTS_CONSTANTS

create
	make

feature -- Creation

	make is
			-- Create 
		do
			create loaded_tocs.make (0)
			create loaded_widgets.make (0)
			counter := 0
		end
		
feature -- TOC Management

	new_toc (a_name: STRING) is
			-- A new empty toc
		do
			create loaded_toc.make_empty
			loaded_toc.set_name (a_name)
			add_toc (loaded_toc)
			load_toc (loaded_toc.name)
		end		

	open_toc is
			-- Open toc from file
		local
			l_open_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_open_dialog
			l_open_dialog.show_modal_to_window (parent_window)
			if l_open_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_open) then
				load_toc (l_open_dialog.file_name)
			end
		end		
	
	save_toc is
			-- Save loaded toc
		do	
			synchronize			
			loaded_toc.save			
			loaded_tocs.replace_key (loaded_toc.name, loaded_toc.old_name)
			loaded_widgets.replace_key (loaded_toc.name, loaded_toc.old_name)
		end		
	
	build_toc (a_name: STRING; a_dir: DIRECTORY) is
			-- Build toc from contents of `a_dir'
		do
			create loaded_toc.make_from_directory (a_dir)
			loaded_toc.set_name (a_name)
			add_toc (loaded_toc)
			load_toc (loaded_toc.name)
		end	
		
	build_toc_sub_dirs (a_name: STRING; a_dir: DIRECTORY; include_dirs: ARRAYED_LIST [STRING]) is
			-- Build toc from contents of `a_dir'
		do
			create loaded_toc.make_from_directory_sub_dirs (a_dir, include_dirs)
			loaded_toc.set_name (a_name)
			add_toc (loaded_toc)
			load_toc (loaded_toc.name)
		end	
		
	load_toc (a_name: STRING) is
			-- Load a toc from `a_name'
		require
			filename_not_void: a_name /= Void
		local
			xml: XM_DOCUMENT
			xml_toc_converter: XML_TABLE_OF_CONTENTS_CONVERTER
		do				
			if loaded_tocs.has (a_name) then
				loaded_toc := loaded_tocs.item (a_name)
			else
						-- Create XML document from `a_filename'
				xml ?= deserialize_document (create {FILE_NAME}.make_from_string (a_name))
				if xml /= Void then
					create xml_toc_converter.make
					xml.process_children_recursive (xml_toc_converter)
--					xml_toc_converter.process_document (xml)
					loaded_toc := xml_toc_converter.toc
					loaded_toc.set_name (a_name)
					add_toc (loaded_toc)
					xml_toc_converter := Void					
				end
			end
			if loaded_toc /= Void then
				display_toc
			end
		end		
	
	add_toc (a_toc: TABLE_OF_CONTENTS) is
			-- Add toc
		require
			toc_not_void: a_toc /= Void
		do
			if not loaded_tocs.has (a_toc.name) then				
				loaded_tocs.extend (a_toc, a_toc.name)	
			end
		ensure
			has_toc: loaded_tocs.has (a_toc.name)
		end		
	
	merge_tocs (tocs: LIST [TABLE_OF_CONTENTS]; a_name: STRING) is
			-- Merge `tocs' into new toc with `a_name'
		require
			tocs_not_void: tocs /= Void
			mergable: tocs.count > 1
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
		local
			l_new_toc: TABLE_OF_CONTENTS 
		do
			create l_new_toc.make_empty
			from
				tocs.start
			until
				tocs.after
			loop
				l_new_toc.add_node (tocs.item)
				tocs.item.set_title (tocs.item.name)
				tocs.forth
			end
			l_new_toc.set_name (a_name)
			l_new_toc.flatten_ids
			add_toc (l_new_toc)
			load_toc (l_new_toc.name)	
		end		
	
feature -- Node 	
		
	new_node (is_heading: BOOLEAN) is
			-- Add new node to `displayed_toc'
		local
			l_new_node: TABLE_OF_CONTENTS_WIDGET_NODE
		do
			create l_new_node.make ("New Topic", Void, next_id, is_heading)
			displayed_toc.add_node (l_new_node)
		end		
		
	remove_node is
			-- Remove selected node in displayed toc
		do
			if displayed_toc.selected_item /= Void then
				displayed_toc.remove_node
			end
		end
		
	move_node (up: BOOLEAN) is
			-- 
		local
			l_item: TABLE_OF_CONTENTS_WIDGET_NODE
		do	
			l_item ?= displayed_toc.selected_item
			if l_item /= Void then
				l_item.move_node (up)
			end
		end	
		
feature -- Commands		
		
	sort_toc (a_filter: DOCUMENT_FILTER; index_root, empty_elements, no_index, sub_elements, alpha: BOOLEAN; a_desc: STRING) is
			-- Sort `loaded toc'.  (A new sorted is created from the current toc)
		do	
			create loaded_toc.make_from_toc (loaded_toc)
			synchronize
			
			if a_desc.is_empty then
				loaded_toc.set_name (next_toc_name)
			else
				loaded_toc.set_name (a_desc)
			end			
			
			loaded_toc.set_filter (a_filter)
			loaded_toc.set_make_index_root (index_root)
			loaded_toc.set_filter_empty_nodes (not empty_elements)
			loaded_toc.set_filter_nodes_no_index (not no_index)
			loaded_toc.set_filter_skipped_sub_nodes (not sub_elements)			
			loaded_toc.set_filter_alphabetically (alpha)
			loaded_toc.sort	
			add_toc (loaded_toc)
			load_toc (loaded_toc.name)
		end		

	synchronize is
			-- Synchronize loaded toc with widget
		local
			l_name: STRING
			l_persisted: BOOLEAN
		do
			l_persisted := loaded_toc.is_persisted			
			if displayed_toc.modified then				
				l_name := loaded_toc.name
				create loaded_toc.make_from_tree (displayed_toc)
				loaded_toc.set_name (l_name)				
				displayed_toc.set_modified (False)
				loaded_toc.set_persisted (l_persisted)
			end	
		end		

feature -- Access

	loaded_toc: TABLE_OF_CONTENTS
			-- Toc currently loaded (Void if none loaded)

	displayed_tocs: ARRAY [STRING] is
			-- Return a list of all toc widgets names
		do
			Result := loaded_widgets.current_keys
		end		

	toc_by_name (a_name: STRING): TABLE_OF_CONTENTS is
			-- Return toc by name
		do
			if loaded_tocs.has (a_name) then
				Result := loaded_tocs.item (a_name)
			end
		end	

feature -- Query

	is_empty: BOOLEAN is
			-- Is Current empty?
		do
			Result := loaded_tocs.is_empty	
		end	

feature {TABLE_OF_CONTENTS, TABLE_OF_CONTENTS} -- Query

	next_toc_name: STRING is
			-- Next generated unique toc name
		do
			create Result.make_from_string ("TOC_" + counter.out)
			counter := counter + 1
		end

feature {NONE} -- Implementation
						
	loaded_tocs: HASH_TABLE [TABLE_OF_CONTENTS, STRING]
			-- Loaded tocs hashed by associated name
			
	loaded_widgets: HASH_TABLE [TABLE_OF_CONTENTS_WIDGET, STRING]
			-- Loaded TOC tree widgets

	parent_window: DOC_BUILDER_WINDOW is
			-- Parent window
		once
			Result := Application_window
		end

	counter: INTEGER
			-- Increment

	displayed_toc: TABLE_OF_CONTENTS_WIDGET
			-- Currently displayed toc widget
	
	display_toc is
			-- Display `loaded_toc' as widget
		local
			l_name: STRING
		do
			l_name := loaded_toc.name
			if loaded_widgets.has (l_name) then
				displayed_toc := loaded_widgets.item (l_name)
			else
				create displayed_toc.make (loaded_toc)
				loaded_widgets.extend (displayed_toc, loaded_toc.name)
			end
			Parent_window.set_toc_widget (displayed_toc)
			Parent_window.update
		end		
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end -- class TABLE_OF_CONTENTS_MANAGER
