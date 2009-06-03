note

	description:
		"A medium poller for asynchronous IO on IO_MEDIUMs"
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	MEDIUM_POLLER

inherit

	SOCKET_RESOURCES

create

	make, make_read_only, make_write_only, make_exception_only

feature -- Initialization

	make
			-- Create poller for multi-event polling.
		do
			set_read;
			set_write;
			set_exception
		end;

	make_read_only
			-- Create poller for read events only.
		do
			set_read;
			set_ignore_write;
			set_ignore_exception
		end;

	make_write_only
			-- Create poller for write events only.
		do
			set_write;
			set_ignore_read;
			set_ignore_exception
		end;

	make_exception_only
			-- Create poller for exception events only.
		do
			set_exception;
			set_ignore_write
			set_ignore_read
		end

feature

	execute (max_des, time_out_millisec: INTEGER)
			-- Poll io_medium's whose descriptor is less than
			-- `max_des' and process ready media.
			-- If no medium is ready, wait the 'time_out..' milliseconds
			-- time before returning.
		require
			valid_number: max_des > 0
		local
			number_ready: INTEGER
		do
			number_ready := medium_select (max_des, time_out_millisec);
			if number_ready > 0 then
				process_selected (number_ready)
			end
		end;

	medium_select (number_to_check, time_out_millisec: INTEGER): INTEGER
			-- Check the multiplexing masks for the
			-- read, write, and exception medium reception
			-- and return the number of mediums waiting
			-- after 'time_out...' milliseconds time
		local
			lrm, lwm, lem: POINTER
			l_mask: POLL_MASK
		do
			if not ignore_read and then not read_command_list.all_default then
				l_mask := read_mask.twin
				lrm := l_mask.mask.item
				last_read_mask := l_mask
			end;
			if not ignore_write and then not write_command_list.all_default then
				l_mask := write_mask.twin
				lwm := l_mask.mask.item
				last_write_mask := l_mask
			end;
			if not ignore_exception and then not exception_command_list.all_default then
				l_mask := except_mask.twin
				lem := l_mask.mask.item
				last_except_mask := l_mask
			end;

			if wait then
				Result := c_select (number_to_check, lrm, lwm, lem, -1, 0)
			else
				Result := c_select (number_to_check, lrm, lwm, lem, time_out_millisec//1000, time_out_millisec\\1000)
			end
		end

feature --  blocking features

	wait: BOOLEAN;
		-- Poller blocks until event?
		-- (otherwise, returns after timeout)

	set_wait
			-- Set poller to block.
		do
			wait := True
		ensure
			wait_set: wait
		end;

	unset_wait
			-- Set poller to return after timeout.
		do
			wait := False
		ensure
			wait_not_set: not wait
		end

feature -- process set commands

	process_selected (number_of_selected: INTEGER)
			-- Process commands for ready media.
		require
			valid_number: number_of_selected > 0
		local
			counter, counter1: INTEGER;
			a_command: detachable POLL_COMMAND
			l_last_mask: detachable POLL_MASK
		do
			if not ignore_read and then not read_command_list.all_default then
				from
					l_last_mask := last_read_mask
					check l_last_mask_attached: l_last_mask /= Void end
					counter1 := read_command_list.lower
				until
					counter1 > read_command_list.upper or else
						not (counter < number_of_selected)
				loop
					a_command := read_command_list.item (counter1);
					if a_command /= Void then
						if l_last_mask.is_medium_ready (a_command.active_medium) then
							a_command.execute (Void);
							counter := counter + 1
						end
					end;
					counter1 := counter1 + 1
				end
			end;
			if not ignore_write and then counter < number_of_selected and then not write_command_list.all_default then
				from
					l_last_mask := last_write_mask
					check l_last_mask_attached: l_last_mask /= Void end
					counter1 := write_command_list.lower
				until
					counter1 > write_command_list.upper or else
						not (counter < number_of_selected)
				loop
					a_command := write_command_list.item (counter1);
					if a_command /= Void then
						if l_last_mask.is_medium_ready (a_command.active_medium) then
							a_command.execute (Void);
							counter := counter + 1
						end
					end;
					counter1 := counter1 + 1
				end
			end;
			if not ignore_exception and then counter < number_of_selected and then not exception_command_list.all_default then
				from
					l_last_mask := last_except_mask
					check l_last_mask_attached: l_last_mask /= Void end
					counter1 := exception_command_list.lower
				until
					counter1 > exception_command_list.upper or else
					   not (counter < number_of_selected)
				loop
					a_command := exception_command_list.item (counter1);
					if a_command /= Void then
						if l_last_mask.is_medium_ready (a_command.active_medium) then
							a_command.execute (Void);
							counter := counter + 1
						end
					end;
					counter1 := counter1 + 1
				end
			end
		end

feature -- medium masks

	last_except_mask: detachable POLL_MASK;
			-- Exception mask returned by medium select

	last_read_mask: detachable POLL_MASK;
			-- Read mask returned by medium select

	last_write_mask: detachable POLL_MASK;
			-- Write mask returned by medium select

	except_mask: POLL_MASK
			-- Exception mask used by medium select
		once
			create Result.make
		end;

	read_mask: POLL_MASK
			-- Read mask used by medium select
		once
			create Result.make
		end;

	write_mask: POLL_MASK
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

	set_exception
			-- Set exception mask to be looked up.
		do
			ignore_exception := False
		ensure
			exception_used: not ignore_exception
		end;

	set_ignore_exception
			--  Ignore exception mask.
		do
			ignore_exception := True
		ensure
			exception_not_used: ignore_exception
		end;

	set_read
			-- Set read mask to be looked up.
		do
			ignore_read := False
		ensure
			read_used: not ignore_read
		end;

	set_ignore_read
			-- Ignore read mask.
		do
			ignore_read := True
		ensure
			read_not_used: ignore_read
		end;

	set_write
			-- Set write mask to be looked up.
		do
			ignore_write := False
		ensure
			write_used: not ignore_write
		end;

	set_ignore_write
			-- Ignore write mask.
		do
			ignore_write := True
		ensure
			write_not_used: ignore_write
		end

feature -- commands to be executed

	read_command_list: ARRAY [detachable POLL_COMMAND]
			-- List of poll commands to be called
			-- when their medium is selected for read event.
		once
			create Result.make (0, 10)
		end;

	put_read_command (a_command: POLL_COMMAND)
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

	remove_read_command (a_command: POLL_COMMAND)
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

	remove_associated_read_command (s: IO_MEDIUM)
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

	write_command_list: ARRAY [detachable POLL_COMMAND]
			-- List of poll commands to be called
			-- when their medium is selected for write event.
		once
			create Result.make (0, 10)
		end;

	put_write_command (a_command: POLL_COMMAND)
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

	remove_write_command (a_command: POLL_COMMAND)
			-- Remove `a_command' from write registered media.
		require
			has_command: write_command_list.has (a_command)
		do
			write_command_list.put (Void, a_command.active_medium.handle);
			write_mask.clear_medium (a_command.active_medium)
		ensure
			command_removed: not write_command_list.has (a_command)
		end;

	remove_associated_write_command (s: IO_MEDIUM)
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

	exception_command_list: ARRAY [detachable POLL_COMMAND]
			-- List of poll commands to be called
			-- when their medium is selected for exception event.
		once
			create Result.make (0, 10)
		end;

	put_exception_command (a_command: POLL_COMMAND)
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

	remove_exception_command (a_command: POLL_COMMAND)
			-- Remove `a_command' from exception registered media.
		require
			has_command: exception_command_list.has (a_command)
		do
			exception_command_list.put (Void, a_command.active_medium.handle);
			except_mask.clear_medium (a_command.active_medium)
		ensure
			command_removed: not exception_command_list.has (a_command)
		end;

	remove_associated_exception_command (s: IO_MEDIUM)
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

	c_select (nfds: INTEGER; rmask, wmask, emask: POINTER; time_sec, time_millisec: INTEGER): INTEGER
			-- External C routine designed for asynchronous IO
		external
			"C blocking"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEDIUM_POLLER

