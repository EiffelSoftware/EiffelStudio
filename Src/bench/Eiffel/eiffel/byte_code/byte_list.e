-- List used in the byte code generation.
-- Defines some of the commonly used iterations.

class BYTE_LIST [T -> BYTE_NODE] 

inherit
	BYTE_NODE
		undefine
			copy, setup, is_equal, consistent
		redefine
			enlarge_tree, analyze, generate, make_byte_code,
			has_loop, assigns_to, is_unsafe, optimized_byte_node,
			calls_special_features, size, pre_inlined_code,
			inlined_byte_code, has_separate_call
		end;
	FIXED_LIST [T]
		redefine
			make
		end

creation
	make

feature -- initialization

	make (n: INTEGER) is
			-- Replace `make' by `make_filled' from FIXED_LIST in order
			-- to minimize the change on the compiler due to the new FIXED_LIST
		do
			make_filled (n)
		end

feature 

	analyze is
			-- Loop over `list' and analyze each item
		do
			from
				start;
			until
				after
			loop
				item.analyze;
				forth;
			end;
		end;

	generate is
			-- Loop over `list' and generate each item
		do
			from
				start;
			until
				after
			loop
				item.generate;
				forth;
			end;
		end;

	enlarge_tree is
			-- Loop ovet `list' and enlarges each item
		do
			from
				start;
			until
				after
			loop
				if item.need_enlarging then
					replace (item.enlarged);
				else
					item.enlarge_tree;
				end;
				forth;
			end;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generates byte code for element in the list
		do
			from
				start
			until
				after
			loop
				item.make_byte_code (ba);
				forth;
			end;
		end;

feature -- Array optimization

	has_loop: BOOLEAN is
		do
			from
				start
			until
				Result or else after
			loop
				Result := item.has_loop;
				forth;
			end;
		end;

	assigns_to (i: INTEGER): BOOLEAN is
		do
			from
				start
			until
				Result or else after
			loop
				Result := item.assigns_to (i);
				forth;
			end;
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			from
				start
			until
				Result or else after
			loop
				Result := item.calls_special_features (array_desc)
				forth
			end
		end

	is_unsafe: BOOLEAN is
		do
			from
				start
			until
				Result or else after
			loop
				Result := item.is_unsafe
				forth;
			end;
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			from
				start
			until
				after
			loop
				replace (item.optimized_byte_node)
				forth
			end
		end

feature -- Inlining

	size: INTEGER is
		do
			from
				start
			until
				after
			loop
				Result := Result + item.size
				forth
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			from
				start
			until
				after
			loop
				replace (item.pre_inlined_code)
				forth
			end
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			from
				start
			until
				after
			loop
				replace (item.inlined_byte_code)
				forth
			end
		end

feature -- Convenience

	remove_voids: like Current is
		local
			nbr_void: INTEGER;
		do
			from
				start
			until
				after
			loop
				if (item = Void) then
					nbr_void := nbr_void + 1
				end;
				forth
			end;
			if (nbr_void < count) then
				--| Not all elements are void
				if nbr_void > 0 then
					--| Remove the void elements
					from
						!!Result.make (count - nbr_void);
						Result.start;
						start;
					until
						after
					loop
						if (item /= Void) then
							Result.replace (item);
							Result.forth;
						end;
						forth
					end;
				else
					--| There are no void elements
					Result := Current
				end;
			end
		end;

feature -- Concurrent Eiffel

	has_separate_call: Boolean is
			-- Loop over `list' and determine is there is a separate
			-- call
		do
			from
				start;
			until
				Result or after
			loop
				Result := item.has_separate_call;
				forth;
			end;
		end;

end
