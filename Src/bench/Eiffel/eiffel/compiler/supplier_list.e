-- Descritpion of the suppliers of a class

class SUPPLIER_LIST 

inherit

	LINKED_LIST [SUPPLIER_INFO];
	SHARED_WORKBENCH

creation

	make

feature 

	remove_occurence (l: SORTED_TWO_WAY_LIST [DEPEND_UNIT]) is
			-- Remove one occurence for each supplier of id
			-- included in `l'.
		require
			good_argument: l /= Void;
			consistency: is_ok (l);
		local
			suppl_info: SUPPLIER_INFO;
			id: INTEGER;
		do
			from
				l.start
			until
				l.offright
			loop
				id := l.item.id;
				goto (l.item.id);
				suppl_info := item;
				suppl_info.remove_occurence;
				if suppl_info.occurence <= 0 then
					remove;
				end;
			
					-- Go to next supplier
				from
				until
					l.offright or else	l.item.id /= id
				loop
					l.forth;
				end;
			end;
		end;

	add_occurence (l: SORTED_TWO_WAY_LIST [DEPEND_UNIT]) is
			-- Add one occurence for each supplier of id
			-- included in `l'.
		require
			good_argument: l /= Void
		local
			suppl_info: SUPPLIER_INFO;
			id: INTEGER;
		do
			from
				l.start
			until
				l.offright
			loop
				id := l.item.id;
				suppl_info := info (id);
				if suppl_info = Void then
					!!suppl_info.make (System.class_of_id (id));
					start;
					add_left (suppl_info);
				else
					suppl_info.add_occurence;
				end;
	
				from
				until
					l.offright or else l.item.id /= id
				loop
					l.forth;
				end;
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
				offright
			loop
				Result.add_right (item.twin);
				forth
			end
		end;

feature {NONE}

	goto (id: INTEGER) is
			-- Move cursor to supplier info of id `id'.
		require
			consistency: info (id) /= Void
		do
			from
				start
			until	
				item.supplier.id = id
			loop
				forth;
			end;
		end;
		
	info (id: INTEGER): SUPPLIER_INFO is
			-- Supplier information associated to supplier of id `id'.
		require
			positive_argument: id > 0;
		local
			pos: INTEGER;
		do
			pos := position;
			from
				start
			until
				offright or else Result /= Void
			loop
				if item.supplier.id = id then
					Result := item;
				end;
				forth;
			end;
			go (pos);
		end;

	is_ok (l: SORTED_TWO_WAY_LIST [DEPEND_UNIT]): BOOLEAN is
			-- Is the supplier list consistant regarding to `l'.
		require
			good_argument: l /= Void
		local
			suppl_info: SUPPLIER_INFO;
			id: INTEGER;
		do
			from	
				Result := True;
				l.start;
			until
				l.offright or else not Result
			loop
				id := l.item.id;
				suppl_info := info (id);
				Result := 	suppl_info /= Void
							and then
							suppl_info.occurence >= 1;
				from
				until
					l.offright or else l.item.id /= id
				loop
					l.forth;
				end;
			end;
		end;

feature 

	trace is
			-- Debug purpose
		do
			from
				start
			until
				offright
			loop
				io.error.putstring (item.supplier.class_name);
				io.error.putstring (" [");
				io.error.putint (item.occurence);
				io.error.putstring ("]  ");
				forth;
			end;
		end;
				
end
