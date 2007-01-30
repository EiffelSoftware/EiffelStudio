indexing
	description: "Visitable items in metrics"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_VISITABLE

inherit
	EB_METRIC_FILE_LOADER

feature -- Access

	visitable_name: STRING_GENERAL is
			-- Name of current visitable item
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_instance (a_callback: EB_LOAD_METRIC_CALLBACKS): like Current is
			-- New instance of Current using `a_callback'.
			-- Void if error occurs.
		require
			a_callback_attached: a_callback /= Void
		local
			l_xml_writer: EB_METRIC_XML_WRITER
			l_error: EB_METRIC_ERROR
		do
			a_callback.set_first_parsed_node (Void)
			create l_xml_writer.make
			l_xml_writer.append_text (Current)
			l_error := parse_from_string (l_xml_writer.text, a_callback)
			if l_error = Void then
				Result ?= a_callback.first_parsed_node
			end
		end

	identical_new_instance: like Current is
			-- Identical new instance of Current.
			-- Void if error occurs.
		local
			l_callback: EB_METRIC_LOAD_DEFINITION_CALLBACKS
		do
			create l_callback.make_with_factory (create{EB_LOAD_METRIC_DEFINITION_FACTORY})
			l_callback.set_is_for_whole_file (False)
			Result := new_instance (l_callback)
		end

feature -- Process

	append_xml (a_xml_writer: EB_METRIC_XML_WRITER) is
			-- Append XML representation of Current into `a_xml_writer'.
		require
			a_xml_writer_attached: a_xml_writer /= Void
		do
			a_xml_writer.append_text (Current)
		end

	process (a_visitor: EB_METRIC_VISITOR) is
			-- Process current using `a_visitor'.
		require
			a_visitor_attached: a_visitor /= Void
		deferred
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


end
