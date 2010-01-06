
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Place class TEST in cluster root_cluster and class TEST47 in
	--	cluster root_cluster2 (both in file `test.e').
	-- Compile classes as is.
	-- Change class in cluster root_cluster2, file `test.e' so that
	--	its name inside the file is TEST.
	-- Recompile.  Compiler does not detect VD29 violation.

class $CLASS_NAME
creation
	make
feature
	make is
		do
			io.putstring ("$CLASS_NAME in $CLUSTER_NAME%N");
		end;

	a: TEST;
end

