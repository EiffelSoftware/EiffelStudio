-- Descritpion of the suppliers of a class

class SUPPLIER_LIST 

inherit
	LINKED_LIST [SUPPLIER_INFO]

	SHARED_EIFFEL_PROJECT
		undefine
			copy, is_equal
		end

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end

creation

	make

feature 

	remove_occurrence (l: TWO_WAY_SORTED_SET [DEPEND_UNIT]) is
			-- Remove one occurrence for each supplier of id
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
					suppl_info.remove_occurrence;
					if suppl_info.occurrence <= 0 then
						remove;
					end;
				end;
				s.forth
			end;
		end;

	add_occurrence (l: TWO_WAY_SORTED_SET [DEPEND_UNIT]) is
			-- Add one occurrence for each supplier of id
			-- included in `l'.
		require
			good_argument: l /= Void
		local
			suppl_info: SUPPLIER_INFO;
			class_id: INTEGER;
			s: TWO_WAY_SORTED_SET [INTEGER]
		do
			s := suppliers (l);
			from
				s.start
			until
				s.after
			loop
				class_id := s.item;
debug ("ACTIVITY");
	io.error.putstring ("SUPPLIER_LIST add_occurrence: ");
	io.error.putstring (Eiffel_system.class_of_id (class_id).name);
	io.error.new_line;
end;
				suppl_info := info (class_id);
				if suppl_info = Void then
					!! suppl_info.make (class_id);
					put_front (suppl_info);
				else
					suppl_info.add_occurrence;
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

	classes: LINKED_LIST [CLASS_C] is
			-- List of `CLASS_C'es
		do
			from
				!! Result.make
				start
			until
				after
			loop
				Result.extend (item.supplier);
				Result.forth
				forth
			end
		end;

	remove_class (a_class: CLASS_C) is
			-- Remove `a_class' from Current.
			-- Cursor can be moved
		require
			a_class_not_void: a_class /= Void
		local
			class_id: INTEGER
			found: BOOLEAN
		do
			from
				start
				class_id := a_class.class_id
			until
				after or found
			loop
				if item.supplier_id = class_id then
					remove
					found := True
				else
					forth
				end
			end
		end

feature {NONE}

	suppliers (l: TWO_WAY_SORTED_SET [DEPEND_UNIT]): TWO_WAY_SORTED_SET [INTEGER] is
		do
debug ("ACTIVITY")
	io.error.putstring ("SUPPLIER_lIST.suppliers%N");
end;
			create Result.make
			from
				l.start
			until
				l.after
			loop
				Result.extend (l.item.class_id)
debug ("ACTIVITY")
	io.error.putint (l.item.class_id);
	io.error.new_line;
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
				after or else item.supplier_id = id
			loop
				forth;
			end;
		end;
		
	info (id: INTEGER): SUPPLIER_INFO is
			-- Supplier information associated to supplier of id `id'.
		require
			valid_id: id /= 0
		local
			cur: CURSOR;
		do
			cur := cursor;
			from
				start
			until
				after or else Result /= Void
			loop
				if item.supplier_id = id then
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
							suppl_info.occurrence >= 1;
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
				io.error.putint (item.occurrence);
				io.error.putstring ("]  ");
				forth;
			end;
		end;
				
end
