
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is
		do
			try (True xor Void /= Void);
			try (True xor Current /= Void);
			try (False xor Void /= Void);
			try (False xor Current /= Void);
			
			try (True xor (Void /= Void));
			try (True xor (Current /= Void));
			try (False xor (Void /= Void));
			try (False xor (Current /= Void));
		end

	try (b: BOOLEAN) is
		do
			io.putbool (b); io.new_line;
		end
end
