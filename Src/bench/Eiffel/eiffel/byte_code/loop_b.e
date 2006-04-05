indexing
	description	: "Byte code for Eiffel loop."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class LOOP_B

inherit
	INSTR_B
		redefine
			need_enlarging, enlarged,
			assigns_to, is_unsafe, optimized_byte_node,
			calls_special_features, size, inlined_byte_code,
			pre_inlined_code
		end

	ASSERT_TYPE
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_loop_b (Current)
		end

feature -- Access

	from_part: BYTE_LIST [BYTE_NODE]
			-- From part {list of INSTR_B}: can be Void

	invariant_part: BYTE_LIST [BYTE_NODE]
			-- Invariant part {list of ASSERT_B}: can be Void

	variant_part: VARIANT_B
			-- Variant

	stop: EXPR_B
			-- Loop test

	compound: BYTE_LIST [BYTE_NODE]
			-- Compound {list of INSTR_B}; can be Void

	end_location: LOCATION_AS
			-- Line number where `end' keyword is located

feature -- Setting

	set_from_part (f: like from_part) is
			-- Assign `f' to `from_part'.
		do
			from_part := f
		end

	set_invariant_part (i: like invariant_part) is
			-- Assign `i' to `invariant_part'.
		do
			invariant_part := i
		end

	set_stop (s: like stop) is
			-- Assign `s' to `stop'.
		do
			stop := s
		end

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c
		end

	set_variant_part (v: like variant_part) is
			-- Assign `v' to `variant_part'.
		do
			variant_part := v
		end

	set_end_location (e: like end_location) is
			-- Set `end_location' with `e'.
		require
			e_not_void: e /= Void
		do
			end_location := e
		ensure
			end_location_set: end_location = e
		end

	need_enlarging: BOOLEAN is True
			-- This node needs enlarging

	enlarged: LOOP_BL is
			-- Enlarge current node
		do
			create Result
			Result.fill_from (Current)
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := (from_part /= Void and then from_part.assigns_to (i))
				or else (compound /= Void and then compound.assigns_to (i))
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := (from_part /= Void and then from_part.calls_special_features (array_desc))
				or else loop_calls_special_features (array_desc)
		end;

	loop_calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := (compound /= Void and then compound.calls_special_features (array_desc))
				or else (invariant_part /= Void and then invariant_part.calls_special_features (array_desc))
				or else (variant_part /= Void and then variant_part.calls_special_features (array_desc))
				or else stop.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := (from_part /= Void and then from_part.is_unsafe)
				or else loop_is_unsafe
		end

	loop_is_unsafe: BOOLEAN is
		do
			Result := (compound /= Void and then compound.is_unsafe)
				or else (invariant_part /= Void and then invariant_part.is_unsafe)
				or else (variant_part /= Void and then variant_part.is_unsafe)
				or else stop.is_unsafe
		end

	new_optimization_context: OPTIMIZATION_CONTEXT is
		local
			old_context: OPTIMIZATION_CONTEXT;
			array_desc: TWO_WAY_SORTED_SET [INTEGER]
			old_safe_array_desc: TWO_WAY_SORTED_SET [INTEGER]
			safe_array_desc: TWO_WAY_SORTED_SET [INTEGER]
			id: INTEGER;
		do
			old_context := optimizer.optimization_context;
			array_desc := old_context.array_desc;
			old_safe_array_desc := old_context.safe_array_desc;
			safe_array_desc := old_safe_array_desc.deep_twin

			from
				array_desc.start
			until
				array_desc.after
			loop
				id := array_desc.item
				if not (safe_array_desc.has (id)) then
					check
						id <= 0
					end;
						-- It is safe to optimize if
						--	- no assignment is done
						--	- some special features are called
					if not (compound /= Void and then compound.assigns_to (id)) and then
						loop_calls_special_features (id)
					then
							-- This local/Result is not assigned to
						safe_array_desc.extend (id)
					end;
				end
				array_desc.forth
			end

			create Result.make (array_desc, safe_array_desc)
			Result.set_generated_array_desc (old_context.generated_array_desc.deep_twin)
			Result.set_generated_offsets (old_context.generated_offsets.deep_twin)
		end

	optimized_byte_node: LOOP_B is
		local
			opt_loop: OPT_LOOP_B
			opt_context: OPTIMIZATION_CONTEXT
			safe_array_desc, generated_array_desc: TWO_WAY_SORTED_SET [INTEGER]
			generated_offsets: TWO_WAY_SORTED_SET [INTEGER]
			id: INTEGER
			unsafe, generate_optimization: BOOLEAN
		do
			opt_context := new_optimization_context
			optimizer.push_optimization_context (opt_context)

				-- The from part must be optimized with the `old' context, i.e.
				-- the new generated arrays cannot be used
			if from_part /= Void then
				from_part := from_part.optimized_byte_node
			end

			unsafe := loop_is_unsafe

			generate_optimization := not unsafe

				-- Create an optimized loop byte_code
			create opt_loop
				-- Check to see if the new safe array types can
				-- be generated at this level (they must be generated at
				-- the highest possible level but only if they are used!!)
			from
				generated_array_desc := opt_context.generated_array_desc;
				generated_offsets := opt_context.generated_offsets;
				safe_array_desc := opt_context.safe_array_desc
				safe_array_desc.start
			until
				safe_array_desc.after
			loop
				id := safe_array_desc.item;
				if
					not generated_array_desc.has (id)
				and then
					loop_calls_special_features (id)
				then
						-- If the loop is safe, we can generate the access to
						-- area-lower, otherwise, just the offsets
					if unsafe then
						if not generated_offsets.has (id) then
							generated_offsets.extend (id);
							opt_loop.add_offset_to_generate (id);

								-- A special byte code needs to be created
							generate_optimization := True
						end;
					else
						generated_array_desc.extend (id);
						opt_loop.add_array_to_generate (id);
						if generated_offsets.has (id) then
							opt_loop.add_offset_already_generated (id);
						end
					end
				end
				safe_array_desc.forth
			end

			if generate_optimization then
					-- It is safe to optimize array accesses

				opt_loop.set_from_part (from_part);

					-- The new generated arrays can be used now

				if compound /= Void then
					opt_loop.set_compound (compound.optimized_byte_node)
				end;
				if invariant_part /= Void then
					opt_loop.set_invariant_part (invariant_part.optimized_byte_node)
				end;
				opt_loop.set_stop (stop.optimized_byte_node)
				if variant_part /= Void then
					opt_loop.set_variant_part (variant_part.optimized_byte_node)
				end;
				Result := opt_loop
			else
					-- The loop cannot be optimized but the `safe arrays' can be propagated
					-- deeper in the code: once they are marked as safe, no processing is
					-- needed deeper in the code
				Result := Current;

					-- Only the from_part and the compound can be optimized
					-- (the other parts don't contain any loop anyway)
					-- (the from part has already been optimized)
				if compound /= Void then
					compound := compound.optimized_byte_node
				end
			end;

			optimizer.pop_optimization_context
		end;

feature {NONE} -- Array optimization

	optimizer: ARRAY_OPTIMIZER is
		do
			Result := System.remover.array_optimizer
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := 1 + stop.size;
			if from_part /= Void then
				Result := Result + from_part.size
			end;
			if compound /= Void then
				Result := Result + compound.size
			end
			if invariant_part /= Void then
				Result := Result + invariant_part.size
			end;
			if variant_part /= Void then
				Result := Result + variant_part.size
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			if from_part /= Void then
				from_part := from_part.pre_inlined_code
			end
			if compound /= Void then
				compound := compound.pre_inlined_code
			end
			if invariant_part /= Void then
				invariant_part := invariant_part.pre_inlined_code
			end
			if variant_part /= Void then
				variant_part := variant_part.pre_inlined_code
			end
			stop := stop.pre_inlined_code
		end;

	inlined_byte_code: like Current is
		do
			Result := Current
			if from_part /= Void then
				from_part := from_part.inlined_byte_code
			end
			if compound /= Void then
				compound := compound.inlined_byte_code
			end
			if invariant_part /= Void then
				invariant_part := invariant_part.inlined_byte_code
			end
			if variant_part /= Void then
				variant_part := variant_part.inlined_byte_code
			end
			stop := stop.inlined_byte_code
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
