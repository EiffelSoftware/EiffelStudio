-- This class is virtually the same as REP_NAME_LIST except
-- that the parent_clause attribute is the class_id of the
-- parent. (I did not want to store all the information
-- relating to PARENT_C).

class S_REP_NAME_LIST

inherit

	LINKED_LIST [S_REP_NAME]
		rename
			make as old_make
		end;
	SHARED_WORKBENCH

creation

	make

feature

	parent_clause: INTEGER;
			-- Parent clause where replication came from 

	replicated_features: LINKED_LIST [S_REP_NAME];
			-- List of features to be code replicated 
			-- These features were written_in the same
			-- class 

	make (p: INTEGER) is
			-- Make current with parent `p'.
		do
			parent_clause := p;
			!!replicated_features.make;
		end;

	add_replicated_feature (r: S_REP_NAME) is
		do
			replicated_features.add_front (r);
		end;

	parent: CLASS_C is
		do
			Result := System.class_of_id (parent_clause);
		end;

	update (list: REP_NAME_LIST) is
		local
			cur: CURSOR;
			s_rep_name: S_REP_NAME;
			rep_name: REP_NAME;
		do
			cur := list.cursor;
			from
				list.start
			until
				list.after
			loop
				rep_name := list.item;
				if rep_name.old_feature /= Void then
					!!s_rep_name;
					s_rep_name.set_old_feature (rep_name.old_feature);
					s_rep_name.set_new_feature (rep_name.new_feature);
					add_front (s_rep_name);
				end;
				list.forth
			end;
			list.go_to (cur);
		end;

	trace is
		do
			io.putstring ("S_REP_NAME_LIST%N");
			from
				start
			until
				after
			loop
				io.putstring ("old feature name: ");
				io.putstring (item.old_feature.feature_name);
				io.new_line;
				io.putstring ("new feature name: ");
				io.putstring (item.new_feature.feature_name);
				io.new_line;
				forth
			end
		end;

end

