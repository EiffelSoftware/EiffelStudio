indexing
	description	: "Byte code for multi-branch instruction."
	date		: "$Date$"
	revision	: "$Revision$"

class INSPECT_B 

inherit
	INSTR_B
		redefine
			analyze, generate, enlarge_tree, make_byte_code,
			assigns_to, is_unsafe, generate_il,
			optimized_byte_node, calls_special_features,
			size, inlined_byte_code, pre_inlined_code
		end

	VOID_REGISTER
		export
			{NONE} all
		end
	
feature -- Access

	switch: EXPR_B
			-- Expression to inspect

	case_list: BYTE_LIST [BYTE_NODE]
			-- Alternaltives {list of CASE_B}: can be Void

	else_part: BYTE_LIST [BYTE_NODE]
			-- Default compound {list of INSTR_B}: can be Void

	end_location: TOKEN_LOCATION
			-- Line number where `end' keyword is located

feature -- Status setting

	set_switch (s: like switch) is
			-- Assign `s' to `switch'.
		do
			switch := s
		end

	set_case_list (c: like case_list) is
			-- Assign `c' to `case_list'.
		do
			case_list := c
		end

	set_else_part (e: like else_part) is
			-- Assign `e' to `else_part'.
		do
			else_part := e
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

feature -- Basic operations

	enlarge_tree is
			-- Enlarge the inspect statement
		do
			switch := switch.enlarged
			if case_list /= Void then
				case_list.enlarge_tree
			end
			if else_part /= Void then
				else_part.enlarge_tree
			end
		end

	analyze is
			-- Builds a proper context (for C code).
		do
			context.init_propagation
			switch.propagate (No_register)
			switch.analyze
			switch.free_register
			if case_list /= Void then
				case_list.analyze
			end
			if else_part /= Void then
				else_part.analyze
			end
		end

feature -- C code generation

	generate is
			-- Generate C code in `buffer'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			generate_line_info
			buf.put_new_line
			generate_frozen_debugger_hook
			switch.generate
			buf.put_string ("switch (")
			switch.print_register
			buf.put_string (") {")
			buf.put_new_line
			buf.indent
			if case_list /= Void then
				case_list.generate
			end
			if else_part = Void or else not else_part.is_empty then
				buf.put_string ("default:")
				buf.put_new_line
				buf.indent
				if else_part = Void then
						-- Raise an exception
					buf.put_string ("RTEC(EN_WHEN);")
				else
					else_part.generate
					buf.put_string ("break;")
				end
				buf.put_new_line
				buf.exdent
			end
			buf.exdent
			buf.put_character ('}')
			buf.put_new_line
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for a multi-branch instruction.
		local
			else_label: IL_LABEL
			end_label: IL_LABEL
			intervals: like create_sorted_interval_list
			spans: like build_spans
			inspect_type: TYPE_I
			min_value: INTERVAL_VAL_B
			max_value: INTERVAL_VAL_B
			labels: ARRAY [IL_LABEL]
		do
			else_label := il_label_factory.new_label
			end_label := il_label_factory.new_label
			generate_il_line_info (True)

			if not switch.is_fast_as_local then
					-- Generate switch expression byte code
				switch.generate_il
			end

			if case_list /= Void then
					-- Sort and merge intervals
				intervals := create_sorted_interval_list
				merge_intervals (intervals)
				if intervals.count > 0 then
						-- Calculate minimum and maximum values
					inspect_type := switch.type
					min_value := inspect_type.minimum_interval_value
					max_value := inspect_type.maximum_interval_value
						-- Make sure there are no different objects for the same boundary
					if intervals.first.lower.is_equal (min_value) then
						min_value := intervals.first.lower
					end
					if intervals.last.upper.is_equal (max_value) then
						max_value := intervals.last.upper
					end
						-- Group intervals
					spans := build_spans (intervals, min_value, max_value)
						-- Create array of labels for all cases and put `else_label' to position 0
					create labels.make (-1, case_list.count)
					labels.put (end_label, -1)
					labels.put (else_label, 0)
					generate_spans (spans, 1, spans.count, min_value, max_value, true, true, labels)
				end
			end

			il_generator.mark_label (else_label)
			if else_part /= Void then
				else_part.generate_il
			else
				il_generator.generate_raise_exception ({EXCEP_CONST}.incorrect_inspect_value, Void)
					-- Throw an exception
			end

			il_generator.mark_label (end_label)

			if not switch.is_fast_as_local then
					-- Either there was nothing in the inspect and therefore we need to
					-- pop the value on which we were inspecting as it is not used. Or if
					-- there was some `when' parts we need to remove the duplication made
					-- for case comparison.
				il_generator.pop
			end
			
			check
				end_location_not_void: end_location /= Void
			end
			
			il_generator.put_silent_debug_info (end_location)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a multi-branch instruction
		local
			i: INTEGER
			case: CASE_B
		do
			generate_melted_debugger_hook (ba)

				-- Generate switch expression byte code
			switch.make_byte_code (ba)
			if case_list /= Void then
				from
					i := case_list.count
				until
					i < 1
				loop
					case ?= case_list.i_th (i)
					case.make_range (ba)
					i := i - 1
				end
				ba.append (Bc_jmp)
				ba.mark_forward3		-- To else part
				case_list.make_byte_code (ba)
				ba.write_forward3
			end
			if else_part /= Void then
				else_part.make_byte_code (ba)
			else
				ba.append (Bc_inspect_excep)
			end
				-- Jumps for cases compounds
			if case_list /= Void then
				from
					i := case_list.count
				until
					i < 1
				loop
					ba.write_forward
					i := i - 1
				end
			end
			ba.append (Bc_inspect)
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := (case_list /= Void and then case_list.assigns_to (i)) or else
				(else_part /= Void and then else_part.assigns_to (i))
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := (case_list /= Void and then case_list.calls_special_features (array_desc))
				or else (else_part /= Void and then else_part.calls_special_features (array_desc))
				or else switch.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := (case_list /= Void and then case_list.is_unsafe)
				or else (else_part /= Void and then else_part.is_unsafe)
				or else switch.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			switch := switch.optimized_byte_node
			if case_list /= Void then
				case_list := case_list.optimized_byte_node
			end
			if else_part /= Void then
				else_part := else_part.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := 1 + switch.size
			if case_list /= Void then
				Result := Result + case_list.size
			end
			if else_part /= Void then
				Result := Result + else_part.size
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			if case_list /= Void then
				case_list := case_list.pre_inlined_code
			end
			if else_part /= Void then
				else_part := else_part.pre_inlined_code
			end
			switch := switch.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			if case_list /= Void then
				case_list := case_list.inlined_byte_code
			end
			if else_part /= Void then
				else_part := else_part.inlined_byte_code
			end
			switch := switch.inlined_byte_code
		end

feature {NONE} -- Implementation

	create_sorted_interval_list: SORTED_TWO_WAY_LIST [INTERVAL_B] is
			-- Create sorted list of all intervals in inspect instruction
		require
			case_list_not_void: not case_list.is_empty
		local
			l_case: like case_list
			case_index: INTEGER
			case_b: CASE_B
			case_intervals: BYTE_LIST [INTERVAL_B]
			case_compound: BYTE_LIST [BYTE_NODE]
			interval_b: INTERVAL_B
			has_empty_else_part: BOOLEAN
		do
			has_empty_else_part := else_part /= Void and then else_part.is_empty
			l_case := case_list
			create Result.make
			from
				l_case.start
			until
				l_case.after
			loop
				case_index := l_case.index
				case_b ?= l_case.item
					-- Add all intervals associated with current When_part unless they do the same as Else_part does
				case_intervals := case_b.interval
				case_compound := case_b.compound
				if case_intervals /= Void and then (not has_empty_else_part or else case_compound /= Void and then not case_compound.is_empty) then
					from
						case_intervals.start
					until
						case_intervals.after
					loop
						interval_b := case_intervals.item
						interval_b.set_case_index (case_index)
						Result.extend (interval_b)
						case_intervals.forth
					end
				end
				l_case.forth
			end
		ensure
			result_not_void: Result /= Void
		end

	merge_intervals (intervals: like create_sorted_interval_list) is
			-- Merge adjacent intervals with the same code
		require
			intervals_not_void: intervals /= Void
		local
			interval_b: INTERVAL_B
			case_index: INTEGER
			next_interval_b: INTERVAL_B
			next_case_index: INTEGER
		do
			from
				intervals.start
			until
				intervals.after
			loop
				next_interval_b := intervals.item
				next_case_index := next_interval_b.case_index
				if case_index = next_case_index and then interval_b.upper.is_next (next_interval_b.lower) then
					interval_b.set_upper (next_interval_b.upper)
					intervals.remove
				else
					interval_b := next_interval_b
					case_index := next_case_index
					intervals.forth
				end
			end
		end

	minimum_group_size: INTEGER is 7
			-- Minimum number of items in group for which switch IL instruction is generated
			-- Switch instruction adds too much overhead when group consists of less than 7 items

	build_spans (intervals: like create_sorted_interval_list; min_value, max_value: INTERVAL_VAL_B): ARRAYED_LIST [INTERVAL_SPAN] is
			-- New sorted list of spans built from given `intervals' bounded with `min_value' and `max_value'
		require
			intervals_not_void: intervals /= Void
			min_value_not_void: min_value /= Void
			max_value_not_void: max_value /= Void
		local
			groups: TWO_WAY_LIST [INTERVAL_GROUP]
			interval_element: BI_LINKABLE [INTERVAL_B]
			group: INTERVAL_GROUP
		do
			create groups.make
				-- Merge intervals in groups by walking intervals backward
			from
				interval_element := intervals.last_element
			until
				interval_element = Void
			loop
				create group.make (interval_element)
				groups.put_front (group)
				from
					interval_element := interval_element.left
				until
					interval_element = Void or else not group.is_extended
				loop
					group.extend_with_interval (interval_element)
					if group.is_extended then
						interval_element := interval_element.left
					end
				end
			end
				-- Merge heading and trailing gaps
			group := groups.first
			if group /= Void and then group.lower /= min_value then
				group.extend_with_lower_gap (min_value, true)
			end
			group := groups.last
			if group /= Void and then group.upper /= max_value then
				group.extend_with_upper_gap (max_value, true)
			end
				-- Merge groups by walking them forward
			from
				create Result.make (groups.count)
				groups.start
			until
				groups.after
			loop
				group := groups.item
				group.set_is_extended (true)
				from
					groups.forth
				until
					groups.after or else not group.is_extended
				loop
					group.extend_with_group (groups.item)
					if group.is_extended then
						groups.remove
					end
				end
				if group.count >= minimum_group_size then
						-- This is a dense group with enough elements
					Result.extend (group)
				else
						-- Group has too little elements, replace it by elements themselves
					from
						interval_element := group.lower_interval
					until
						interval_element = group.upper_interval
					loop
						Result.extend (interval_element.item)
						interval_element := interval_element.right
					end
					Result.extend (interval_element.item)
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	generate_spans (spans: like build_spans; lower, upper: INTEGER; min, max: INTERVAL_VAL_B; is_min_included, is_max_included: BOOLEAN; labels: ARRAY [IL_LABEL]) is
			-- Generate selectors for `spans' with indexes `lower'..`upper' within interval `min'..`max'
			-- where these bounds are included according to `is_min_inclued' and `is_max_included'. Use
			-- `else_label' to branch to Else_part.
		local
			middle: INTEGER
			span: INTERVAL_SPAN
			next_label: IL_LABEL
		do
			if lower = upper then
					-- There is only one group
				span := spans.i_th (lower)
				generate_il_line_info (false)
				span.generate_il (min, max, is_min_included, is_max_included, labels, Current)
			else
					-- Divide groups in two parts and recurse
				middle := (lower + upper) // 2
				span := spans.i_th (middle)
				next_label := il_label_factory.new_label
				generate_il_line_info (false)
				span.upper.generate_il_branch_on_greater (span.is_upper_included, next_label, Current)
				generate_spans (spans, lower, middle, min, span.upper, is_min_included, span.is_upper_included, labels)
				il_generator.mark_label (next_label)
				generate_spans (spans, middle + 1, upper, span.upper, max, not span.is_upper_included, is_max_included, labels)
			end
		end

feature {INTERVAL_SPAN, INTERVAL_VAL_B} -- Implementation

	generate_il_load_value is
			-- Load value of expression
		do
			if switch.is_fast_as_local then
				switch.generate_il
			else
				il_generator.duplicate_top
			end
		end

	generate_il_when_part (case_index: INTEGER; labels: ARRAY [IL_LABEL]) is
			-- Generate code for When_part idetified by `case_index' and
			-- adjust `labels' if required.
		require
			case_list_not_void: case_list /= Void
			valid_case_index: 1 <= case_index and case_index <= case_list.count
			labels_not_void: labels /= Void
			valid_labels: labels.lower = -1 and labels.upper = case_list.count
		local
			case_label: IL_LABEL
			case_b: CASE_B
			compound: BYTE_LIST [BYTE_NODE]
		do
			case_label := labels.item (case_index)
			if case_label = Void then
				case_label := il_label_factory.new_label
				labels.put (case_label, case_index)
			end
			il_generator.mark_label (case_label)
			case_b ?= case_list.i_th (case_index)
			compound := case_b.compound
			if compound /= Void then
				compound.generate_il
			end
			il_generator.branch_to (labels.item (-1))
		ensure
			label_not_void: labels.item (case_index) /= Void
		end

end
