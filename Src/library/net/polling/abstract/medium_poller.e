indexing

	description:
		"A medium poller for asynchronous IO on IO_MEDIUMs";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	MEDIUM_POLLER

inherit

	SOCKET_RESOURCES

creation

	make, make_read_only, make_write_only, make_exception_only

feature -- Initialization

	make is
			-- Create poller for multi-event polling.
		do
			set_read;
			set_write;
			set_exception
		end;

	make_read_only is
			-- Create poller for read events only.
		do
			set_read;
			set_ignore_write;
			set_ignore_exception
		end;

	make_write_only is
			-- Create poller for write events only.
		do
			set_write;
			set_ignore_read;
			set_ignore_exception
		end;

	make_exception_only is
			-- Create poller for exception events only.
		do
			set_exception;
			set_ignore_write
			set_ignore_read
		end

feature

	execute (max_des, time_out_msec: INTEGER) is
			-- Poll io_medium's whose descriptor is less than
			-- `max_des' and process ready media.
			-- If no medium is ready, wait the 'time_out..'
			-- time before returning.
		require
			valid_number: max_des > 0
		local
			number_ready: INTEGER
		do
			number_ready := medium_select (max_des, time_out_msec);
			if number_ready > 0 then
				process_selected (number_ready)
			end
		end;

	medium_select (number_to_check, time_out_msec: INTEGER): INTEGER is
			-- Check the multiplexing masks for the 
			-- read, write, and exception medium reception
			-- and return the number of mediums waiting
			-- after 'time_out...' time
		local
			lrm, lwm, lem: ANY
		do
			if not ignore_read and then not read_command_list.all_default then
				last_read_mask := clone (read_mask);
				lrm := last_read_mask.mask
			end;
			if not ignore_write and then not write_command_list.all_default then
				last_write_mask := clone (write_mask);
				lwm := last_write_mask.mask
			end;
			if not ignore_exception and then 
				not exception_command_list.all_default then
				last_except_mask := clone (except_mask);
				lem := last_except_mask.mask
			end;

			if wait then
				Result := c_select (number_to_check, $lrm, $lwm, $lem, -1, 0)
			else
				Result := c_select (number_to_check, $lrm, $lwm, $lem, time_out_msec//1000, time_out_msec\\1000)
			end
		end

feature --  blocking features

	wait: BOOLEAN;
		-- Poller blocks until event?
		-- (otherwise, returns after timeout)

	set_wait is
			-- Set poller to block.
		do
			wait := True
		ensure
			wait_set: wait
		end;

	unset_wait is
			-- Set poller to return after timeout.
		do
			wait := False
		ensure
			wait_not_set: not wait
		end

feature -- process set commands

	process_selected (number_of_selected: INTEGER) is
			-- Process commands for ready media.
		require
			valid_number: number_of_selected > 0
		local
			counter, counter1: INTEGER;
			a_command: POLL_COMMAND
		do
			if not ignore_read and then not read_command_list.all_default then
				from 
					counter1 := read_command_list.lower
				until
					counter1 > read_command_list.upper or else 
						not (counter < number_of_selected)
				loop
					a_command := read_command_list.item (counter1);
					if a_command /= Void then
						if last_read_mask.is_medium_ready (a_command.active_medium) then
							a_command.execute (Void);
							counter := counter + 1
						end
					end;
					counter1 := counter1 + 1
				end
			end;
			if not ignore_write and then counter < number_of_selected and then
				not write_command_list.all_default then
				from 
					counter1 := write_command_list.lower
				until
					counter1 > write_command_list.upper or else 
						not (counter < number_of_selected)
				loop
					a_command := write_command_list.item (counter1);
					if a_command /= Void then
						if last_write_mask.is_medium_ready (a_command.active_medium) then
							a_command.execute (Void);
							counter := counter + 1
						end
					end;
					counter1 := counter1 + 1
				end
			end;
			if not ignore_exception and then counter < number_of_selected and
				then not exception_command_list.all_default then
				from
					counter1 := exception_command_list.lower
				until
					counter1 > exception_command_list.upper or else
					   not (counter < number_of_selected)
				loop
					a_command := exception_command_list.item (counter1);
					if a_command /= Void then
						if last_except_mask.is_medium_ready (a_command.active_medium) then
							a_command.execute (Void);
							counter := counter + 1
						end
					end;
					counter1 := counter1 + 1
				end
			end
		end

feature -- medium masks

	last_except_mask: POLL_MASK;
			-- Exception mask returned by medium select

	last_read_mask: POLL_MASK;
			-- Read mask returned by medium select

	last_write_mask: POLL_MASK;
			-- Write mask returned by medium select

	except_mask: POLL_MASK is
			-- Exception mask used by medium select
		once
			create Result.make
		end;

	read_mask: POLL_MASK is
			-- Read mask used by medium select
		once
			create Result.make
		end;

	write_mask: POLL_MASK is
			-- Write mask used by medium select.
		once
			create Result.make
		end

feature -- booleans to decide whether to include each mask in the select call

	ignore_read: BOOLEAN;
			-- Is read mask ignored?

	ignore_write: BOOLEAN;
			-- Is write mask ignored?

	ignore_exception: BOOLEAN;
			-- Is Exception mask ignored?

	set_exception is
			-- Set exception mask to be looked up.
		do
			ignore_exception := False
		ensure
			exception_used: not ignore_exception
		end;

	set_ignore_exception is
			--  Ignore exception mask.
		do
			ignore_exception := True
		ensure
			exception_not_used: ignore_exception
		end;

	set_read is
			-- Set read mask to be looked up.
		do
			ignore_read := False
		ensure
			read_used: not ignore_read
		end;

	set_ignore_read is
			-- Ignore read mask.
		do
			ignore_read := True
		ensure
			read_not_used: ignore_read
		end;

	set_write is
			-- Set write mask to be looked up.
		do
			ignore_write := False
		ensure
			write_used: not ignore_write
		end;

	set_ignore_write is
			-- Ignore write mask.
		do
			ignore_write := True
		ensure
			write_not_used: ignore_write
		end

feature -- commands to be executed

	read_command_list: ARRAY [POLL_COMMAND] is
			-- List of poll commands to be called
			-- when their medium is selected for read event.
		once
			create Result.make (0, 10)
		end;

	put_read_command (a_command: POLL_COMMAND) is
			-- Set `a_command' to be called when read event is
			-- selected on its io_medium.
		require
			valid_command: a_command /= Void;
			not_empty_medium: a_command.active_medium /= Void
		do
			read_mask.set_medium (a_command.active_medium);
			read_command_list.force (a_command, a_command.active_medium.handle)
		ensure
			command_added: read_command_list.has (a_command)
		end;

	remove_read_command (a_command: POLL_COMMAND) is
			-- Remove `a_command' from read registered media.
		require
			valid_command: a_command /= Void;
			has_command: read_command_list.has (a_command);
			not_empty_medium: a_command.active_medium /= Void
		do
			read_command_list.put (Void, a_command.active_medium.handle);
			read_mask.clear_medium (a_command.active_medium)
		ensure
			command_removed: not read_command_list.has (a_command)
		end;

	remove_associated_read_command (s: IO_MEDIUM) is
			-- Remove command associated with medium `s' from
			-- read registered media.
		require
				has_command: read_command_list.upper >= s.handle
		do
			read_command_list.put (Void, s.handle);
			read_mask.clear_medium (s)
		ensure
			command_removed: read_command_list.item (s.handle) = Void
		end;

	write_command_list: ARRAY [POLL_COMMAND] is
			-- List of poll commands to be called
			-- when their medium is selected for write event.
		once
			create Result.make (0, 10)
		end;

	put_write_command (a_command: POLL_COMMAND) is
			-- Set `a_command' to be called when write event is
			-- selected on its io_medium.
		require
			valid_command: a_command /= Void;
			not_empty_medium: a_command.active_medium /= Void
		do
			write_mask.set_medium (a_command.active_medium);
			write_command_list.force (a_command, a_command.active_medium.handle)
		ensure
			command_added: write_command_list.has (a_command)
		end;

	remove_write_command (a_command: POLL_COMMAND) is
			-- Remove `a_command' from write registered media.
		require
			has_command: write_command_list.has (a_command)
		do
			write_command_list.put (Void, a_command.active_medium.handle);
			write_mask.clear_medium (a_command.active_medium)
		ensure
			command_removed: not write_command_list.has (a_command)
		end;

	remove_associated_write_command (s: IO_MEDIUM) is
			-- Remove command associated with medium `s' from
			-- write registered media.
		require
			has_command: write_command_list.upper >= s.handle
		do
			write_command_list.put (Void, s.handle);
			write_mask.clear_medium (s)
		ensure
			command_removed: write_command_list.item (s.handle) = Void
		end;

	exception_command_list: ARRAY [POLL_COMMAND] is
			-- List of poll commands to be called
			-- when their medium is selected for exception event.
		once
			create Result.make (0, 10)
		end;

	put_exception_command (a_command: POLL_COMMAND) is
			-- Set `a_command' to be called when exception event
			-- is selected on its io_medium.
		require
			valid_command: a_command /= Void;
			not_empty_medium: a_command.active_medium /= Void
		do
			except_mask.set_medium (a_command.active_medium);
			exception_command_list.force (a_command, a_command.active_medium.handle)
		ensure
			command_added: exception_command_list.has (a_command)
		end;

	remove_exception_command (a_command: POLL_COMMAND) is
			-- Remove `a_command' from exception registered media.
		require
			has_command: exception_command_list.has (a_command)
		do
			exception_command_list.put (Void, a_command.active_medium.handle);
			except_mask.clear_medium (a_command.active_medium)
		ensure
			command_removed: not exception_command_list.has (a_command)
		end;

	remove_associated_exception_command (s: IO_MEDIUM) is
			-- Remove command associated with medium `s' from
			-- exception registered media.
		require
			has_command: exception_command_list.upper >= s.handle
		do
			exception_command_list.put (Void, s.handle);
			except_mask.clear_medium (s)
		ensure
			command_removed: exception_command_list.item (s.handle) = Void
		end

feature {NONE}

	c_select (nfds: INTEGER; rmask, wmask, emask: POINTER; time_sec, time_msec: INTEGER): INTEGER  is
			-- External C routine designed for asynchronous IO
		external
			"C"
		end

end -- class MEDIUM_POLLER



--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

