-- Hash table for cecil

class CECIL_TABLE [T] 

inherit

	ARRAY [STRING]
		rename
			item as array_item,
			put as array_put,
			wipe_out as array_wipe_out
		end;
	SHARED_CODE_FILES
		undefine
			copy, setup, consistent, is_equal
		end;
	SHARED_WORKBENCH
		undefine
			copy, setup, consistent, is_equal
		end;
	COMPILER_EXPORTER
        undefine
            copy, setup, consistent, is_equal
        end;

creation
	init
	
feature

	values: ARRAY [T];
			-- Values of the hash table

	init (hash_size: INTEGER) is
			-- Table creation
		require
			primes.is_prime (hash_size);
		local
			i: INTEGER;
		do
			i := hash_size - 1;
			make (0, i);
			!! values.make (0, i);
		end;

	primes: PRIMES is
			-- Prime number testor
		once
			!!Result;
		end; -- primes

	wipe_out is
			-- Empty the table
		do
			lower := 0
			upper := -1
			make_area (0)
			values := Void;
		end;

	put (f: T; s: STRING) is
			-- Insert `f' in the hash table
		require
			good_argument1: f /= Void;
			good_argument2: s /= Void;
			table_exists: values /= Void;
		local
			increment, key, position, try, hash_size: INTEGER;
			stop: BOOLEAN;
			local_copy: like Current
			local_values: like values
		do
			from
				local_copy := Current
				local_values := values
				hash_size := count;
				key := s.hash_code;
				position := key \\ hash_size;
				increment := 1 + (key \\ (hash_size - 1));
			until
				try >= hash_size or else stop
			loop
				if local_copy.array_item (position) = Void then
						-- Found a free location
					local_copy.array_put (s, position);
					local_values.put (f, position);
					stop := True;
				end;
				position := (position + increment) \\ hash_size;
				try := try + 1;
			end;
		end;

	cecil_file: INDENT_FILE is
		do
			Result := System.cecil_file;
		end;

end
