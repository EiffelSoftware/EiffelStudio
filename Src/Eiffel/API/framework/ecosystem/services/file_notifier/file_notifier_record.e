indexing
	description: "[
		Represents a cached file information record for use with the file notification service {FILE_NOTIFICATION_S}.
	]"
	doc: "wiki://File Notifier Service"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_NOTIFIER_RECORD

create {FILE_NOTIFIER}
	make

feature {NONE} -- File was changed

	make (a_file_name: like file_name)
			-- Initializes a file recording using a location the file record will represent.
			--
			-- `a_file_name': The absolute file path to a file the record is to represent.
		require
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			file_name := a_file_name
			refresh
		ensure
			file_name_set: a_file_name.is_equal (file_name)
		end

feature -- Access

	file_name: !STRING_32
			-- The associate file record's absolute file path.

	time_stamp: INTEGER_32
			-- Last known file time stamp, set on the last refresh.

feature {FILE_NOTIFIER} -- Access

	monitor_count: NATURAL_16
			-- The monitor lock count, used by a catalog to determine if the associate file should be monitored or not.

feature {FILE_NOTIFIER} -- Element change

	increment_monitor_lock
			-- Increases the monitor lock count so a catalog can retain the file record for monitoring purposes.
		require
			monitor_count_small_enought: monitor_count < monitor_count.max_value
		do
			monitor_count := monitor_count + 1
		ensure
			monitor_count_increased: monitor_count = old monitor_count + 1
		end

	decrement_monitor_lock
			-- Decreases the monitor lock count so the record and record catalog can track if the file
			-- needs to continue monitoring the file.
		require
			monitor_count_positive: monitor_count > 0
		do
			monitor_count := (monitor_count - 1).to_natural_16
		ensure
			monitor_count_dencreased: monitor_count = old monitor_count - 1
		end

feature -- Status report

	is_monitoring: BOOLEAN
			-- Indicates if the associated file is being monitored by any client.
		do
			Result := monitor_count > 0
		ensure
			monitor_count_positive: Result implies monitor_count > 0
		end

	file_exists: BOOLEAN
			-- Indicates if the file existed at the last refresh.
		do
			Result := time_stamp > delete_file_time_stamp
		ensure
			timestamp_set_to_delete_file_timestamp: (Result and time_stamp > delete_file_time_stamp) or (not Result and time_stamp = delete_file_time_stamp)
		end

feature {FILE_NOTIFIER} -- Basic operations

	refresh
			-- Refreshes all cached information regarding the file record
		local
			l_file: KL_BINARY_INPUT_FILE
		do
			create l_file.make (file_name)
			if not l_file.exists then
				time_stamp := delete_file_time_stamp
			else
				time_stamp := l_file.time_stamp
			end
		end

feature -- Constants

	delete_file_time_stamp: INTEGER = 0
			-- Time stamp constant indicating a non-existing file

invariant
	not_file_name_is_empty: not file_name.is_empty
	time_stamp_positive: file_exists implies time_stamp > 0

;indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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

end -- class FILE_NOTIFIER_MODIFICATION_TYPES

