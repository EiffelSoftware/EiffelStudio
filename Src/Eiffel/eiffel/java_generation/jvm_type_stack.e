indexing
	description: "reflects a jvm stack, but not the values are stored, %
	%but their types - JVM_CONSTANTS.*_type). Since the stack of the %
   %jvm is not typed, we need to take care of certain things. ie. %
   %when we want to add two numbers we need to know their types and %
   %then issue the correct add instruction (iadd, ladd, fadd or dadd).%
   % to do that we obviously need to know the types of the two top %
   %most stack items. this object helps keeping this information. not %
   %the actual values are stored here (they are unknown most of the %
   %time at compile time anyway) but their jvm types. to simplify %
   %things evert type is only one item, contrary two the jvm stack %
   %model where certain types take two stack words."
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	JVM_TYPE_STACK

inherit
	LINKED_STACK [INTEGER]
		export
			{ANY} i_th
		redefine
			extend, force, put, remove
		end
	
	JVM_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make	

feature
			
	extend (v: like item) is
			-- add item to stack
		do
			check
				valid_type: valid_jvm_type (v)
			end
			Precursor (v)
			jvm_count := jvm_count + jvm_type_to_stack_size (v)
			max_jvm_count := jvm_count.max (max_jvm_count)
			debug ("JVM_STACK")
				print ("%Tstack_extend: " + count.out + ", " + jvm_count.out + "%N")
			end
		end
			
	force, put (v: like item) is
		do
			extend (v)
		end
			
	remove is
		do
			jvm_count := jvm_count - jvm_type_to_stack_size (item)
			Precursor
			debug ("JVM_STACK")
				print ("%Tstack_remove: " + count.out + ", " + jvm_count.out + "%N")
			end
		end
			
	max_jvm_count: INTEGER
			-- the maximum number of items since it's creation
			
	jvm_count: INTEGER;
			-- this is the sum of the size of the elements currently in
			-- the stack. So this value should reflect the number of
			-- items on the stack of the runtime during execution of the
			-- java program.
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












