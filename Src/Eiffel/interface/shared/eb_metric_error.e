note
	description: "Metric error class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_ERROR

inherit
	SHARED_BENCH_NAMES

create
	make

feature{NONE} -- Initialization

	make (a_message: like message)
			-- Initialize `message' with `a_message'.
		require
			a_message_attached: a_message /= Void
		do
			set_message (a_message)
		end

feature -- Access

	message: STRING_GENERAL
			-- The error message.

	to_do: STRING_GENERAL
			-- Information about how to do to deal with current error

	location: STRING_GENERAL
			-- Location where current error occurs

	file_location: STRING_GENERAL
			-- File location if Current error occurs in a file

	message_with_location: STRING_GENERAL
			-- `message' with `location' (if any)
		local
			l_str: STRING_32
		do
			create l_str.make (message.count + 64)
			l_str.append (message)
			if location /= Void then
				l_str.append (metric_names.new_line_separator)
				l_str.append (metric_names.location_string (location))
			end
			if is_xml_location_set then
				l_str.append (metric_names.new_line_separator)
				l_str.append (metric_names.xml_position (xml_column, xml_row))
			end
			if file_location /= Void then
				l_str.append (metric_names.new_line_separator)
				l_str.append (metric_names.coloned_string (names.l_file_location, True))
				l_str.append (metric_names.space_separator)
				l_str.append (file_location)
			end
			Result := l_str
		ensure
			result_attached: Result /= Void
		end

	xml_location: TUPLE [column: INTEGER; row: INTEGER]
			-- Location in xml file where Current error happened

	xml_row: INTEGER
			-- 	Row in `xml_location'.
		require
			xml_location_set: is_xml_location_set
		do
			Result := xml_location.row
		end

	xml_column: INTEGER
			-- 	Row in `xml_location'.
		require
			xml_location_set: is_xml_location_set
		do
			Result := xml_location.column
		end

feature -- Status report

	is_xml_location_set: BOOLEAN
			-- Is `xml_location' set?
			-- Not set if Current error is not related to xml file.
		do
			Result := xml_location /= Void
		ensure
			good_result: Result implies xml_location /= Void and then (not Result implies xml_location = Void)
		end

	is_file_location_set: BOOLEAN
			-- Is `file_location' set?
		do
			Result := file_location /= Void
		end

feature -- Setting

	set_message (a_message: like message)
			-- Set `message 'with `a_message'.
		require
			a_message_attached: a_message /= Void
		do
			message := a_message.twin
		ensure
			message_set: message /= Void
		end

	set_location (a_location: like location)
			-- Set `location 'with `a_location'.
		do
			if a_location /= Void then
				location := a_location.twin
			else
				location := Void
			end
		ensure
			location_set: (a_location /= Void implies location.is_equal (a_location)) and then
						  (a_location = Void) implies location = Void
		end

	set_to_do (a_to_do: like to_do)
			-- Set `to_do' with `a_to_do'.
		do
			if a_to_do /= Void then
				to_do := a_to_do.twin
			else
				to_do := Void
			end
		ensure
			to_do_set: (a_to_do = Void implies to_do = Void) and (a_to_do /= Void implies to_do /= Void)
		end

	set_file_location (a_file_location: like file_location)
			-- Set `file_location' with `a_file_location'.
		do
			if a_file_location = Void then
				file_location := Void
			else
				file_location := a_file_location.twin
			end
		ensure
			file_location_set:
				(a_file_location = Void implies file_location = Void) and then
				(a_file_location /= Void implies (file_location /= Void and then file_location.is_equal (a_file_location)))
		end

	set_xml_location (a_location: like xml_location)
			-- Set `xml_location' with `a_location'.
		do
			xml_location := a_location
		ensure
			xml_location_set: xml_location = a_location
		end

invariant
	message_attached: message /= Void

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
