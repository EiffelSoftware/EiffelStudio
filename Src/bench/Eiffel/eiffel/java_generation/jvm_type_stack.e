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
			
	jvm_count: INTEGER
			-- this is the sum of the size of the elements currently in
			-- the stack. So this value should reflect the number of
			-- items on the stack of the runtime during execution of the
			-- java program.
end












