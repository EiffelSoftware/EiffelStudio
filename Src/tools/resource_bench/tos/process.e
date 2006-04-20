indexing
	description: "Class for processing resource script file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision : "$Revision$"

class
	PROCESS

inherit
	MEMORY

	RESOURCE_SCRIPT_LEX
		undefine
			is_equal, copy
		end

	INTERFACE_MANAGER

	STORABLE

creation
	make, retrieve_grammar

feature -- Initialization

	make is
			-- create the resource file analyzer
		do  
			interface.display_text (std_out, "Building the grammar...")

			!! resource_script_file.make
			build (resource_script_file.document)
		end

	retrieve_grammar (a_file: RAW_FILE) is
			-- retrieve the grammar structure from the file `a_file'
		require
			a_file_exists: a_file.exists
		local
			grammar: PROCESS
		do
			interface.display_text (std_out, "Retrieving the grammar...")

			grammar ?= retrieved (a_file)
	--		deep_copy (grammar)
			copy (grammar)
			resource_script_file.document.deep_copy (grammar.doc)
			resource_script_file.document.set_lexical (grammar.doc.analyzer.deep_twin)
			rsf_copy.document.deep_copy (grammar.doc)
		end

feature -- Access

	resource_script_file: RESOURCE_SCRIPT_FILE
			-- the root of the grammar

	rsf_copy: RESOURCE_SCRIPT_FILE
			-- copy of `resource_script_file' (needed to store and retrieve the grammar)

	doc: INPUT
			-- copy of the once function `document' of `resource_script_file'
			-- (needed to store and retrieve the grammar)

	production: LINKED_LIST [CONSTRUCT]
			-- copy of the one function `production' of `resource_script_file'
			-- (needed to store and retrieve the grammar)

feature

	check_recursion is
			-- check for left-recursion in the resource grammar
		local
			t_b: BOOLEAN

		do
			interface.display_text (std_out, "Checking for left recursion...")

			resource_script_file.print_mode.put (true)
			resource_script_file.expand_all
			t_b := not resource_script_file.left_recursion
			resource_script_file.check_recursion

			if not resource_script_file.left_recursion.item then
				interface.display_text (std_out, "No left recursion detected%N")
			else
				interface.display_text (std_error, "Left recursion detected%N")
			end
		end

	parsing (a_filename: STRING) is
			-- parse the resource file `a_filename'
		require
			a_filename_exists: a_filename /= Void and then a_filename.count > 0
		local
			file: PLAIN_TEXT_FILE
		do
			collection_off

			interface.display_text (std_out, "Analyzing the resource file...")

			!! file.make_open_read (a_filename)
			file.read_stream (file.count)

			resource_script_file.document.set_input_string (file.last_string);

			resource_script_file.document.get_token;
			resource_script_file.process;

			interface.display_text (std_out, "Analyzing end.")

			collection_on
		end

	store_grammar (a_file: RAW_FILE) is
			-- store the grammar structure into the file `a_file'
		require
			a_file_not_void: a_file /= Void
			a_file_exists: a_file.exists
		local
			toto: INPUT
			titi: LINKED_LIST [CONSTRUCT]
		do
			toto := resource_script_file.document.deep_twin
			doc := toto.deep_twin

			titi := resource_script_file.production.deep_twin
			production := titi.deep_twin

			rsf_copy := resource_script_file.deep_twin

			basic_store (a_file)
		end

	regenerate is
			-- regenerate the analyzer in order to make a new analyze
		do
			resource_script_file.deep_copy (rsf_copy)
			resource_script_file.document.deep_copy (doc)
			resource_script_file.document.set_lexical (doc.analyzer.deep_twin)

			resource_script_file.production.standard_copy (production)
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
end -- class PROCESS

