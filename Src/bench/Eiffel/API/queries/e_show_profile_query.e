class E_SHOW_PROFILE_QUERY

inherit
	E_CMD
		rename
			make as e_cmd_make
		redefine
			executable
		end

creation
	make

feature -- Initialization

	make (new_output: CLICK_WINDOW;
		profiler_query: PROFILER_QUERY;
		profiler_options: PROFILER_OPTIONS) is
			-- Create the object and use `new_output'
			-- for output.
		require
			new_output_not_void: new_output /= Void;
			profiler_query_not_void: profiler_query /= Void;
			profiler_options_not_void: profiler_options /= Void
		do
			output_window := new_output;
			prof_query := profiler_query;
			prof_options := profiler_options;
			!! expanded_filenames.make;
		end

feature -- Access

	executable: BOOLEAN is
			-- Is Current executable?
		do
			Result := output_window /= Void and then
					prof_query /= Void and then
					prof_options /= Void
		end;

feature -- Result computation

	execute is
			-- Computes results of the query.
		do
			from
				expand_columnnames
				expand_filenames
				expanded_filenames.start
			until
				expanded_filenames.after
			loop
				read_specified_file
				if profile_information /= Void then
					print_header;
					generate_filters;
					print_result
				end
				expanded_filenames.forth
			end
		end

feature -- Last output

	last_output: PROFILE_INFORMATION is
		do
			Result := int_last_output;
		end;

	set_last_output (new_output: PROFILE_INFORMATION) is
			-- Sets `new_output' to `last_output'.
		require
			no_ghosts: new_output /= Void;
		do
			int_last_output := new_output;
		ensure
			proper_work: last_output = new_output;
		end;


feature {QUERY_EXECUTER} -- Implementation

	read_specified_file is
			-- Retrieves an object from storage.
		local
			retried: BOOLEAN;
			current_item: STRING;
			store: STORABLE
		do
			if not retried then
				current_item := expanded_filenames.item
				if not current_item.is_equal ("last_output") then
					profile_information ?= store.retrieve_by_name(expanded_filenames.item)
					if profile_information /= Void then
						output_window.put_string("%N%N:::::::::::::::::::::::::::::::::::%N")
						output_window.put_string(expanded_filenames.item)
						output_window.put_string("%N:::::::::::::::::::::::::::::::::::%N%N")
					end
				else
					output_window.put_string ("%N%N:::::::::::::::::::::::::::::::%N");
					output_window.put_string ("last output");
					output_window.put_string ("%N:::::::::::::::::::::::::::::::%N%N");
					profile_information := int_last_output;
				end;
			end
		rescue
			retried := true
			retry
		end

	expand_columnnames is
			-- Expands `all' to all posible columnnames
		do
			if prof_options.output_names.item (1).is_equal ("all") then
				prof_options.output_names.force ("percentage", 1);
				prof_options.output_names.force ("self", 2);
				prof_options.output_names.force ("descendents", 3);
				prof_options.output_names.force ("total", 4);
				prof_options.output_names.force ("calls", 5);
				prof_options.output_names.force ("featurename", 6)
			end
		end

	expand_filenames is
			-- Expands wildcarded filenames to non-wildcarded filenames
		local
			i: INTEGER
			dir_name, wc_name, name: STRING
			directory: DIRECTORY
			wildcard_matcher: WILDCARD_MATCHER
			entries: ARRAYED_LIST [STRING]
			empty_array: ARRAY [STRING]
		do
			from
				i := 1
			until
				i > prof_options.filenames.count
			loop
				name := prof_options.filenames @ i
				if has_wildcards(name) then
					dir_name := extract_directory_name(name)
					if dir_name.count = 0 then
						dir_name := "."
					end
					wc_name := extract_filename(name)
					!! directory.make (dir_name)
					if directory.exists then
						from
							!! wildcard_matcher.make (wc_name)
							entries := directory.linear_representation
							entries.start
							entries.forth
							entries.forth
						until
							entries.after
						loop
							wildcard_matcher.set_input_string (entries.item)
							wildcard_matcher.match
							if wildcard_matcher.matched then
								expanded_filenames.extend(entries.item)
							end
							entries.forth
						end					
					end
				else
					expanded_filenames.extend (name)
				end
				i := i + 1
			end

				-- Copy filenames back in the original array
				-- to keep them for the next run as default.
			from
				!! empty_array.make (1, 0);
				prof_options.filenames.copy (empty_array);
				expanded_filenames.start;
			until
				expanded_filenames.after
			loop
				prof_options.filenames.force (expanded_filenames.item, prof_options.filenames.count + 1);
				expanded_filenames.forth;
			end;
		end

	has_wildcards(name: STRING): BOOLEAN is
		do
			Result := (name.index_of ('*', 1) > 0) or else
						(name.index_of ('?', 1) > 0)
		end

	extract_directory_name(name: STRING): STRING is
		local
			new_index, old_index: INTEGER
		do
			from
				new_index := 1
			until
				new_index = 0
			loop
				old_index := new_index
				new_index := name.index_of (Operating_environment.Directory_separator,
								old_index)
				if new_index /= 0 then
					new_index := new_index + 1
				else
					old_index := old_index - 1
				end
			end
			!! Result.make(0)
			if old_index > 1 then
				Result.append_string (name.substring (1, old_index))
			end
		end

	extract_filename (name: STRING): STRING is
		local
			i: INTEGER
		do
			from
				i := name.count
			until
				i > 0 and then name.item (i) = Operating_environment.Directory_separator or else i < 1
			loop
				i := i -1
			end
			!!Result.make (0)
			Result.append_string (name.substring (i + 1, name.count))
		end

	print_header is
			-- Prints the header of the table
		local
			i: INTEGER
		do
			from
				i:= 1
			until
				i > prof_options.output_names.count
			loop
				output_window.put_string (prof_options.output_names.item(i));
				output_window.put_string("%T");
				i := i + 1
			end;
			output_window.put_string("%N");
		end

	print_result is
			-- Computes the result of the query.
		local
			answer_set: PROFILE_SET
		do
			int_last_output := clone (profile_information);
			answer_set := first_filter.filter (profile_information.profile_data);
			int_last_output.set_profile_data (answer_set);
			from
				answer_set.start
			until
				answer_set.after
			loop
				print_columns (answer_set.item)
				answer_set.forth
			end
		end

	generate_filters is
			-- Generate the filters used by.
		local
			i: INTEGER
			boolean_filter: FILTER
			last_op: STRING
		do
			if prof_query.subquery_operators.count > 0 then
				if prof_query.operator_at (1).actual_operator.is_equal ("or") then
					!OR_FILTER! first_filter.make
					last_op := "or"
				else
					!AND_FILTER! first_filter.make
					last_op := "and"
				end
				boolean_filter := first_filter
				first_filter.extend (generate_filter (1))
				from
					i := 2
				until
					i > prof_query.subquery_operators.count
				loop
					if prof_query.operator_at (i).actual_operator.is_equal (last_op) then
						first_filter.extend (generate_filter (i));
					else
						if boolean_filter /= first_filter then
							first_filter.extend (generate_filter (i));
						else
							if prof_query.operator_at (i).actual_operator.is_equal ("or") then
								!OR_FILTER! boolean_filter.make
								last_op := "or"
							else
								!AND_FILTER! boolean_filter.make
								last_op := "and"
							end
							boolean_filter.extend (generate_filter (i));
						end
					end
					i := i + 1
				end
				boolean_filter.extend (generate_filter (i));
				if boolean_filter /= first_filter then
					first_filter.extend (boolean_filter)
				end
			else
				first_filter := generate_filter (1)
			end
			extend_with_languages
		end

	generate_filter (i: INTEGER): FILTER is
		local
			col_name: STRING
		do
			col_name := prof_query.subquery_at (i).column;
			if col_name.is_equal ("percentage") then
				!PERCENTAGE_FILTER! Result.make
				Result := set_filter_value (Result, false, i);
			elseif col_name.is_equal ("self") then
				!SELF_FILTER! Result.make
				Result := set_filter_value (Result, false, i);
			elseif col_name.is_equal ("descendents") then
				!DESCENDENTS_FILTER! Result.make
				Result := set_filter_value (Result, false, i);
			elseif col_name.is_equal ("total") then
				!TOTAL_FILTER! Result.make
				Result := set_filter_value (Result, false, i);
			elseif col_name.is_equal ("calls") then
				!CALLS_FILTER! Result.make
				Result := set_filter_value (Result, true, i);
			elseif col_name.is_equal ("featurename") then
				!NAME_FILTER! Result.make
				Result.set_value (prof_query.subquery_at (i).value)
			end
			Result.set_operator (prof_query.subquery_at (i).operator)
		end

	set_filter_value (filter: FILTER; calls: BOOLEAN; i: INTEGER): FILTER is
			-- Sets the value specified by the user in `filter'.
			-- `calls' distinguishes between the filter is a 
			-- CALLS_FILTER (true) or not (false).
			-- Index of value is `i'.
		local
			real_ref: REAL_REF
			int_ref: INTEGER_REF
                        lower, upper, origin: STRING
                        lower_ref_int, upper_ref_int: INTEGER_REF
                        lower_ref_real, upper_ref_real: REAL_REF
		do
			Result := filter;
			origin := prof_query.subquery_at (i).value;
			if calls then
				if origin.has ('-') then
					lower := origin.substring (1, origin.index_of ('-', 1) - 1);
					upper := origin.substring (origin.index_of ('-', 1) + 1, origin.count);
					lower_ref_int ?= single_value (lower, calls, i);
					upper_ref_int ?= single_value (upper, calls, i);
					Result.set_value_range (lower_ref_int, upper_ref_int);
				else
					int_ref ?= single_value (origin, calls, i);
					Result.set_value (int_ref);
				end;
			else
				if origin.has ('-') then
					lower := origin.substring (1, origin.index_of ('-', 1) - 1);
					upper := origin.substring (origin.index_of ('-', 1) + 1, origin.count);
					lower_ref_real ?= single_value (lower, calls, i);
					upper_ref_real ?= single_value (upper, calls, i);
					Result.set_value_range (lower_ref_real, upper_ref_real);
				else
					real_ref ?= single_value (origin, calls, i);
					Result.set_value (real_ref);
				end;
			end;
		end;

	single_value (val: STRING; calls: BOOLEAN; i: INTEGER): COMPARABLE is
			-- `calls' distinguishes between the filter is a 
			-- CALLS_FILTER (true) or not (false).
			-- `val' contains the value.
		local
			int_ref: INTEGER_REF
			real_ref: REAL_REF
		do
			if calls then
				!! int_ref;
				if val.is_equal ("min") then
					if prof_options.language_names.item (1).is_equal ("eiffel") then
						int_ref.set_item (profile_information.profile_data.calls_min_eiffel);
					elseif prof_options.language_names.item (1).is_equal ("c") then
						int_ref.set_item (profile_information.profile_data.calls_min_c);
					elseif prof_options.language_names.item (1).is_equal ("cycle") then
						int_ref.set_item (profile_information.profile_data.calls_min_cycle);
					end;
				elseif val.is_equal ("max") then
					if prof_options.language_names.item (1).is_equal ("eiffel") then
						int_ref.set_item (profile_information.profile_data.calls_max_eiffel);
					elseif prof_options.language_names.item (1).is_equal ("c") then
						int_ref.set_item (profile_information.profile_data.calls_max_c);
					elseif prof_options.language_names.item (1).is_equal ("cycle") then
						int_ref.set_item (profile_information.profile_data.calls_max_cycle);
					end;
				elseif val.is_equal ("avg") then
					if prof_options.language_names.item (1).is_equal ("eiffel") then
						int_ref.set_item (profile_information.profile_data.calls_avg_eiffel);
					elseif prof_options.language_names.item (1).is_equal ("c") then
						int_ref.set_item (profile_information.profile_data.calls_avg_c);
					elseif prof_options.language_names.item (1).is_equal ("cycle") then
						int_ref.set_item (profile_information.profile_data.calls_avg_cycle);
					end;
				else
					int_ref.set_item (val.to_integer)
				end;
				Result := int_ref;
			else
				!! real_ref;
				if prof_query.subquery_at (i).column.is_equal ("percentage") then
					if val.is_equal ("min") then
						if prof_options.language_names.item (1).is_equal ("eiffel") then
							real_ref.set_item (profile_information.profile_data.calls_min_eiffel);
						elseif prof_options.language_names.item (1).is_equal ("c") then
							real_ref.set_item (profile_information.profile_data.calls_min_c);
						elseif prof_options.language_names.item (1).is_equal ("cycle") then
							real_ref.set_item (profile_information.profile_data.calls_min_cycle);
						end;
					elseif val.is_equal ("max") then
						if prof_options.language_names.item (1).is_equal ("eiffel") then
							real_ref.set_item (profile_information.profile_data.calls_max_eiffel);
						elseif prof_options.language_names.item (1).is_equal ("c") then
							real_ref.set_item (profile_information.profile_data.calls_max_c);
						elseif prof_options.language_names.item (1).is_equal ("cycle") then
							real_ref.set_item (profile_information.profile_data.calls_max_cycle);
						end;
					elseif val.is_equal ("avg") then
						if prof_options.language_names.item (1).is_equal ("eiffel") then
							real_ref.set_item (profile_information.profile_data.calls_avg_eiffel);
						elseif prof_options.language_names.item (1).is_equal ("c") then
							real_ref.set_item (profile_information.profile_data.calls_avg_c);
						elseif prof_options.language_names.item (1).is_equal ("cycle") then
							real_ref.set_item (profile_information.profile_data.calls_avg_cycle);
						end;
					else
						real_ref.set_item (val.to_real)
					end;
				elseif prof_query.subquery_at (i).column.is_equal ("descendents") then
					if val.is_equal ("min") then
						if prof_options.language_names.item (1).is_equal ("eiffel") then
							real_ref.set_item (profile_information.profile_data.descendents_min_eiffel);
						elseif prof_options.language_names.item (1).is_equal ("c") then
							real_ref.set_item (profile_information.profile_data.descendents_min_c);
						elseif prof_options.language_names.item (1).is_equal ("cycle") then
							real_ref.set_item (profile_information.profile_data.descendents_min_cycle);
						end;
					elseif val.is_equal ("max") then
						if prof_options.language_names.item (1).is_equal ("eiffel") then
							real_ref.set_item (profile_information.profile_data.descendents_max_eiffel);
						elseif prof_options.language_names.item (1).is_equal ("c") then
							real_ref.set_item (profile_information.profile_data.descendents_max_c);
						elseif prof_options.language_names.item (1).is_equal ("cycle") then
							real_ref.set_item (profile_information.profile_data.descendents_max_cycle);
						end;
					elseif val.is_equal ("avg") then
						if prof_options.language_names.item (1).is_equal ("eiffel") then
							real_ref.set_item (profile_information.profile_data.descendents_avg_eiffel);
						elseif prof_options.language_names.item (1).is_equal ("c") then
							real_ref.set_item (profile_information.profile_data.descendents_avg_c);
						elseif prof_options.language_names.item (1).is_equal ("cycle") then
							real_ref.set_item (profile_information.profile_data.descendents_avg_cycle);
						end;
					else
						real_ref.set_item (val.to_real)
					end;
				elseif prof_query.subquery_at (i).column.is_equal ("self") then
					if val.is_equal ("min") then
						if prof_options.language_names.item (1).is_equal ("eiffel") then
							real_ref.set_item (profile_information.profile_data.self_min_eiffel);
						elseif prof_options.language_names.item (1).is_equal ("c") then
							real_ref.set_item (profile_information.profile_data.self_min_c);
						elseif prof_options.language_names.item (1).is_equal ("cycle") then
							real_ref.set_item (profile_information.profile_data.self_min_cycle);
						end;
					elseif val.is_equal ("max") then
						if prof_options.language_names.item (1).is_equal ("eiffel") then
							real_ref.set_item (profile_information.profile_data.self_max_eiffel);
						elseif prof_options.language_names.item (1).is_equal ("c") then
							real_ref.set_item (profile_information.profile_data.self_max_c);
						elseif prof_options.language_names.item (1).is_equal ("cycle") then
							real_ref.set_item (profile_information.profile_data.self_max_cycle);
						end;
					elseif val.is_equal ("avg") then
						if prof_options.language_names.item (1).is_equal ("eiffel") then
							real_ref.set_item (profile_information.profile_data.self_avg_eiffel);
						elseif prof_options.language_names.item (1).is_equal ("c") then
							real_ref.set_item (profile_information.profile_data.self_avg_c);
						elseif prof_options.language_names.item (1).is_equal ("cycle") then
							real_ref.set_item (profile_information.profile_data.self_avg_cycle);
						end;
					else
						real_ref.set_item (val.to_real)
					end;
				elseif prof_query.subquery_at (i).column.is_equal ("total") then
					if val.is_equal ("min") then
						if prof_options.language_names.item (1).is_equal ("eiffel") then
							real_ref.set_item (profile_information.profile_data.total_min_eiffel);
						elseif prof_options.language_names.item (1).is_equal ("c") then
							real_ref.set_item (profile_information.profile_data.total_min_c);
						elseif prof_options.language_names.item (1).is_equal ("cycle") then
							real_ref.set_item (profile_information.profile_data.total_min_cycle);
						end;
					elseif val.is_equal ("max") then
						if prof_options.language_names.item (1).is_equal ("eiffel") then
							real_ref.set_item (profile_information.profile_data.total_max_eiffel);
						elseif prof_options.language_names.item (1).is_equal ("c") then
							real_ref.set_item (profile_information.profile_data.total_max_c);
						elseif prof_options.language_names.item (1).is_equal ("cycle") then
							real_ref.set_item (profile_information.profile_data.total_max_cycle);
						end;
					elseif val.is_equal ("avg") then
						if prof_options.language_names.item (1).is_equal ("eiffel") then
							real_ref.set_item (profile_information.profile_data.total_avg_eiffel);
						elseif prof_options.language_names.item (1).is_equal ("c") then
							real_ref.set_item (profile_information.profile_data.total_avg_c);
						elseif prof_options.language_names.item (1).is_equal ("cycle") then
							real_ref.set_item (profile_information.profile_data.total_avg_cycle);
						end;
					else
						real_ref.set_item (val.to_real)
					end;
				end;
				Result := real_ref;
			end;
		end;

	extend_with_languages is
			-- Creates extra language filters
		local
			lang_filt: FILTER
			new_ff: FILTER
			i: INTEGER
		do
			if prof_options.language_names.count > 1 then
				from
					!OR_FILTER! lang_filt.make
					i := 1
				until
					i > prof_options.language_names.count
				loop
					lang_filt.extend (generate_language_filter (i))
					i := i + 1
				end
				!AND_FILTER! new_ff.make
				new_ff.extend (lang_filt)
				new_ff.extend (first_filter)
				first_filter := new_ff
			elseif prof_options.language_names.count = 1 then
				!AND_FILTER! new_ff.make;
				new_ff.extend (generate_language_filter (1));
				new_ff.extend (first_filter);
				first_filter := new_ff;
			end;
		end;

	generate_language_filter (i: INTEGER): FILTER is
			-- Generates a filter for a specified
			-- language
		local
			lang_name: STRING
		do
			lang_name := prof_options.language_names.item (i)
			lang_name.to_lower;
			if lang_name.is_equal ("eiffel") then
				!EIFFEL_FILTER! Result.make
			elseif lang_name.is_equal ("c") then
				!C_FILTER! Result.make
			elseif lang_name.is_equal ("cycle") then
				!CYCLE_FILTER! Result.make
			end
		end

	print_columns (item: PROFILE_DATA) is
			-- Prints the values from the columns the user wanted
			-- to see.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > prof_options.output_names.count
			loop
				if prof_options.output_names.item (i).is_equal ("featurename") then
					output_window.put_string (item.function.out)
					output_window.put_string ("%T")
				elseif prof_options.output_names.item (i).is_equal ("calls") then
					output_window.put_string (item.number_of_calls.out)
				elseif prof_options.output_names.item (i).is_equal ("self") then
					output_window.put_string (item.self_sec.out)
				elseif prof_options.output_names.item (i).is_equal ("descendents") then
					output_window.put_string (item.descendents_sec.out)
					output_window.put_string ("%T")
				elseif prof_options.output_names.item (i).is_equal ("total") then
					output_window.put_string (item.total_sec.out)
				elseif prof_options.output_names.item (i).is_equal ("percentage") then
					output_window.put_string (item.percentage.out)
					output_window.put_string ("%T")
				end
				output_window.put_string("%T")
				i := i + 1
			end
			output_window.put_string("%N")
		end

feature {NONE} -- Attributes

	expanded_filenames: LINKED_LIST [STRING]
		-- unwildcarded filenames

	profile_information: PROFILE_INFORMATION
		-- Retrieved from disk- where it is stored by prof_converter.

	first_filter: FILTER
		-- Filter of which the `filter'-feature is to be called.

	int_last_output: PROFILE_INFORMATION
		-- Output as result of the last queried query.

	prof_query: PROFILER_QUERY
		-- All the active queries.

	prof_options: PROFILER_OPTIONS
		-- The options specified by the user.

end -- class E_SHOW_PROFILE_QUERY
