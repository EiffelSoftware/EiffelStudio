indexing

	description: "List of feature data.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_LIST 

inherit

	LINKED_LIST [FEATURE_DATA]

creation

	make, make_from_storer

feature -- Initialization

	make_from_storer (storer: ARRAYED_LIST [S_FEATURE_DATA]; 
			c_data: CLASS_DATA) is
			-- Storage info for Current
		require
			valid_storer: storer /= Void
		local
			feature_data: FEATURE_DATA
		do
			make;
			from
				storer.start;
			until
				storer.after
			loop
				!! feature_data.make_from_storer (storer.item);
				feature_data.set_class_container (c_data);
				put_right (feature_data);
				storer.forth;
				forth
			end;
		end;	

feature -- Access

	features_with_prefix (str: STRING): SORTED_TWO_WAY_LIST [FEATURE_DATA] is
			-- Features with prefix `str' in Current class
		local
			search_string, n, tmp: STRING;
			ct: INTEGER;
			feature_data: FEATURE_DATA
		do
			search_string := clone (str);
			search_string.to_lower;
			!! Result.make;
			if search_string.count > 0 then
				if str.item (str.count) = '*' then
					if search_string.count = 1 then
						search_string := ""
					else
						search_string := search_string.substring 
											(1, search_string.count - 1);
					end;
					if search_string.empty then
						Result.merge (Current)
					else
						from
							start
						until
							after
						loop
							ct := search_string.count;
							n := item.name;
							if n.count >= ct then
								tmp := n.substring (1, ct);
								tmp.to_lower;
								if tmp.is_equal (search_string) then
									Result.put_front (item)
								end
							end;
							forth
						end;
						Result.sort;
					end
				else
					feature_data := feature_with_name (search_string);
					if feature_data /= Void then
						Result.put_front (feature_data);
					end		
				end
			end
		end;

	has_feature (feature_name: STRING): BOOLEAN is
			-- Does Current class data have feature with
			-- name `feature_name'?
		require
			valid_feature_name: feature_name /= Void and then
									not feature_name.empty
		local
			search_string: STRING;
			n: STRING
		do
			search_string := clone (feature_name);
			search_string.to_lower;
			from
				start
			until
				Result or else after
			loop
				n := clone (item.name);
				n.to_lower;
				Result := (n.is_equal (search_string));
				forth
			end
		end;

	feature_with_name (feature_name: STRING): FEATURE_DATA is
			-- Feature with name `feature_name'?
		require
			valid_feature_name: feature_name /= Void and then
									not feature_name.empty
		local
			n: STRING
		do
			from
				start
			until
				Result /= Void or else after
			loop
				if feature_name.is_equal (item.name) then
					Result := item;
				else
					forth
				end;
			end
		end;

feature -- Output

	generate (text_area: TEXT_AREA; is_spec: BOOLEAN ) is
		require
			not_empty: not empty
		do
			text_area.indent;
			from
				start
			until
				after
			loop
				item.generate	( text_area	, is_spec );
				text_area.new_line;
				forth;
			end;
			text_area.exdent;
		end;

    generate_c (text_area: TEXT_AREA; is_spec: BOOLEAN) is
        require
            not_empty: not empty
        do
            text_area.indent;
            from
                start
            until
                after
            loop
                item.generate_c (text_area, is_spec);
                text_area.new_line;
                forth;
            end;
            text_area.exdent;
        end;

	generate_chart (text_area: TEXT_AREA) is
		require
			not_empty: not empty
		local
			header_generated: BOOLEAN;
		do
			from
				start
			until
				after
			loop
				if item.has_result and then item.has_comments then
					if not header_generated then
						text_area.append_keyword ("queries");
						text_area.indent;
						text_area.new_line;
						header_generated := true;
					else
						text_area.new_line;
					end;
					item.comments.generate_chart (text_area, item);
				end;
				forth;
			end;
			if header_generated then
				text_area.exdent;
				header_generated := false;
			end;
			from
				start
			until
				after
			loop
				if not item.has_result and then item.has_comments then
					if not header_generated then
						text_area.append_keyword ("commands");
						text_area.indent;
						text_area.new_line;
						header_generated := true;
					else
						text_area.new_line;
					end;
					item.comments.generate_chart (text_area, item);
				end;
				forth;
			end;
			if header_generated then
				text_area.exdent;
				header_generated := false;
			end;
		end;

feature -- Removal

	clear_editors is
			-- Clear the class window editor and all feature window
			-- for Current
		do
			from
				start
			until
				after
			loop
				item.clear_editor;
				forth
			end
		end;

feature -- Storage

	storage_info: ARRAYED_LIST [S_FEATURE_DATA] is
			-- Storage info for Current
		do
			!! Result.make (count);
			from
				start
			until
				after
			loop
				Result.put_right (item.storage_info);
				Result.forth;
				forth
			end;
		end;	

end -- class FEATURE_LIST
