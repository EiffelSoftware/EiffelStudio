indexing

	description:
		"A poll medium used for polling mediums (multiplexing).";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MEDIUM_POLLER

inherit

	SOCKET_RESOURCES

creation

	make, make_read_only, make_write_only, make_exception_only

feature -- Initialization

	make is
		do
			set_read
			set_write
			set_exception
		end

	make_read_only is
		do
			set_read
			set_ignore_write
			set_ignore_exception
		end

	make_write_only is
		do
			set_write
			set_ignore_read
			set_ignore_exception
		end

	make_exception_only is
		do
			set_exception
			set_ignore_write
			set_ignore_read
		end

feature

	execute (total_number, time_out_msec: INTEGER) is
			-- poll 'total_number' of io_mediums and
			-- and process the ready mediums
			-- If no mediums are ready wait the 'time_out..'
			-- time before returning.
		require
			valid_number: total_number > 0
		local
			number_ready: INTEGER
		do
			number_ready := medium_select (total_number, time_out_msec)
			if number_ready > 0 then
				process_selected (number_ready)
			end
		end

	medium_select (number_to_check, time_out_msec: INTEGER): INTEGER is
			-- check the multiplexing masks for the 
			-- read, write, and exception medium reception
			-- and return the number of mediums waiting
			-- after 'time_out...' time
		local
			lrm, lwm, lem: ANY
		do
			if not ignore_read and then not read_command_list.all_cleared then
				last_read_mask := clone (read_mask)
				lrm := last_read_mask.mask
			end
			if not ignore_write and then not write_command_list.all_cleared then
				last_write_mask := clone (write_mask)
				lwm := last_write_mask.mask
			end
			if not ignore_exception and then not exception_command_list.all_cleared then
				last_except_mask := clone (except_mask)
				lem := last_except_mask.mask
			end

			if wait then
				Result := c_select (number_to_check, $lrm, $lwm, $lem, -1, 0)
			else
				Result := c_select (number_to_check, $lrm, $lwm, $lem, time_out_msec//1000, time_out_msec\\1000)
			end
		end

feature --  blocking features

	wait: BOOLEAN
			-- flag to decide if the select call should use the time out feature
			-- or block until there is data to be processed

	set_wait is
			-- set wait to true
		do
			wait := True
		ensure
			wait_set: wait
		end

	unset_wait is
			-- set wait to false
		do
			wait := False
		ensure
			wait_not_set: not wait
		end

feature -- process set commands

	process_selected (number_of_selected: INTEGER) is
			-- process the commands for the mediums that are ready
		require
			valid_number: number_of_selected > 0
		local
			counter, counter1: INTEGER
			a_command: POLL_COMMAND
		do
			if not ignore_read and then not read_command_list.all_cleared then
				from 
					counter1 := read_command_list.lower
				until
					counter1 > read_command_list.upper or else 
						not (counter < number_of_selected)
				loop
					a_command := read_command_list.item (counter1)
					if a_command /= Void then
						if last_read_mask.is_medium_ready (a_command.active_medium) then
							a_command.execute
							counter := counter + 1
						end
					end
					counter1 := counter1 + 1
				end
			end
			if not ignore_write and then counter < number_of_selected and then not write_command_list.all_cleared then
				from 
					counter1 := write_command_list.lower
				until
					counter1 > write_command_list.upper or else 
						not (counter < number_of_selected)
				loop
					a_command := write_command_list.item (counter1)
					if a_command /= Void then
						if last_write_mask.is_medium_ready (a_command.active_medium) then
							a_command.execute
							counter := counter + 1
						end
					end
					counter1 := counter1 + 1
				end
			end
			if not ignore_exception and then counter < number_of_selected and then not exception_command_list.all_cleared then
				from
					counter1 := exception_command_list.lower
				until
					counter1 > exception_command_list.upper or else
					   not (counter < number_of_selected)
				loop
					a_command := exception_command_list.item (counter1)
					if a_command /= Void then
						if last_except_mask.is_medium_ready (a_command.active_medium) then
							a_command.execute
							counter := counter + 1
						end
					end
					counter1 := counter1 + 1
				end
			end
		end

feature -- medium masks

	last_except_mask: POLL_MASK
			-- execption mask returned from medium select

	last_read_mask: POLL_MASK
			-- read mask returned from medium select

	last_write_mask: POLL_MASK
			-- write maske returned from medium select

	except_mask: POLL_MASK is
			-- execption mask used for medium select
		once
			!!Result.make
		end

	read_mask: POLL_MASK is
			-- read mask used for medium select
		once
			!!Result.make
		end

	write_mask: POLL_MASK is
			-- write mask used for medium select
		once
			!!Result.make
		end

feature -- booleans to decide whether to include each mask in the select call

	ignore_read: BOOLEAN
			-- flag to check the read mask

	ignore_write: BOOLEAN
			-- flag to check the write mask

	ignore_exception: BOOLEAN
			--  flag to check the exception mask

	set_exception is
			-- check the exception mask
		do
			ignore_exception := False
		ensure
			exception_used: not ignore_exception
		end

	set_ignore_exception is
			--  Ignore the exception mask
		do
			ignore_exception := True
		ensure
			exception_not_used: ignore_exception
		end

	set_read is
			--  check the read mask
		do
			ignore_read := False
		ensure
			read_used: not ignore_read
		end

	set_ignore_read is
			-- ignore the read mask
		do
			ignore_read := True
		ensure
			read_not_used: ignore_read
		end

	set_write is
			-- check the write mask
		do
			ignore_write := False
		ensure
			write_used: not ignore_write
		end

	set_ignore_write is
			-- ignore the write mask
		do
			ignore_write := True
		ensure
			write_not_used: ignore_write
		end

feature -- commands to be executed

	read_command_list: ARRAY [POLL_COMMAND] is
			-- list of poll commands to be called
			-- by medium select read mask
		once
			!!Result.make (0, 10)
		end

	put_read_command (a_command: POLL_COMMAND) is
			-- force the poll command into the command_list array
			-- at the position identified by the active medium
			-- handle held in a_command
			-- Set the appropriate mask bit for the active medium
		require
			valid_command: a_command /= Void
			not_empty_medium: a_command.active_medium /= Void
		do
			read_mask.set_medium (a_command.active_medium)
			read_command_list.force (a_command, a_command.active_medium.handle)
		ensure
			command_added: read_command_list.has (a_command)
		end

	remove_read_command (a_command: POLL_COMMAND) is
			-- remove a poll command from 'read_command_list'
			-- using the active medium handle defined in 'a_command'
			-- Set the appropriate read mask bit to zero
		require
			valid_command: a_command /= Void
			has_command: read_command_list.has (a_command)
			not_empty_medium: a_command.active_medium /= Void
		do
			read_command_list.put (Void, a_command.active_medium.handle)
			read_mask.clear_medium (a_command.active_medium)
		ensure
			command_removed: not read_command_list.has (a_command)
		end

	remove_associated_read_command (s: IO_MEDIUM) is
			-- remove a poll command from 'read_command_list'
			-- using the medium handle defined in 's'
			-- Set the appropriate read mask bit to zero
		require
				has_command: read_command_list.upper >= s.handle
		do
			read_command_list.put (Void, s.handle)
			read_mask.clear_medium (s)
		ensure
			command_removed: read_command_list.item (s.handle) = Void
		end

	write_command_list: ARRAY [POLL_COMMAND] is
			-- list of poll commands to be called
			-- by medium select
		once
			!!Result.make (0, 10)
		end

	put_write_command (a_command: POLL_COMMAND) is
			-- force the poll command into the command_list array
			-- at the position identified by the active medium
			-- handle held in a_command
			-- Set the appropriate bit in the write mask
		require
			valid_command: a_command /= Void
			not_empty_medium: a_command.active_medium /= Void
		do
			write_mask.set_medium (a_command.active_medium)
			write_command_list.force (a_command, a_command.active_medium.handle)
		ensure
			command_added: write_command_list.has (a_command)
		end

	remove_write_command (a_command: POLL_COMMAND) is
			-- remove a poll command from 'write_command_list'
			-- using the active medium handle defined in 'a_command'
			-- Set the appropriate write mask bit to zero
		require
			has_command: write_command_list.has (a_command)
		do
			write_command_list.put (Void, a_command.active_medium.handle)
			write_mask.clear_medium (a_command.active_medium)
		ensure
			command_removed: not write_command_list.has (a_command)
		end

	remove_associated_write_command (s: IO_MEDIUM) is
			-- remove a poll command from 'write_command_list'
			-- using the medium handle defined in 's'
			-- Set the appropriate write mask bit to zero
		require
			has_command: write_command_list.upper >= s.handle
		do
			write_command_list.put (Void, s.handle)
			write_mask.clear_medium (s)
		ensure
			command_removed: write_command_list.item (s.handle) = Void
		end

	exception_command_list: ARRAY [POLL_COMMAND] is
			-- list of poll commands to be called
			-- by medium select
		once
			!!Result.make (0, 10)
		end

	put_exception_command (a_command: POLL_COMMAND) is
			-- force the poll command into the command_list array
			-- at the position identified by the active medium
			-- handle held in a_command
			-- Set the appropriate bit in the exception mask
		require
			valid_command: a_command /= Void
			not_empty_medium: a_command.active_medium /= Void
		do
			except_mask.set_medium (a_command.active_medium)
			exception_command_list.force (a_command, a_command.active_medium.handle)
		ensure
			command_added: exception_command_list.has (a_command)
		end

	remove_exception_command (a_command: POLL_COMMAND) is
			-- remove a poll command from 'exception_command_list'
			-- using the active medium handle defined in 'a_command'
			-- Set the appropriate exception mask bit to zero
		require
			has_command: exception_command_list.has (a_command)
		do
			exception_command_list.put (Void, a_command.active_medium.handle)
			except_mask.clear_medium (a_command.active_medium)
		ensure
			command_removed: not exception_command_list.has (a_command)
		end

	remove_associated_exception_command (s: IO_MEDIUM) is
			-- remove a poll command from 'exception_command_list'
			-- using the medium handle defined in 's'
			-- Set the appropriate exception mask bit to zero
		require
			has_command: exception_command_list.upper >= s.handle
		do
			exception_command_list.put (Void, s.handle)
			except_mask.clear_medium (s)
		ensure
			command_removed: exception_command_list.item (s.handle) = Void
		end

feature {NONE}

	c_select (nfds: INTEGER; rmask, wmask, emask: POINTER; time_sec, time_msec: INTEGER): INTEGER  is
			-- a external c routine used to set up multiplexing
			-- of many mediums defined by the mask parameters
		external
			"C"
		end

end -- class MEDIUM_POLLER

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

