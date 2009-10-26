
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS
		export
			{NONE} all
		end

	ANY

creation
	make
feature
	
	make (args: ARRAY [STRING]) is
		local
			k: INTEGER
		do
			try (2);
			try (1);
			try (0);
			from
				k := 1;
			until
				k > args.item (1).to_integer
			loop
				try (-1);
				try (-2);
				try (5);
				try (-3);
				k := k + 1;
			end
		end
	
	try (val: INTEGER) is
		local
			tried: BOOLEAN;
		do
			if f = Void then
				!!f.make (1);
			end
			if not tried then
				f.set_value (val);
			else
				f.set_value (2);
			end
		rescue
			tried := True;
			retry;
		end
	
	f: TEST1;
	
end
