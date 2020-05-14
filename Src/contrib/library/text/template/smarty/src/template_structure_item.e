note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEMPLATE_STRUCTURE_ITEM

inherit
	TEMPLATE_COMMON
		redefine
			resolved_formatted_variable
		end

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create items.make (5)
			create runtime_values.make (3)
			create indexes.make (5)
		end

feature -- Access

	name: detachable READABLE_STRING_8

	is_closed: BOOLEAN

	has_closing_item: BOOLEAN

	parent: detachable TEMPLATE_STRUCTURE_ITEM

	indexes: ARRAYED_LIST [INTEGER_INTERVAL]

	start_index: INTEGER
		do
			Result := indexes.first.lower
		end

	end_index: INTEGER
		do
			Result := indexes.first.upper
		end

	closing_start_index: INTEGER
		require
			has_closing_item
		do
			Result := indexes.last.lower
		end

	closing_end_index: INTEGER
		require
			has_closing_item
		do
			Result := indexes.last.upper
		end

	items: ARRAYED_LIST [TEMPLATE_STRUCTURE_ITEM]

	forced_output: detachable READABLE_STRING_8

	error_output: detachable READABLE_STRING_8

feature -- Runtime values

	runtime_values: STRING_TABLE [ANY]

	add_runtime_value (va: ANY; ks: STRING)
		do
			runtime_values.force (va, ks)
		end

feature -- Expression

	resolved_expression (e: READABLE_STRING_8): detachable ANY
			-- `e' should be "$var_name.x.y.z"
			-- to improve .. later
		local
			l_exp: STRING
			l_sp_exp: LIST [STRING]
			tmp: like resolved_variable
		do
			create l_exp.make_from_string (e)
			l_exp.left_adjust
			l_exp.right_adjust
			if not l_exp.is_empty then
				if l_exp.has ('.') then
					from
						l_sp_exp := l_exp.split ('.')
						l_sp_exp.start
						tmp := resolved_variable (l_sp_exp.item)
						l_sp_exp.forth
					until
						l_sp_exp.after or tmp = Void
					loop
						if 	l_sp_exp.item.starts_with ("$") and then
							attached {READABLE_STRING_GENERAL} resolved_variable (l_sp_exp.item) as vn  and then
							vn.is_valid_as_string_8
						then
							tmp := resolved_nested_message (tmp, vn.to_string_8)
						else
							tmp := resolved_nested_message (tmp, l_sp_exp.item)
						end
						l_sp_exp.forth
					end
					Result := tmp
				elseif l_exp[1] = '%'' and then l_exp[l_exp.count] = '%'' then
					Result := l_exp.substring (2, l_exp.count - 1)
				else
					Result := resolved_variable (l_exp)
				end
			end
		end

	resolved_composed_expression (e: READABLE_STRING_8): detachable ANY
		do
			if e.has (':') then
				Result := resolved_concatenation_expression (e)
			else
				Result := resolved_expression (e)
			end
		end

	resolved_arguments (args: LIST [READABLE_STRING_8]): LIST [ANY]
		local
			tmp: like resolved_expression
		do
			create {ARRAYED_LIST [ANY]} Result.make (args.count)
			across
				args as ic
			loop
				if ic.item.is_empty then
					tmp := ""
				else
					tmp := resolved_expression (ic.item)
				end
				if tmp = Void then
					tmp := ic.item
				end
				Result.extend (tmp)
			end
		end

	resolved_concatenation_expression (e: READABLE_STRING_8): detachable ANY
		require
			e_has_colon: e.has (':')
		local
			l_args: LIST [ANY]
			tmp: like resolved_expression
			str1, str2: detachable READABLE_STRING_8
		do
			l_args := resolved_arguments (e.split (':'))
			from
				l_args.start
				Result := l_args.first
				if attached {READABLE_STRING_8} Result as s1 then
					str1 := s1.string
				elseif Result /= Void then
					str1 := Result.out
				end
				l_args.forth
			until
				l_args.after or (Result = Void)
			loop
				tmp := l_args.item
				if attached {READABLE_STRING_8} Result as s1 then
					str1 := s1.string
				elseif Result /= Void then
					str1 := Result.out
				else
					str1 := Void
				end
				if str1 /= Void then
					if attached {READABLE_STRING_8} tmp as s2 then
						str2 := s2
					else
						if tmp /= Void then
							str2 := tmp.out
						end
					end
					if str2 /= Void then
						Result := str1 + str2
					else
						Result := Void
					end
				else
					Result := Void
				end
				l_args.forth
			end
		end

	resolved_variable (e: READABLE_STRING_8): detachable ANY
			-- `e' should be "$var_name"
			-- to improve .. later
		local
			l_exp: STRING
		do
			create l_exp.make_from_string (e)
			l_exp.left_adjust
			l_exp.right_adjust
			Result := resolved_formatted_variable (l_exp)
		end

	resolved_formatted_variable (exp: READABLE_STRING_8): detachable ANY
			-- `exp' should be "$var_name"
			-- to improve .. later
		local
			l_var: READABLE_STRING_8
		do
			Result := Precursor (exp)
			if Result = Void then
				l_var := resolved_variable_name (exp)
				if runtime_values.has (l_var) then
					Result := runtime_values.item (l_var)
				end
			end
		end

feature -- Output

	process
		do
		end

	output: detachable READABLE_STRING_8

	get_output
		do
			output := Void
			if attached forced_output as fo then
				output := fo
			elseif attached error_output as eo then
				output := eo
			end
			forced_output := Void
		end

feature -- Change

	set_name (v: like name)
		do
			name := v
		end

	set_parent (v: like parent)
		do
			parent := v
		end

	add_indexes (s1, s2: INTEGER)
		do
			indexes.force (s1 |..| s2)
		end

	set_indexes (s1, s2: INTEGER)
		do
			add_indexes (s1, s2)
		end

	set_is_closed (v: BOOLEAN)
		do
			is_closed := v
		end

	set_closing_indexes (s1, s2: INTEGER)
		require
			is_closed
		do
			add_indexes (s1, s2)
			has_closing_item := True
		ensure
			has_closing_item
		end

	prepend (iis: like items)
		do
			items.start
			items.merge_left (iis)
		end

	put_item_front (i: TEMPLATE_STRUCTURE_ITEM)
		do
			items.put_front (i)
			i.set_parent (Current)
		end

	put_item_last (i: TEMPLATE_STRUCTURE_ITEM)
		do
			items.force (i)
			i.set_parent (Current)
		end

	set_forced_output (v: like forced_output)
		do
			if v = Void  then
				forced_output := Void
			else
				forced_output := v.twin
			end
		end

	set_error_output (v: like error_output)
		do
			if v = Void  then
				error_output := Void
			else
				error_output := v.twin
			end
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			if attached name as l_name then
				Result := l_name.string
			else
				Result := "?"
			end
		end


note
	copyright: "2011-2016, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end -- class TEMPLATE_STRUCTURE_ITEM
