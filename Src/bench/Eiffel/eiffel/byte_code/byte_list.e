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
			calls_special_features
		end;
	FIXED_LIST [T]

creation

	make

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

end
