indexing
	description: "Objects that input cluster directories"
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
			create clusters.make
			create include_path.make
			create objects.make
		end

feature -- Access

	clusters: LINKED_LIST[STRING]
			-- Clusters

	include_path: LINKED_LIST[STRING]
			-- Include paths

	objects: LINKED_LIST[STRING]
			-- Objects

feature -- Basic operations

	input_from_file (input_file: PLAIN_TEXT_FILE) is
			-- Input clusters information from Ace file 'input_file'
		require
			non_void_file: input_file /= Void
			file_exists: input_file.exists
			valid_file: input_file.is_closed or input_file.is_open_read
		local
			raw_data: LINKED_LIST[STRING]
		do
			create raw_data.make
			if input_file.is_closed then
				input_file.open_read
			end

			from
				input_file.start
			until
				input_file.end_of_file
			loop
				input_file.read_line

				if not input_file.last_string.empty then
					if input_file.last_string.substring_index ("cluster", 1) = 1 then
						from
						until
							input_file.end_of_file
						loop
							input_file.read_line
							if not input_file.last_string.empty then
								raw_data.extend (clone (input_file.last_string))
							end
						end
					end
				end
			end

			input_file.close

			if not raw_data.empty then
				process_raw_data (raw_data)
			end
		end

feature {NONE} -- Implementation

	process_raw_data (raw_data: LINKED_LIST[STRING]) is
			-- Process 'raw_data' into information.
		require
			non_void_list: raw_data /= Void
			valid_data: not raw_data.empty
		local
			str_buffer: STRING
			is_object, is_include_path: BOOLEAN
		do
			create str_buffer.make (200)
			from
				raw_data.start
			until
				raw_data.after or raw_data.item.substring_index ("external", 1) > 0
			loop
				if raw_data.item.index_of (':', 1) > 0 and 
							raw_data.item.index_of ('%"', 1) > raw_data.item.index_of (':', 1) then
					str_buffer.left_adjust
					str_buffer.right_adjust
					if not str_buffer.empty and not is_common_path (str_buffer) then
						clusters.extend (str_buffer)
					end
					str_buffer := clone (raw_data.item)
					str_buffer.append ("%N")
				elseif raw_data.item.substring_index ("--", 1) = 0 then
					str_buffer.append (raw_data.item)
					str_buffer.append ("%N")
				end
				raw_data.forth
			end

			if not raw_data.after then
				is_object := False
				is_include_path := False

				from
				until
					raw_data.after
				loop
					if raw_data.item.substring_index ("include_path:", 1) > 0 then
						raw_data.item.replace_substring_all ("include_path:", "")
						raw_data.item.left_adjust

						is_include_path := True
						is_object := False
					elseif raw_data.item.substring_index ("object:", 1) > 0 then
						raw_data.item.replace_substring_all ("object:", "")
						raw_data.item.left_adjust

						is_object := True
						is_include_path := False
					end

					raw_data.item.left_adjust
					raw_data.item.right_adjust

					if raw_data.item.item (raw_data.item.count) = ';' then
						raw_data.item.put (',', raw_data.item.count)
					end
					if raw_data.item.item (raw_data.item.count) /= ',' then
						raw_data.item.append_character (',')
					end

					if is_object and not is_common_path (raw_data.item) and raw_data.item.index_of ('%"', 1) > 0 then
						objects.extend (raw_data.item)
					elseif is_include_path and not is_common_path (raw_data.item) and raw_data.item.index_of ('%"', 1) > 0 then
						include_path.extend (raw_data.item)
					end
					raw_data.forth
				end
			end
		end

	is_common_path (a_path: STRING): BOOLEAN is
			-- Is 'a_path' common for all program?
		require
			non_void_string: a_path /= Void
			valid_path: not a_path.empty
		do
			if a_path.substring_index ("library\base", 1) > 0 or
					a_path.substring_index ("library\com", 1) > 0 or
					a_path.substring_index ("library\wel", 1) > 0 or
					a_path.substring_index ("library\time", 1) > 0 then
				Result := True
			else
				Result := False
			end
		end

end -- class EI_CLUSTER_DATA_INPUT
