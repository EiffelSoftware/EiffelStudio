note
	description: "Visitable items in metrics"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_VISITABLE

feature -- Access

	visitable_name: STRING_GENERAL
			-- Name of current visitable item
		deferred
		ensure
			result_attached: Result /= Void
		end

	identical_new_instance: like Current
			-- Identical new instance of Current.
			-- Void if error occurs.
		local
			l_callback: EB_METRIC_LOAD_DEFINITION_CALLBACKS
			l_xml_generator: EB_METRIC_XML_WRITER [like Current]
			l_document: XM_DOCUMENT
		do
			create l_xml_generator.make
			l_document := l_xml_generator.xml_document (Current)

			create l_callback.make_with_factory (create{EB_LOAD_METRIC_DEFINITION_FACTORY})
			l_callback.set_is_for_whole_file (False)

			l_document.process_to_events (l_callback)
			if not l_callback.has_error then
				Result ?= l_callback.first_parsed_node
			end
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		require
			a_visitor_attached: a_visitor /= Void
		deferred
		end

note
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
