indexing
	description: "Thread safe notify action sequence"
	date: "$Date$"
	revision: "$Revision$"
	note: "This is a simple implementation using a delegate object and a mutex to access it.%
				%As such it is not very efficient."

class
	EV_THREAD_NOTIFY_ACTION_SEQUENCE

inherit
	EV_NOTIFY_ACTION_SEQUENCE
		redefine
			default_create,
			arrayed_list_make,
			make_filled,
			make_from_array,
			cursor,
			first,
			has,
			i_th,
			index_of,
			item,
			last,
			name,
			sequential_occurrences,
			infix "@",
			index_set,
			occurrences,
			capacity,
			is_equal,
			after,
			before,
			call_is_underway,
			changeable_comparison_criterion,
			exhausted,
			full,
			is_empty,
			is_inserted,
			isfirst,
			islast,
			off,
			prunable,
			readable,
			valid_cursor,
			valid_cursor_index,
			valid_index,
			writable,
			abort,
			block,
			compare_objects,
			compare_references,
			flush,
			pause,
			resume,
			back,
			finish,
			forth,
			go_i_th,
			go_to,
			move,
			search,
			start,
			append,
			extend,
			extend_kamikaze,
			fill,
			force,
			force_extend,
			merge_left,
			merge_right,
			prune_when_called,
			put_i_th,
			put,
			put_front,
			put_left,
			put_right,
			replace,
			prune,
			prune_all,
			remove,
			remove_left,
			remove_right,
			wipe_out,
			resize,
			swap,
			linear_representation,
			copy,
			duplicate,
			call,
			default_rescue,
			wrapper,
			do_all,
			do_if,
			for_all,
			there_exists,
			out,
			print
		end

create 
	default_create,
	make_from_sequence

feature {NONE} -- Initialization

	default_create is
			-- Create mutex and delegate object.
		do
			Precursor {EV_NOTIFY_ACTION_SEQUENCE}
			create access_mutex
			create action_sequence
		end

feature {EV_THREAD_NOTIFY_ACTION_SEQUENCE} -- Initialization

	make_from_sequence (a_sequence: like action_sequence) is
			-- Set `action_sequence' with `a_sequence'.
		do
			action_sequence := a_sequence
			create access_mutex
		end
		
feature -- Initialization

	arrayed_list_make (n: INTEGER) is
		do
			access_mutex.lock
			action_sequence.arrayed_list_make (n)
			access_mutex.unlock
		end

	make_filled (n: INTEGER) is
		do
			access_mutex.lock
			action_sequence.make_filled (n)
			access_mutex.unlock
		end

	make_from_array (a: ARRAY [PROCEDURE [ANY, TUPLE]]) is
		do
			access_mutex.lock
			action_sequence.make_from_array (a)
			access_mutex.unlock
		end
	
feature -- Access

	cursor: ARRAYED_LIST_CURSOR is
		do
			access_mutex.lock
			Result := action_sequence.cursor
			access_mutex.unlock
		end

	first: like item is
		do
			access_mutex.lock
			Result := action_sequence.first
			access_mutex.unlock
		end

	has (v: like item): BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.has (v)
			access_mutex.unlock
		end

	i_th (i: INTEGER): like item is
		do
			access_mutex.lock
			Result := action_sequence.i_th (i)
			access_mutex.unlock
		end

	index_of (v: like item; i: INTEGER): INTEGER is
		do
			access_mutex.lock
			Result := action_sequence.index_of (v, i)
			access_mutex.unlock
		end

	item: PROCEDURE [ANY, TUPLE] is
		do
			access_mutex.lock
			Result := action_sequence.item
			access_mutex.unlock
		end

	last: like first is
		do
			access_mutex.lock
			Result := action_sequence.last
			access_mutex.unlock
		end

	name: STRING is
		do
			access_mutex.lock
			Result := action_sequence.name
			access_mutex.unlock
		end

	sequential_occurrences (v: PROCEDURE [ANY, TUPLE]): INTEGER is
		do
			access_mutex.lock
			Result := action_sequence.sequential_occurrences (v)
			access_mutex.unlock
		end

	infix "@" (i: INTEGER): like item is
		do
			access_mutex.lock
			Result := action_sequence @ i
			access_mutex.unlock
		end
	
feature -- Measurement

	index_set: INTEGER_INTERVAL is
		do
			access_mutex.lock
			Result := action_sequence.index_set
			access_mutex.unlock
		end

	occurrences (v: like item): INTEGER is
		do
			access_mutex.lock
			Result := action_sequence.occurrences (v)
			access_mutex.unlock
		end
	
	capacity: INTEGER is
		do
			access_mutex.lock
			Result := action_sequence.capacity
			access_mutex.unlock
		end
	
feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.is_equal (other)
			access_mutex.unlock
		end

feature -- Status report

	after: BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.after
			access_mutex.unlock
		end

	before: BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.before
			access_mutex.unlock
		end

	call_is_underway: BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.call_is_underway
			access_mutex.unlock
		end

	changeable_comparison_criterion: BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.changeable_comparison_criterion
			access_mutex.unlock
		end

	exhausted: BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.exhausted
			access_mutex.unlock
		end

	full: BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.full
			access_mutex.unlock
		end

	is_empty: BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.is_empty
			access_mutex.unlock
		end

	is_inserted (v: PROCEDURE [ANY, TUPLE]): BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.is_inserted (v)
			access_mutex.unlock
		end

	isfirst: BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.isfirst
			access_mutex.unlock
		end

	islast: BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.islast
			access_mutex.unlock
		end

	off: BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.off
			access_mutex.unlock
		end

	prunable: BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.prunable
			access_mutex.unlock
		end

	readable: BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.readable
			access_mutex.unlock
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.valid_cursor (p)
			access_mutex.unlock
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.valid_cursor_index (i)
			access_mutex.unlock
		end

	valid_index (i: INTEGER): BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.valid_index (i)
			access_mutex.unlock
		end

	writable: BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.writable
			access_mutex.unlock
		end
	
feature -- Status setting

	abort is
		do
			access_mutex.lock
			action_sequence.abort
			access_mutex.unlock
		end

	block is
		do
			access_mutex.lock
			action_sequence.block
			access_mutex.unlock
		end

	compare_objects is
		do
			access_mutex.lock
			action_sequence.compare_objects
			access_mutex.unlock
		end

	compare_references is
		do
			access_mutex.lock
			action_sequence.compare_references
			access_mutex.unlock
		end

	flush is
		do
			access_mutex.lock
			action_sequence.flush
			access_mutex.unlock
		end

	pause is
		do
			access_mutex.lock
			action_sequence.pause
			access_mutex.unlock
		end

	resume is
		do
			access_mutex.lock
			action_sequence.resume
			access_mutex.unlock
		end

feature -- Cursor movement

	back is
		do
			access_mutex.lock
			action_sequence.back
			access_mutex.unlock
		end

	finish is
		do
			access_mutex.lock
			action_sequence.finish
			access_mutex.unlock
		end

	forth is
		do
			access_mutex.lock
			action_sequence.forth
			access_mutex.unlock
		end

	go_i_th (i: INTEGER) is
		do
			access_mutex.lock
			action_sequence.go_i_th (i)
			access_mutex.unlock
		end

	go_to (p: CURSOR) is
		do
			access_mutex.lock
			action_sequence.go_to (p)
			access_mutex.unlock
		end

	move (i: INTEGER) is
		do
			access_mutex.lock
			action_sequence.move (i)
			access_mutex.unlock
		end

	search (v: like item) is
		do
			access_mutex.lock
			action_sequence.search (v)
			access_mutex.unlock
		end

	start is
		do
			access_mutex.lock
			action_sequence.start
			access_mutex.unlock
		end

feature -- Element change

	append (s: SEQUENCE [PROCEDURE [ANY, TUPLE]]) is
		do
			access_mutex.lock
			action_sequence.append (s)
			access_mutex.unlock
		end

	extend (v: like item) is
		do
			access_mutex.lock
			action_sequence.extend (v)
			access_mutex.unlock
		end

	extend_kamikaze (an_item: like item) is
		do
			access_mutex.lock
			action_sequence.extend_kamikaze (an_item)
			access_mutex.unlock
		end

	fill (other: CONTAINER [PROCEDURE [ANY, TUPLE]]) is
		do
			access_mutex.lock
			action_sequence.fill (other)
			access_mutex.unlock
		end

	force (v: like item) is
		do
			access_mutex.lock
			action_sequence.force (v)
			access_mutex.unlock
		end

	force_extend (action: PROCEDURE [ANY, TUPLE]) is
		do
			access_mutex.lock
			action_sequence.force_extend (action)
			access_mutex.unlock
		end

	merge_left (other: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]) is
		do
			access_mutex.lock
			action_sequence.merge_left (other)
			access_mutex.unlock
		end

	merge_right (other: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]) is
		do
			access_mutex.lock
			action_sequence.merge_right (other)
			access_mutex.unlock
		end

	prune_when_called (an_action: like item) is
		do
			access_mutex.lock
			action_sequence.prune_when_called (an_action)
			access_mutex.unlock
		end
	
	put_i_th (v: like i_th; i: INTEGER) is
		do
			access_mutex.lock
			action_sequence.put_i_th (v, i)
			access_mutex.unlock
		end

	put (v: like item) is
		do
			access_mutex.lock
			action_sequence.put (v)
			access_mutex.unlock
		end

	put_front (v: like item) is
		do
			access_mutex.lock
			action_sequence.put_front (v)
			access_mutex.unlock
		end

	put_left (v: like item) is
		do
			access_mutex.lock
			action_sequence.put_left (v)
			access_mutex.unlock
		end

	put_right (v: like item) is
		do
			access_mutex.lock
			action_sequence.put_right (v)
			access_mutex.unlock
		end

	replace (v: like first) is
		do
			access_mutex.lock
			action_sequence.replace (v)
			access_mutex.unlock
		end
	
feature -- Removal

	prune (v: like item) is
		do
			access_mutex.lock
			action_sequence.prune (v)
			access_mutex.unlock
		end

	prune_all (v: like item) is
		do
			access_mutex.lock
			action_sequence.prune_all (v)
			access_mutex.unlock
		end

	remove is
		do
			access_mutex.lock
			action_sequence.remove
			access_mutex.unlock
		end

	remove_left is
		do
			access_mutex.lock
			action_sequence.remove_left
			access_mutex.unlock
		end

	remove_right is
		do
			access_mutex.lock
			action_sequence.remove_right
			access_mutex.unlock
		end

	wipe_out is
		do
			access_mutex.lock
			action_sequence.wipe_out
			access_mutex.unlock
		end
	
feature -- Resizing

	resize (new_capacity: INTEGER) is
		do
			access_mutex.lock
			action_sequence.resize (new_capacity)
			access_mutex.unlock
		end
	
feature -- Transformation

	swap (i: INTEGER) is
		do
			access_mutex.lock
			action_sequence.swap (i)
			access_mutex.unlock
		end
	
feature -- Conversion

	linear_representation: LINEAR [PROCEDURE [ANY, TUPLE]] is
		do
			access_mutex.lock
			Result := action_sequence.linear_representation
			access_mutex.unlock
		end

feature -- Duplication

	copy (other: like Current) is
		do
			access_mutex.lock
			action_sequence.copy (other)
			access_mutex.unlock
		end

	duplicate (n: INTEGER): EV_THREAD_NOTIFY_ACTION_SEQUENCE is
		do
			access_mutex.lock
			create Result.make_from_sequence (action_sequence.duplicate (n))
			access_mutex.unlock
		end

feature -- Basic operations

	call (event_data: TUPLE) is
		do
			access_mutex.lock
			action_sequence.call (event_data)
			access_mutex.unlock
		end

	default_rescue is
		do
			access_mutex.lock
			action_sequence.default_rescue
			access_mutex.unlock
		end

	wrapper (action: PROCEDURE [ANY, TUPLE]) is
		do
			access_mutex.lock
			action_sequence.wrapper (action)
			access_mutex.unlock
		end

feature -- Iteration

	do_all (action: PROCEDURE [ANY, TUPLE [PROCEDURE [ANY, TUPLE]]]) is
		do
			access_mutex.lock
			action_sequence.do_all (action)
			access_mutex.unlock
		end

	do_if (action: PROCEDURE [ANY, TUPLE [PROCEDURE [ANY, TUPLE]]]; test: FUNCTION [ANY, TUPLE [PROCEDURE [ANY, TUPLE]], BOOLEAN]) is
		do
			access_mutex.lock
			action_sequence.do_if (action, test)
			access_mutex.unlock
		end

	for_all (test: FUNCTION [ANY, TUPLE [PROCEDURE [ANY, TUPLE]], BOOLEAN]): BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.for_all (test)
			access_mutex.unlock
		end

	there_exists (test: FUNCTION [ANY, TUPLE [PROCEDURE [ANY, TUPLE]], BOOLEAN]): BOOLEAN is
		do
			access_mutex.lock
			Result := action_sequence.there_exists (test)
			access_mutex.unlock
		end
	
feature -- Output

	out: STRING is
		do
			access_mutex.lock
			Result := action_sequence.out
			access_mutex.unlock
		end

	print (some: ANY) is
		do
			access_mutex.lock
			action_sequence.print (some)
			access_mutex.unlock
		end

feature {NONE} -- Implementation

	access_mutex: MUTEX
			-- Access mutex

	action_sequence: EV_NOTIFY_ACTION_SEQUENCE
			-- Delegate object

end -- class EV_THREAD_NOTIFY_ACTION_SEQUENCE
