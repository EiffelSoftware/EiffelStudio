-- Table of patterns

class PATTERN_TABLE 

inherit

	SEARCH_TABLE [PATTERN_INFO]
		rename
			make as search_table_make
		end;
	SHARED_CODE_FILES
		undefine
			twin
		end


creation

	make

feature
	
	patterns: SEARCH_TABLE [PATTERN];
			-- Shared references on patterns

	info_array: ARRAY [PATTERN_INFO];
			-- Array of pattern information in order to reference them
			-- through an index.

	last_pattern_id: INTEGER;
			-- Pattern id processed after last insertion

	
	c_patterns: SEARCH_TABLE [C_PATTERN_INFO];
			-- Non formal patterns present already in the system

	c_pattern_id_counter: COUNTER;
			-- Counter of C patterns

	make is
			-- Table creation
		do
			search_table_make (Chunk);
			!!patterns.make (Chunk);
			!!info_array.make (1, Chunk);
			!!c_pattern_id_counter;
			!!c_patterns.make (Chunk);
		end;

	Chunk: INTEGER is 100;
			-- Table chunk

	process is
			-- Process the table of C patterns
		local
			i: INTEGER;
			c_pattern: C_PATTERN;
			types: LINKED_LIST [CLASS_TYPE];
			info: PATTERN_INFO;
			c_pattern_info: C_PATTERN_INFO;
			assoc_class: CLASS_C;
		do
			from
				i := 1;
			until
				i > count
			loop
				info := info_array.item (i);	
				assoc_class := info.associated_class;
				if assoc_class /= Void then
						-- Classes could be removed
					from
						types := info.associated_class.types;
						types.start
					until
						types.after
					loop
						c_pattern := 
							info.instantiation_in (types.item.type).c_pattern;
						!!c_pattern_info;
						c_pattern_info.set_pattern (c_pattern);
						if not c_patterns.has (c_pattern_info) then
							c_pattern_info.set_c_pattern_id
												(c_pattern_id_counter.next);
							c_patterns.put (c_pattern_info);
						end;
						types.forth;
					end;
				end;
				i := i + 1;
			end;
		end;
				
	insert (written_in: INTEGER; pattern: PATTERN) is
		require
			good_argument: pattern /= Void
		local
			other_pattern: PATTERN;
			info, other_info: PATTERN_INFO;
		do
			!!info.make (written_in, pattern);
			other_info := item (info);
			if other_info = Void then
				other_pattern := patterns.item (pattern);
				if other_pattern = Void then
					patterns.put (pattern);
				else
					info.set_pattern (other_pattern);
				end;
				put (info);

				info.set_pattern_id (count);
				last_pattern_id := count;
				if count > info_array.count then
					info_array.resize (1, count + Chunk);
				end;
				info_array.put (info, count);
			else
				last_pattern_id := other_info.pattern_id;
			end;
		end;

	pattern_of_id (i: INTEGER; type: CL_TYPE_I): PATTERN is
			-- Pattern information of id `i'.
		require
			index_small_enough: i <= info_array.count;
			index_large_enough: i > 0;
		do
			Result := info_array.item (i).instantiation_in (type);
		end;

	c_pattern_id (pattern_id: INTEGER; cl_type: CL_TYPE_I): INTEGER is
			-- Pattern id of C pattern `p'
		require
			good_type: cl_type /= Void;
		local
			info: C_PATTERN_INFO;
		do
			Marker.set_pattern
				(pattern_of_id (pattern_id, cl_type).c_pattern);
			info := c_patterns.item (Marker);
			if info /= Void then
				Result := info.c_pattern_id;
			end;
		end;

	Marker: C_PATTERN_INFO is
			-- Marker for search in `c_patterns'
		once
			!!Result;
		end;

	generate is
			-- Generate patterns
		local
			id, i, nb: INTEGER;
		do
			Pattern_file.open_write;

			Pattern_file.putstring ("%
				%#include %"macros.h%"%N%
				%#include %"struct.h%"%N%
				%#include %"interp.h%"%N%N");

			generate_pattern;

				-- Generate pattern table
			Pattern_file.putstring ("struct interface pattern[] = {%N");
			from
				i := 1;
				nb := c_pattern_id_counter.value;
			until
				i > nb
			loop
				Pattern_file.putstring ("{toc");
				Pattern_file.putint (i);
				Pattern_file.putstring (", (fnptr) toi");
				Pattern_file.putint (i);
				Pattern_file.putstring ("},%N");
				i := i + 1;
			end;
			Pattern_file.putstring ("};%N%N");

			Pattern_file.close;
		end;

	generate_pattern is
			-- Generate pattern for interfacing C generated code and
			-- the interpreter
		do
			from
				c_patterns.start
			until
				c_patterns.after
			loop
				c_patterns.item_for_iteration.generate_pattern;
				c_patterns.forth;
			end;
		end;

invariant

	patterns_exists: patterns /= Void;
	info_array_exists: info_array /= Void;

end
