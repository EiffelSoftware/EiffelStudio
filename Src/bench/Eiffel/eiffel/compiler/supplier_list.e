-- Descritpion of the suppliers of a class

class SUPPLIER_LIST 

inherit

	LINKED_LIST [SUPPLIER_INFO];
	SHARED_EIFFEL_PROJECT

creation

	make

feature 

	remove_occurence (l: TWO_WAY_SORTED_SET [DEPEND_UNIT]) is
			-- Remove one occurence for each supplier of id
			-- included in `l'.
		require
			good_argument: l /= Void;
			consistency: is_ok (l);
		local
			suppl_info: SUPPLIER_INFO;
			id: INTEGER;
			s: TWO_WAY_SORTED_SET [INTEGER]
		do
			s := suppliers (l);
			from
				s.start
			until
				s.after
			loop
				id := s.item;
				goto (id);
					-- Defensive programming: according to the
					-- precondition, after should always be false
				if not after then
					suppl_info := item;
					suppl_info.remove_occurence;
					if suppl_info.occurence <= 0 then
						remove;
					end;
				end;
				s.forth
			end;
		end;

	add_occurence (l: TWO_WAY_SORTED_SET [DEPEND_UNIT]) is
			-- Add one occurence for each supplier of id
			-- included in `l'.
		require
			good_argument: l /= Void
		local
			suppl_info: SUPPLIER_INFO;
			id: INTEGER;
			s: TWO_WAY_SORTED_SET [INTEGER]
		do
			s := suppliers (l);
			from
				s.start
			until
				s.after
			loop
				id := s.item;
debug ("ACTIVITY");
	io.error.putstring ("SUPPLIER_LIST add_occurence: ");
	io.error.putstring (Eiffel_system.class_of_id (id).name);
	io.error.new_line;
end;
				suppl_info := info (id);
				if suppl_info = Void then
					!! suppl_info.make (Eiffel_system.class_of_id (id));
					put_front (suppl_info);
				else
					suppl_info.add_occurence;
				end;
	
				s.forth;
			end;
		ensure
			consistency: is_ok (l)
		end;

	same_suppliers: SUPPLIER_LIST is
			-- Duplicated list
		do
			!!Result.make;
			from
				start
			until
				after
			loop
				Result.put_right (clone (item));
				Result.forth;
				forth
			end
		end;

feature {NONE}

	suppliers (l: TWO_WAY_SORTED_SET [DEPEND_UNIT]): TWO_WAY_SORTED_SET [INTEGER] is
		local
			id: INTEGER
		do
debug ("ACTIVITY")
	io.error.putstring ("SUPPLIER_lIST.suppliers%N");
end;
			!!Result.make;
			from
				l.start
			until
				l.after
			loop
				id := l.item.id;
				if not Result.has (id) then
		-- **** FIXME **** 
		-- doesn't extend check to if id already exists since
		-- result is set !!!???!! dinov
debug ("ACTIVITY")
	io.error.putint (id);
	io.error.new_line;
end;
					Result.extend (id);
				end;
				l.forth
			end;
		end;

	goto (id: INTEGER) is
			-- Move cursor to supplier info of id `id'.
		require
			consistency: info (id) /= Void
		do
			from
				start
			until	
					-- The test for `after' is a defensive programming
					-- test!!!
				after or else item.supplier.id = id
			loop
				forth;
			end;
		end;
		
	info (id: INTEGER): SUPPLIER_INFO is
			-- Supplier information associated to supplier of id `id'.
		require
			positive_argument: id > 0;
		local
			cur: CURSOR;
		do
			cur := cursor;
			from
				start
			until
				after or else Result /= Void
			loop
				if item.supplier.id = id then
					Result := item;
				end;
				forth;
			end;
			go_to (cur);
		end;

feature

	is_ok (l: TWO_WAY_SORTED_SET [DEPEND_UNIT]): BOOLEAN is
			-- Is the supplier list consistant regarding to `l'.
		require
			good_argument: l /= Void
		local
			suppl_info: SUPPLIER_INFO;
			id: INTEGER;
			s: TWO_WAY_SORTED_SET [INTEGER];
		do
debug ("ACTIVITY")
	trace;
end;
			s := suppliers (l);
			from	
				Result := True;
				s.start;
			until
				s.after or else not Result
			loop
				id := s.item;
				suppl_info := info (id);
				Result := 	suppl_info /= Void
							and then
							suppl_info.occurence >= 1;
				s.forth;
			end;
		end;

feature 

	trace is
			-- Debug purpose
		do
			io.error.putstring ("SUPPLIER_LIST.trace%N");
			from
				start
			until
				after
			loop
				io.error.putstring (item.supplier.name);
				io.error.putstring (" [");
				io.error.putint (item.occurence);
				io.error.putstring ("]  ");
				forth;
			end;
		end;
				
end
