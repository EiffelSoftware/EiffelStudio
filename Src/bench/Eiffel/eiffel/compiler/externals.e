-- Externals names used by the system. Useful for controling
-- introduction of a new external in the system which trigger a freeze
-- operation.

class EXTERNALS 

inherit

	EXTEND_TABLE [EXTERNAL_INFO, STRING]
		rename
			make as extend_table_make
		end

creation

	make

feature

	duplication: like Current;
			-- Duplication of current array

	
	make is
		do
			extend_table_make (Chunk);
			make_duplication;
		end;

	
	Chunk: INTEGER is 50;
			-- Array chunk

	make_duplication is
			-- Make duplication of Current object
		do
			duplication := twin;
		end;

	equiv: BOOLEAN is
			-- Check if the current object is equivalent to the
			-- duplication
		require
			duplication_exists: duplication /= Void
		do
			from
				Result := True;
				start;
			until
				after or else not Result
			loop
				Result := duplication.has (key_for_iteration) or else
						-- If the name has been added and removed, no
						-- refreezing is needed.
					item_for_iteration.occurence = 0;
				forth;
			end;
		end;
		
	add_occurence (external_name: STRING) is
			-- Add one occurence of `external_name'.
		require
			good_argument: external_name /= Void
		local
			info: EXTERNAL_INFO;
			val: INTEGER;
		do
			info := item (external_name);
			if info = Void then
				!!info;
				put (info, external_name);
			end;
			info.add_occurence;
		end;

	remove_occurence (external_name: STRING) is
			--Remove one occurence of `external_name'.
		require
			good_argument: 	external_name /= Void;
			has_occurence:	has (external_name);
			good_occurence: item (external_name).occurence > 0;
		local
			info: EXTERNAL_INFO;
		do
			info := item (external_name);
			info.remove_occurence;
		end;

	freeze is
			-- Freeze the external table
		local
			available_keys: ARRAY [STRING];
			i, nb: INTEGER;
			external_name: STRING;
			info: EXTERNAL_INFO;
		do
			from
				available_keys := current_keys;
				i := 1;
				nb := available_keys.count;
			until
				i > nb
			loop
				external_name := available_keys.item (i);
				info := item (external_name);
				if info.occurence <= 0 then
					remove (external_name);
				else
					info.reset_real_body_id;
				end;
				i := i + 1;
			end;
				-- Make a duplication
			make_duplication;
		end;

end
