indexing

	description: "Data for BON chart representation.";
	date: "$Date$";
	revision: "$Revision $"

class CHART

creation

	do_nothing, make_from_storer

feature -- Initialization

	make_from_storer (c_storer: S_CHART) is
			-- Retrieve chart information in `c_store'.
		require
			valid_storer: c_storer /= Void
		local
			l: FIXED_LIST [S_TAG_DATA];
			index: INDEX_DATA
		do
			l := c_storer.indexes;
			if l /= Void  then
				!! indexes.make;
				from
					l.start;
				until
					l.after
				loop
					!! index.make_from_storer (l.item);
					indexes.put_right (index);
					l.forth;
					indexes.forth
				end;
			end
		end

feature -- Properties

	indexes: ELEMENT_LIST [INDEX_DATA];
		-- Data on Current synonymn,
		-- application domain, authors,
		-- date of creation, revision level
		-- and keywords.

	description_data: DESCRIPTION_DATA is
			-- Find description index clause
		local
			i: INDEX_DATA;
			tag: STRING
		do
			if indexes /= Void then
				from
					indexes.start
				until
					indexes.after or else
					Result /= Void
				loop
					i := indexes.item;
					tag := clone (i.tag);
					if tag /= Void then
						tag.to_upper;
						if tag.is_equal ("DESCRIPTION") then
							!! Result.make;
							Result.format (i.text)
							indexes.remove
						else
							indexes.forth
						end
					else
						indexes.forth
					end;
				end
			end
		end;

feature -- Element change 

	add_index (new_index: INDEX_DATA) is
			-- Add `new_index' to index.
		do
			if indexes = Void then
				!! indexes.make;
			end;
			indexes.extend (new_index);
		ensure
			indexes.has (new_index)
		end;

feature -- Removal

	remove_index (removed_index: INDEX_DATA) is
			-- Remove `new_index' from index. 
		require
			valid_index: removed_index /= Void;
			has_removed_index: indexes.has (removed_index)
		do
			indexes.start;
			indexes.prune (removed_index);
		end; 

feature -- Output

	generate (text_area: TEXT_AREA; linkable: LINKABLE_DATA; is_bon: BOOLEAN) is
			-- Generate index into `text_area'.
		require
			valid_linkable	: linkable	/= void		
			valid_text_area	: text_area	/= void
		local
		--	desc: DESCRIPTION_DATA;
			gen_desc: BOOLEAN
		do
		--	desc := linkable.description;
		--	gen_desc := not is_bon and then (not text_area.output_to_disk
				--			or else not desc.is_default);
		--	if gen_desc or else
		--		(indexes /= Void and then not indexes.empty)
		--	then
		--		text_area.append_keyword ("indexing")
		--		text_area.new_line;
		--		text_area.indent;
		--		if gen_desc then
		--			text_area.start_comment;
		--			text_area.append_string ("description: ");
		--			desc.generate_with_percent (text_area, linkable)
		--			text_area.end_comment (desc.stone (linkable));
		--		end;
		--		if indexes /= Void and then not indexes.empty then
		--			indexes.generate (text_area, linkable )
		--		end;
		--		text_area.new_line;
		--		text_area.exdent;
		--	end;
		end;

	generate_string (text_area: TEXT_AREA; linkable: LINKABLE_DATA; is_bon: BOOLEAN) is
			-- Generate index into `text_area'.
		require
			valid_linkable	: linkable	/= void		
			valid_text_area	: text_area	/= void
		local
		--	desc: DESCRIPTION_DATA;
			gen_desc: BOOLEAN
		do
		--	desc := linkable.description;
		--	gen_desc := not is_bon and then (not text_area.output_to_disk
			--				or else not desc.is_default);
		--	if gen_desc or else
		--		(indexes /= Void and then not indexes.empty)
		--	then
		--		text_area.append_keyword ("indexing")
		--		text_area.new_line;
		--		text_area.indent;
		--		if gen_desc then
		--			--text_area.start_comment;
		--			text_area.append_string ("description: ");
		--			desc.generate_with_percent (text_area, linkable)
		--			--text_area.end_comment (desc.stone (linkable));
		--		end;
		--		if indexes /= Void and then not indexes.empty then
		--			indexes.generate_string (text_area, linkable)
		--		end;
		--		text_area.new_line;
		--		text_area.exdent;
		--	end;
		end;

feature -- Storage 

	storage_info: S_CHART is
		do
			!! Result;
			store_information (Result)
		end

	store_information (c_storer: S_CHART) is
			-- Store chart information in `c_store'.
		require
			valid_storer: c_storer /= Void
		local
			l: FIXED_LIST [S_TAG_DATA]
		do
			if indexes /= Void and then not indexes.empty then
				!! l.make_filled (indexes.count);
				from
					indexes.start;
					l.start;
				until
					indexes.after
				loop
					l.replace (indexes.item.storage_info);
					l.forth;
					indexes.forth
				end;
				c_storer.set_indexes (l);
			end
		end;

end -- class CHART
