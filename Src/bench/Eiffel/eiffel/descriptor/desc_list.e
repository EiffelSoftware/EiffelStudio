-- List of descriptors of a class (CLASS_C).
-- Note: with the current implementation of genericity, a class can 
-- have several class types, one descriptor must be built for each class type.

class DESC_LIST

inherit

	FIXED_LIST [DESCRIPTOR]
		rename
			make as fl_make,
			put as fl_put
		end;
	SHARED_WORKBENCH
		undefine
			copy, setup, consistent, is_equal
		end;
	SHARED_TMP_SERVER
		undefine
			copy, setup, consistent, is_equal
		end;
	SHARED_ARRAY_BYTE
		undefine
			copy, setup, consistent, is_equal
		end;
	SHARED_BODY_ID
		undefine
			copy, setup, consistent, is_equal
		end;

creation

	make

feature -- Creation

	make (c: CLASS_C; s: INTEGER) is
			-- Initialize descriptor list of class
			-- `c', and initialize the size of the
			-- individual descriptors to `s'.
		local
			desc: DESCRIPTOR
		do
			base_class := c;
			class_types := c.types;

			fl_make (class_types.count);
			from
				start;
				class_types.start
			until
				after
			loop
				!! desc.make (class_types.item, s);
				replace (desc);
				forth;
				class_types.forth
			end;
		end;

feature

	base_class: CLASS_C;
			-- Base class of current descriptor list

	class_types: LINKED_LIST [CLASS_TYPE];
			-- Class types associated with base class of
			-- Current descriptor list
	
feature -- Insertion

	put_invariant (f: INVARIANT_FEAT_I) is
		local
			u: POLY_UNIT
		do
			if f.has_poly_unit then
				u := f.new_poly_unit (Invariant_id);
			end;
			from
				class_types.start;
				start
			until
				class_types.after
			loop
				if u /= Void then
					item.set_invariant_entry (u.entry (class_types.item));
				end;
				class_types.forth;
				forth
			end
		end;

	put (r_id: INTEGER; f: FEATURE_I) is
			-- Insert the routine id `r_id' into the descriptors 
			-- of `base_class', and associate it with the feature `f'.
			--|The (routine_id, FEATURE_I) pair is inserted into
			--|the descriptor DESC_UNIT substructure corresponding
			--|to the origin of the routine. The origin of the routine
			--|is found in the global system table Rout_info_table 
			--|which is built during pass 2.
		local
			u: POLY_UNIT;
			ri: ROUT_INFO;
			origin, offset, nb_routines: INTEGER;
			desc: DESCRIPTOR;
			du: DESC_UNIT;
			void_entry: ENTRY
		do
				-- Get the polymorphical unit corresponding to `f'
				--|Note: see if and how `has_poly_unit' may be used.

			if f.has_poly_unit then
				u := f.new_poly_unit (r_id);
			end;

				-- Get the origin of the routine of id `r_id' and
				-- the offset of that routine in the origin class.
				-- Also get the number of routines introduced in the
				-- origin class.

			ri := System.rout_info_table.item (r_id);
			origin := ri.origin;
			offset := ri.offset;
			nb_routines := System.rout_info_table.offset_counters.item (origin) ;

				-- For each class type, create the appropriate
				-- entry, and insert it into the appropriate
				-- DESC_UNIT structure.

			from
				class_types.start;
				start
			until
				class_types.after
			loop
					-- Get the descriptor of the class type.
				desc := item;
					-- Create a desc_unit if an origin is encountered
					-- for the first time and insert it in the descriptor, 
					-- (otherwise recuperate existing one).
				du := desc.table_item (origin);
				if du = Void then
					!! du.make (origin, nb_routines);
					desc.table_put (du, origin)
				end;
					-- Insert the polymorphical entry correponding to
					-- the current class type and routine of id `r_id'
					-- into the descriptor unit, at the position `offset'.
				check
					offset >= du.lower;
					offset <= du.upper
				end;
				if u /= Void then
					du.put (u.entry (class_types.item), offset);
				end;
				class_types.forth;
				forth
			end

		end;

feature -- Melting

	melt is
			-- Melt the list of descriptors
			-- Format:
			--    1) Number of descriptors (short)
			--    2) Sequence of descriptor byte code
		local
			ba: BYTE_ARRAY;
			md: MELTED_DESC;
			actual_count: INTEGER
		do
				-- Initialization.
			ba := Byte_array;
			ba.clear;

			from
				start
			until
				after
			loop
				if not item.class_type.is_precompiled then
					actual_count := actual_count + 1
				end;
				forth
			end;
				-- Write the number descriptors.
			ba.append_integer (actual_count);

				-- Append the byte of each individual
				-- class type descriptor.
			make_byte_code (ba);

				-- Put the byte code in server.
			md := ba.melted_descriptor;
			md.set_class_id (base_class.id);
			Tmp_m_desc_server.put (md)
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Append the byte code of each individual 
			-- descriptor to `ba'
		do
			from
				start
			until
				after
			loop
				if not item.class_type.is_precompiled then
					item.make_byte_code (ba);
				end;
				forth
			end
		end;

end
