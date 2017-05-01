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
			if not ignore_read and then not internal_read_command_list.is_empty then
				l_mask := read_mask.twin
				lrm := l_mask.mask.item
				last_read_mask := l_mask
			end;
			if not ignore_write and then not internal_write_command_list.is_empty then
				l_mask := write_mask.twin
				lwm := l_mask.mask.item
				last_write_mask := l_mask
			end;
			if not ignore_exception and then not internal_exception_command_list.is_empty then
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
			counter: INTEGER;
			a_command: POLL_COMMAND
		do
			if not ignore_read and then not internal_read_command_list.is_empty and then attached last_read_mask as l_last_mask then
				from
					internal_read_command_list.start
				until
					internal_read_command_list.after or else not (counter < number_of_selected)
				loop
					a_command := internal_read_command_list.item_for_iteration
					if l_last_mask.is_medium_ready (a_command.active_medium) then
						a_command.execute (Void);
						counter := counter + 1
					end
					internal_read_command_list.forth
				end
			end;
			if
				not ignore_write and then counter < number_of_selected and then not internal_write_command_list.is_empty and then
				attached last_write_mask as l_last_mask
			then
				from
					internal_write_command_list.start
				until
					internal_write_command_list.after or else not (counter < number_of_selected)
				loop
					a_command := internal_write_command_list.item_for_iteration
					if l_last_mask.is_medium_ready (a_command.active_medium) then
						a_command.execute (Void);
						counter := counter + 1
					end
					internal_write_command_list.forth
				end
			end;
			if
				not ignore_exception and then counter < number_of_selected and then not internal_exception_command_list.is_empty and then
				attached last_except_mask as l_last_mask
			then
				from
					internal_exception_command_list.start
				until
					internal_exception_command_list.after or else not (counter < number_of_selected)
				loop
					a_command := internal_exception_command_list.item_for_iteration
					if l_last_mask.is_medium_ready (a_command.active_medium) then
						a_command.execute (Void);
						counter := counter + 1
					end
					internal_exception_command_list.forth
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

feature -- Status Report

	has_read_command (a_command: POLL_COMMAND): BOOLEAN
			-- Is `a_command' part of the read commands list?
		do
			Result := internal_read_command_list.has_item (a_command)
		end

	has_write_command (a_command: POLL_COMMAND): BOOLEAN
			-- Is `a_command' part of the write commands list?
		do
			Result := internal_write_command_list.has_item (a_command)
		end

	has_exception_command (a_command: POLL_COMMAND): BOOLEAN
			-- Is `a_command' part of the exception commands list?
		do
			Result := internal_exception_command_list.has_item (a_command)
		end

	has_associated_read_handle (a_handle: INTEGER): BOOLEAN
			-- Is `a_command' part of the read commands list?
		do
			Result := internal_read_command_list.has (a_handle)
		end

	has_associated_write_handle (a_handle: INTEGER): BOOLEAN
			-- Is `a_command' part of the write commands list?
		do
			Result := internal_write_command_list.has (a_handle)
		end

	has_associated_exception_handle (a_handle: INTEGER): BOOLEAN
			-- Is `a_command' part of the exception commands list?
		do
			Result := internal_exception_command_list.has (a_handle)
		end

feature -- commands to be executed

	read_command_list: ARRAY [POLL_COMMAND]
			-- List of poll commands to be called
			-- when their medium is selected for read event.
		obsolete
			"[
				It is a read only structure for backward compatibility, use `put_read_command' and
				`remove_read_command' to modify its content [2017-05-31].
			]"
		do
			Result := internal_read_command_list.linear_representation.to_array
		end

	write_command_list: ARRAY [POLL_COMMAND]
			-- List of poll commands to be called
			-- when their medium is selected for write event.
		obsolete
			"[
				It is a read only structure for backward compatibility, use `put_write_command' and
				`remove_write_command' to modify its content [2017-05-31] .
			]"
		do
			Result := internal_write_command_list.linear_representation.to_array
		end

	exception_command_list: ARRAY [POLL_COMMAND]
			-- List of poll commands to be called
			-- when their medium is selected for exception event.
		obsolete
			"[
				It is a read only structure for backward compatibility, use `put_exception_command' and
				`remove_exception_command' to modify its content [2017-05-31].
			]"
		do
			Result := internal_exception_command_list.linear_representation.to_array
		end

	put_read_command (a_command: POLL_COMMAND)
			-- Set `a_command' to be called when read event is
			-- selected on its io_medium.
		require
			valid_command: a_command /= Void;
			not_empty_medium: a_command.active_medium /= Void
		do
			read_mask.set_medium (a_command.active_medium);
			internal_read_command_list.force (a_command, a_command.active_medium.handle)
		ensure
			command_added: has_read_command (a_command)
		end;

	remove_read_command (a_command: POLL_COMMAND)
			-- Remove `a_command' from read registered media.
		require
			valid_command: a_command /= Void;
			has_command: has_read_command (a_command)
			not_empty_medium: a_command.active_medium /= Void
		do
			internal_read_command_list.remove (a_command.active_medium.handle);
			read_mask.clear_medium (a_command.active_medium)
		ensure
			command_removed: not has_read_command (a_command)
		end;

	remove_associated_read_command (s: IO_MEDIUM)
			-- Remove command associated with medium `s' from
			-- read registered media.
		require
			has_command: has_associated_read_handle (s.handle)
		do
			internal_read_command_list.remove (s.handle);
			read_mask.clear_medium (s)
		ensure
			command_removed: not has_associated_read_handle (s.handle)
		end;

	put_write_command (a_command: POLL_COMMAND)
			-- Set `a_command' to be called when write event is
			-- selected on its io_medium.
		require
			valid_command: a_command /= Void;
			not_empty_medium: a_command.active_medium /= Void
		do
			write_mask.set_medium (a_command.active_medium);
			internal_write_command_list.force (a_command, a_command.active_medium.handle)
		ensure
			command_added: has_write_command (a_command)
		end;

	remove_write_command (a_command: POLL_COMMAND)
			-- Remove `a_command' from write registered media.
		require
			has_command: has_write_command (a_command)
		do
			internal_write_command_list.remove (a_command.active_medium.handle)
			write_mask.clear_medium (a_command.active_medium)
		ensure
			command_removed: not has_write_command (a_command)
		end;

	remove_associated_write_command (s: IO_MEDIUM)
			-- Remove command associated with medium `s' from
			-- write registered media.
		require
			has_command: has_associated_write_handle (s.handle)
		do
			internal_write_command_list.remove (s.handle);
			write_mask.clear_medium (s)
		ensure
			command_removed: not has_associated_write_handle (s.handle)
		end;

	put_exception_command (a_command: POLL_COMMAND)
			-- Set `a_command' to be called when exception event
			-- is selected on its io_medium.
		require
			valid_command: a_command /= Void;
			not_empty_medium: a_command.active_medium /= Void
		do
			except_mask.set_medium (a_command.active_medium);
			internal_exception_command_list.force (a_command, a_command.active_medium.handle)
		ensure
			command_added: has_exception_command (a_command)
		end;

	remove_exception_command (a_command: POLL_COMMAND)
			-- Remove `a_command' from exception registered media.
		require
			has_command: has_exception_command (a_command)
		do
			internal_exception_command_list.remove (a_command.active_medium.handle);
			except_mask.clear_medium (a_command.active_medium)
		ensure
			command_removed: not has_exception_command (a_command)
		end;

	remove_associated_exception_command (s: IO_MEDIUM)
			-- Remove command associated with medium `s' from
			-- exception registered media.
		require
			has_command: has_associated_exception_handle (s.handle)
		do
			internal_exception_command_list.remove (s.handle);
			except_mask.clear_medium (s)
		ensure
			command_removed: not has_associated_exception_handle (s.handle)
		end

feature {NONE} -- Implementation

	c_select (nfds: INTEGER; rmask, wmask, emask: POINTER; time_sec, time_millisec: INTEGER): INTEGER
			-- External C routine designed for asynchronous IO
		external
			"C blocking"
		end

	internal_read_command_list: HASH_TABLE [POLL_COMMAND, INTEGER]
			-- List of poll commands to be called
			-- when their medium is selected for read event.
		once
			create Result.make (10)
		end;

	internal_write_command_list: HASH_TABLE [POLL_COMMAND, INTEGER]
			-- List of poll commands to be called
			-- when their medium is selected for write event.
		once
			create Result.make (10)
		end;

	internal_exception_command_list: HASH_TABLE [POLL_COMMAND, INTEGER]
			-- List of poll commands to be called
			-- when their medium is selected for exception event.
		once
			create Result.make (10)
		end;

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class MEDIUM_POLLER

