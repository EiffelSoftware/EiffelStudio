indexing
	description: "Objects that input cluster directories"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EI_CLUSTER_DATA_INPUT

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize object.
		do
			create {ARRAYED_LIST [STRING]} clusters.make (20)
			create {ARRAYED_LIST [STRING]} include_path.make (20)
			create {ARRAYED_LIST [STRING]} objects.make (20)
		end

feature -- Access

	clusters: LIST [STRING]
			-- Clusters

	include_path: LIST [STRING]
			-- Include paths

	objects: LIST [STRING]
			-- Objects

feature -- Basic operations

	input_from_file (input_file: PLAIN_TEXT_FILE) is
			-- Input clusters information from Ace file 'input_file'
		require
			non_void_file: input_file /= Void
			file_exists: input_file.exists
			valid_file: input_file.is_closed or input_file.is_open_read
		local
			l_raw_data: ARRAYED_LIST [STRING]
		do
			create l_raw_data.make (20)
			if input_file.is_closed then
				input_file.open_read
			end

			from
				input_file.start
			until
				input_file.end_of_file
			loop
				input_file.read_line

				if not input_file.last_string.is_empty then
					if input_file.last_string.substring_index ("cluster", 1) = 1 then
						from
						until
							input_file.end_of_file
						loop
							input_file.read_line
							if not input_file.last_string.is_empty then
								l_raw_data.extend (input_file.last_string.twin)
							end
						end
					end
				end
			end

			input_file.close

			if not l_raw_data.is_empty then
				process_raw_data (l_raw_data)
			end
		end

feature {NONE} -- Implementation

	process_raw_data (a_raw_data: LIST [STRING]) is
			-- Process 'raw_data' into information.
		require
			non_void_list: a_raw_data /= Void
			valid_data: not a_raw_data.is_empty
		local
			str_buffer: STRING
			is_object, is_include_path: BOOLEAN
		do
			create str_buffer.make (200)
			from
				a_raw_data.start
			until
				a_raw_data.after or a_raw_data.item.substring_index ("external", 1) > 0
			loop
				if a_raw_data.item.index_of (':', 1) > 0 and 
							a_raw_data.item.index_of ('%"', 1) > a_raw_data.item.index_of (':', 1) then
					str_buffer.left_adjust
					str_buffer.right_adjust
					if not str_buffer.is_empty and not is_common_path (str_buffer) then
						clusters.extend (str_buffer)
					end
					str_buffer := a_raw_data.item.twin
					str_buffer.append ("%N")
				elseif a_raw_data.item.substring_index ("--", 1) = 0 then
					str_buffer.append (a_raw_data.item)
					str_buffer.append ("%N")
				end
				a_raw_data.forth
			end

			-- Append last cluster
			if not str_buffer.is_empty and not is_common_path (str_buffer) then
				clusters.extend (str_buffer)
			end

			if not a_raw_data.after then
				is_object := False
				is_include_path := False

				from
				until
					a_raw_data.after
				loop
					if a_raw_data.item.substring_index ("include_path:", 1) > 0 then
						a_raw_data.item.replace_substring_all ("include_path:", "")
						a_raw_data.item.left_adjust

						is_include_path := True
						is_object := False
					elseif a_raw_data.item.substring_index ("object:", 1) > 0 then
						a_raw_data.item.replace_substring_all ("object:", "")
						a_raw_data.item.left_adjust

						is_object := True
						is_include_path := False
					end

					a_raw_data.item.left_adjust
					a_raw_data.item.right_adjust

					-- Could be empty if line was "include_path:"
					if not a_raw_data.item.is_empty then
						if a_raw_data.item.item (a_raw_data.item.count) = ';' then
							a_raw_data.item.put (',', a_raw_data.item.count)
						end
						if a_raw_data.item.item (a_raw_data.item.count) /= ',' then
							a_raw_data.item.append_character (',')
						end
	
						if is_object and not is_common_path (a_raw_data.item) and a_raw_data.item.index_of ('%"', 1) > 0 then
							objects.extend (a_raw_data.item)
						elseif is_include_path and not is_common_path (a_raw_data.item) and a_raw_data.item.index_of ('%"', 1) > 0 then
							include_path.extend (a_raw_data.item)
						end
					end
					a_raw_data.forth
				end
			end
		end

	is_common_path (a_path: STRING): BOOLEAN is
			-- Is 'a_path' common for all program?
		require
			non_void_string: a_path /= Void
			valid_path: not a_path.is_empty
		do
			Result := a_path.substring_index ("library\base", 1) > 0 or
				a_path.substring_index ("library\com", 1) > 0 or
				a_path.substring_index ("library\wel", 1) > 0 or
				a_path.substring_index ("library\time", 1) > 0
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
end -- class EI_CLUSTER_DATA_INPUT

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

