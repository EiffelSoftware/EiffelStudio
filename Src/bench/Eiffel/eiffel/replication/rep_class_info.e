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
		end

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

creation
	make

feature 

	make (a_class_id: INTEGER) is
		require
			valid_arg1: a_class_id /= 0
		do
			ll_make;
			class_id := a_class_id;
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
