-- Record suppliers for EiffelCase
class CASE_RECORD_CHART_INFO

inherit
	
	CASE_CLASS_COMMAND;
	SHARED_SERVER;

creation

	make

feature 

	com_list: ARRAYED_LIST [S_TEXT_DATA];
	query_list: ARRAYED_LIST [S_TEXT_DATA];
	const_list: ARRAYED_LIST [S_TEXT_DATA];

	execute is
			-- Record parents and suppliers for class `classc' into
			-- `s_class_data'.
		local
			assert_list: FIXED_LIST [S_TAG_DATA];
			features: ARRAYED_LIST [S_FEATURE_DATA]
		do
			!! com_list.make (0);
			!! query_list.make (0);
			!! const_list.make (0);
			features := s_class_data.public_features;
			if features /= Void then
				record_chart_information (features);
			end;
			assert_list := s_class_data.invariants;
			if assert_list /= Void then
				add_constraints (assert_list)
			end;
			if not com_list.empty then
				s_class_data.chart.set_commands (com_list)
			end;
			if not query_list.empty then
				s_class_data.chart.set_queries (query_list)
			end;
			if not const_list.empty then
				s_class_data.chart.set_constraints (const_list)
			end;
			com_list := Void;
			const_list := Void;
			query_list := Void;
		end;

feature {NONE} -- Recording information for eiffelcase

	record_chart_information (features: ARRAYED_LIST [S_FEATURE_DATA]) is
			-- Record chart information by analyzing the
			-- class specification for public routines.
		require
			valid_features: features /= Void
		local
            text_data: S_TEXT_DATA;
            tag_data: S_TAG_DATA;
			s_feature_data: S_FEATURE_DATA;
			assert_list: FIXED_LIST [S_TAG_DATA]
		do
			from
				features.start
			until
				features.after
			loop
				s_feature_data := features.item;
				!! text_data.make (string_processed (s_feature_data.name));
				if s_feature_data.result_type = Void then
					-- It is a command
					com_list.extend (text_data)
				else -- It is a query
					query_list.extend (text_data)
				end;
				assert_list := s_feature_data.preconditions;
				if assert_list /= Void then
					add_constraints (assert_list)
				end;
				assert_list := s_feature_data.postconditions;
				if assert_list /= Void then
					add_constraints (assert_list)
				end;
				features.forth
			end
		end;

	add_constraints (assert_list: FIXED_LIST [S_TAG_DATA]) is
		require
			valid_assert_list: assert_list /= Void
		local
            text_data: S_TEXT_DATA;
            tag_data: S_TAG_DATA;
            text: STRING;
		do
			from
				assert_list.start
			until
				assert_list.after
			loop
				tag_data := assert_list.item;
				if tag_data.tag = Void then
					text := tag_data.text
				else
					text := tag_data.tag
				end;
				!! text_data.make (string_processed (text));
				const_list.extend (text_data);
				assert_list.forth
			end
		end;

	string_processed (str: STRING): STRING is
			-- String processed of `str' which
			-- replaces "_" with " " and the first
			-- character is in upper case.
		require
			valid_str: str /= Void and then not str.empty
		do
			Result := clone (str);
			Result.replace_substring_all ("_", " ");
			Result.put (Result.item (1).upper, 1);
		end;


end
