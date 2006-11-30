
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
creation
	make
feature
	make is
		local
			p: POINTER_REF;
			a: STRING;
			b: POINTER;
			c: INTEGER;
			d: DOUBLE;
			e: REAL;
			f: BOOLEAN;
			g: CHARACTER;
			h: INTEGER_REF;
		do
			a ?= $p;
			a ?= $a;
			a ?= $b;
			a ?= $c;
			a ?= $d;
			a ?= $e;
			a ?= $f;
			a ?= $g;
			a ?= $h;
		end;

end
