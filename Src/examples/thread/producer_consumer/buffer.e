
indexing
    description: "";
    date: "$Date$";
    revision: "$Revision$"

class
	BUFFER

create
	make

feature
	monitor: MUTEX
			-- Monitor lock.

	finished : BOOLEAN_REF
			-- Shared boolean for exiting program.

	notfull, notempty: CONDITION_VARIABLE
			-- Condition for buffer not empty or not full.

	num_full: INTEGER
			-- index of last inserted element.

	start_idx: INTEGER 
			-- First index of buffer.

	n_op, it : INTEGER
			-- Parameters for periodically displaying buffer.

	buffer_size: INTEGER 
			-- Customizable size of buffer.

	data: ARRAY [INTEGER]
			-- Physical buffer of elements.

	make (size, i: INTEGER; finish: BOOLEAN_REF) is 
			-- Initialize customizable parameters
			-- and internal structures.
			-- We need to freeze data because in the Eiffel4 implementation
			-- the nested references of a object put into a proxy can
			-- be collected even if they are still referenced.
			-- Normally, only flat object should be shared between
			-- threads.
			-- `Freeze' protects it and prevent from any collection.
			-- Other references like basic expanded types and synchronization
			-- objects are by definition not collectable.
		do

			finished := finish
			it := i
			buffer_size := size - 1
			create monitor.make
			create notfull.make
			create notempty.make
			create data.make (0,buffer_size)
		end
	
	get (id: INTEGER) is
			-- Get an element from the buffer.	
			-- Note that we have to `wait' in a loop
			-- because the condition may have changed when
			-- the cond. var. is unblocked.
		local 
			d: INTEGER
		do
	
				monitor.lock
				if num_full = 0 then
					from
					until
						num_full /= 0 or else finished.item
					loop
						notempty.wait (monitor)
					end
				end
				if not finished.item then 
				d := data.item (num_full - 1)
				data.put (0, num_full  - 1)
				num_full := num_full - 1
				io.put_integer (id)
				io.put_string ("< Get ")
				io.put_integer (d)
				io.new_line
				n_op := n_op + 1
				check_display
				notfull.signal
				end
				monitor.unlock
		end
			
	put (d: INTEGER; id: INTEGER) is
			-- Put an element in the buffer.
			-- `wait' is nested in a loop for the same reason as
			-- above.
		do
				monitor.lock
				if num_full = buffer_size then
					from 
				until
						num_full /= buffer_size or else finished.item
					loop
						notfull.wait (monitor)
					end
				end
				if not finished.item then 
				data.put (d, (num_full + start_idx)  \\ buffer_size)
				num_full := num_full + 1
				
				io.put_string ("		")
				io.put_integer (id)
				io.put_string ("> Put ")
				io.put_integer (d)
				io.new_line
				n_op := n_op + 1	
				check_display
				notempty.signal
				end
				monitor.unlock
			end
	
	check_display is
			-- Check whether we display the buffer for the 
			-- current operation and in the latter case ask
			-- for exiting.
		do
			if n_op = it and it  /= 0 then
				n_op := 0
				display
				io.put_string ("Press `Return' (`q' to exit)%N")
				io.read_line
				if
					not io.last_string.is_empty and then
					io.last_string.item (1).is_equal ('q')
				then
					io.put_string ("Exiting...%N")
					finished.set_item (True)
					notempty.broadcast
					notfull.broadcast
				end
			end
		end
	
	display is
			-- Display buffer.
		local 
			i: INTEGER
		do
			io.put_string ("*****Display of buffer:%N")
			from
				i := data.lower
			until
				i  >  data.upper
			loop
				io.put_integer (i)
				io.put_string (" -> ")
				io.put_integer (data.item (i))
				io.new_line
				i  := i + 1
			end
			io.put_string ("***********************%N")
		end
end 
