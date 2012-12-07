note
	description: "[
					Layout Contructor's tree manager when using DLL
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_LAYOUT_CONSTRUCTOR_TREE_MANAGER_DLL

inherit
	ER_LAYOUT_CONSTRUCTOR_TREE_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create shared_singleton
			create vision_xml_translator.make
		end

feature -- Command

	save_tree
			-- Save to Microsoft Ribbon makrup XML directly
			-- Save different Window's Ribbon to different xml markup files
		local
			l_printer: XML_NODE_PRINTER
			l_output_stream: ER_XML_OUTPUT_STREAM
			l_document: XML_DOCUMENT
			l_index: INTEGER
			l_found_and_saved: BOOLEAN
			l_max_count: INTEGER
		do
			if attached shared_singleton.project_info_cell.item as l_project_info then
				from
					l_index := 1
					l_max_count := l_project_info.ribbon_window_count
				until
					l_index > l_max_count
				loop
					l_found_and_saved := vision_xml_translator.save_xml_nodes_for_one_layout_constructors (l_index)
					check l_found_and_saved end
					l_document := vision_xml_translator.xml_document

					create l_printer.make

					create l_output_stream.make (l_index)
					l_printer.set_output (l_output_stream)

					l_document.process (l_printer)

					l_output_stream.close

					l_index := l_index + 1
				end
			end
		end

	load_tree (a_ribbon_window_count: INTEGER)
			-- <Precursor>
		local
			l_u: FILE_UTILITIES
			l_index: INTEGER
			l_constants: ER_MISC_CONSTANTS
			l_stop: BOOLEAN
		do
			from
				prepare_layout_constructors (a_ribbon_window_count)
				create l_constants
				l_index := 1
			until
				l_index > a_ribbon_window_count or l_stop
			loop
				if attached l_constants.xml_full_file_name (l_index) as l_file_name then
					if l_u.file_path_exists (l_file_name) then
						load_tree_imp (l_index)
					else
						l_stop := True
					end
				else
					l_stop := True
				end

				l_index := l_index + 1
			end

		end

feature {NONE} -- Implementation

	vision_xml_translator: ER_VISION_XML_TREE_TRANSLATOR
			-- Vision2 tree to Ribbon markup XML tree translator

	prepare_layout_constructors (a_ribbon_window_count: INTEGER)
			-- Prepare Layout Constructor Tools
		local
			l_index: INTEGER
			l_layout_constructor: ER_LAYOUT_CONSTRUCTOR
		do
			from
				l_index := 1
			until
				l_index > a_ribbon_window_count
			loop
				if shared_singleton.layout_constructor_list.valid_index (l_index) then
					l_layout_constructor := shared_singleton.layout_constructor_list.i_th (l_index)
				else
					create l_layout_constructor.make
					if attached shared_singleton.main_window_cell.item as l_main_window then
						if attached l_main_window.docking_manager as l_docking_manager then
							l_layout_constructor.attach_to_docking_manager (l_docking_manager)
						end
					end
				end

				l_layout_constructor.widget.wipe_out

				l_index := l_index + 1
			end
		end

	load_tree_imp (a_index: INTEGER)
			-- Load XML tree
		require
			valid: a_index >= 1
		local
			l_manager: ER_XML_TREE_MANAGER
			l_factory: ER_VISITOR_FACTORY
			l_visitors: ARRAYED_LIST [ER_VISITOR]
		do
			l_manager := shared_singleton.xml_tree_manager.item
			l_manager.load_tree (a_index)

			if attached l_manager.xml_root as l_root then
				create l_factory
				l_visitors := l_factory.visitors
				from
					l_visitors.start
				until
					l_visitors.after
				loop
					l_root.accept (l_visitors.item, a_index)
					l_visitors.forth
				end
			else
				check False end
			end
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
