-- List of s_rep_name_list. REP_CLASS_INFO is formulated for
-- each class during Degree 3. At the end of the whole 
-- Degree 3 pass, this object is retrieved and then the
-- S_REP_NAME_LIST is processed for replication. The reason
-- that this done at the end of Degree 3 and not during 
-- so that the feature table for all classes are available
-- for code replication. 

class REP_CLASS_INFO 

inherit

	LINKED_LIST [S_REP_NAME_LIST]
		rename
			make as ll_make
		end;
	COMPILER_IDABLE

creation

	make

feature 

	id: CLASS_ID;

	set_id (i: CLASS_ID) is
		do
			id := i
		end;

	make (class_id: CLASS_ID) is
		require
			valid_arg1: class_id /= Void
		do
			ll_make;
			id := class_id;
		end;

	has_list (other: S_REP_NAME_LIST): BOOLEAN is
			-- Does Current have `other' (reference equality) ?
		do
			from
				start
			until
				after or else Result
			loop
				Result := other = item;
				forth
			end
		end;

	trace is
		do
			io.error.putstring ("REP CLASS INFO%N");
			from
				start
			until
				after
			loop
				item.trace;
				forth
			end
		end;

end
