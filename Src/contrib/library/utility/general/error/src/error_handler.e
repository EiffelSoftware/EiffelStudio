note
	description : "Objects that handle error..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_HANDLER

inherit
	ANY

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create {ARRAYED_LIST [ERROR]} errors.make (3)
			create error_added_actions
		end

feature -- Access

	primary_error_code: INTEGER
			-- Code of first error in `errors'
		require
			at_least_one_error: has_error
		do
			Result := errors.first.code
		end

feature -- Status

	has_error: BOOLEAN
			-- Has error?
		do
			Result := count > 0
		end

	count: INTEGER
			-- Number of error
		do
			Result := errors.count
		end

feature {ERROR_HANDLER, ERROR_VISITOR} -- Restricted access

	errors: LIST [ERROR]
			-- Errors container

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			if has_error then
				Result := count.out +  " errors"
			else
				Result := "no error"
			end
		end

feature -- Events

	error_added_actions: ACTION_SEQUENCE [TUPLE [ERROR]]
			-- Actions triggered when a new error is added

feature -- Synchronization

	add_synchronization (h: ERROR_HANDLER)
			-- Add synchronization between `h' and `Current'	
			--| the same handler can be added more than once
			--| it will be synchronized only once
		local
			lst: like synchronized_handlers
		do
			lst := synchronized_handlers
			if lst = Void then
				create {ARRAYED_LIST [ERROR_HANDLER]} lst.make (0)
				lst.compare_references
				synchronized_handlers := lst
			end
			if lst.has (h) then
				check attached h.synchronized_handlers as h_lst and then h_lst.has (Current) end
			else
				lst.extend (h)
				h.add_synchronization (Current)
			end
		end

	remove_synchronization (h: ERROR_HANDLER)
			-- Remove synchronization between `h' and `Current'
		do
			if attached synchronized_handlers as lst and then not lst.is_empty then
				synchronized_handlers := Void
				lst.prune_all (h)

				h.remove_synchronization (Current)

				synchronized_handlers := lst
				if lst.is_empty then
					synchronized_handlers := Void
				end
			end
		end

feature {ERROR_HANDLER} -- Synchronization implementation

	synchronized_handlers: detachable LIST [ERROR_HANDLER]
			-- Synchronized handlers

	synchronize_error_from (e: ERROR; h_lst: LIST [ERROR_HANDLER])
			-- Called by error_handler during synchronization process
			-- if `synchronized_handlers' is Void, this means Current is synchronizing
			-- this is to prevent infinite cycle iteration
		require
			not h_lst.has (Current)
		do
			h_lst.extend (Current)

			if attached synchronized_handlers as lst then
				synchronized_handlers := Void
				add_error (e)
				across
					lst as c
				loop
					if not h_lst.has (c.item) then
						c.item.synchronize_error_from (e, h_lst)
					end
				end
				synchronized_handlers := lst
			else
				-- In synchronization
			end
		end

	synchronize_reset_from (h_lst: LIST [ERROR_HANDLER])
			-- Called by error_handler during synchronization process
			-- if `synchronized_handlers' is Void, this means Current is synchronizing
			-- this is to prevent infinite cycle iteration
		require
			not h_lst.has (Current)
		do
			h_lst.extend (Current)
			if attached synchronized_handlers as lst then
				synchronized_handlers := Void
				reset
				across
					lst as c
				loop
					if not h_lst.has (c.item) then
						c.item.synchronize_reset_from (h_lst)
					end
				end
				synchronized_handlers := lst
			else
				-- In synchronization				
			end
		end

feature {NONE} -- Event: implementation

	on_error_added (e: ERROR)
			-- Error `e' was just added
		local
			sync_list: LINKED_LIST [ERROR_HANDLER]
		do
			error_added_actions.call ([e])
			if attached synchronized_handlers as lst then
				synchronized_handlers := Void
				create sync_list.make
				sync_list.extend (Current)
				across
					lst as c
				loop
					if not sync_list.has (c.item) then
						c.item.synchronize_error_from (e, sync_list)
					end
				end
				synchronized_handlers := lst
			end
		end

	on_reset
			-- `reset' was just called
		local
			sync_list: LINKED_LIST [ERROR_HANDLER]
		do
			if attached synchronized_handlers as lst then
				synchronized_handlers := Void
				create sync_list.make
				sync_list.extend (Current)
				across
					lst as c
				loop
					if not sync_list.has (c.item) then
						c.item.synchronize_reset_from (sync_list)
					end
				end
				synchronized_handlers := lst
			end
		end

feature -- Basic operation

	add_error (a_error: ERROR)
			-- Add `a_error' to the stack of error
		do
			errors.force (a_error)
			on_error_added (a_error)
		end

	add_error_details, add_custom_error (a_code: INTEGER; a_name: STRING; a_message: detachable STRING_32)
			-- Add custom error to the stack of error
		local
			e: ERROR_CUSTOM
		do
			create e.make (a_code, a_name, a_message)
			add_error (e)
		end

	append (other: ERROR_HANDLER)
			-- Append errors from `a_err_handler'
		local
			other_errs: LIST [ERROR]
		do
			other_errs := other.errors
			if other_errs.count > 0 then
				from
					other_errs.start
				until
					other_errs.after
				loop
					add_error (other_errs.item)
					other_errs.forth
				end
			end
		ensure
			other_error_appended: other.has_error implies has_error
			new_count: count = old count + other.count
		end

feature -- Access

	as_single_error: detachable ERROR
			-- All error(s) concatenated into one single error.
		do
			if count > 1 then
				create {ERROR_GROUP} Result.make (errors)
			elseif count > 0 then
				Result := errors.first
			end
		ensure
			has_error_implies_result_attached: has_error implies Result /= Void
		end

	as_string_representation: STRING_32
			-- String representation of all error(s).
		require
			has_error
		do
			if attached as_single_error as e then
				Result := e.string_representation
			else
				check has_error: False end
				Result := {STRING_32} "Error occured"
			end
		end

feature -- Element changes

	concatenate
			-- Concatenate into a single error if any
		do
			if count > 1 and then attached as_single_error as e then
				reset
				add_error (e)
			end
		end

	reset
			-- Reset error handler
		do
			if errors.count > 0 then
				errors.wipe_out
				on_reset
			end
		ensure
			has_no_error: not has_error
			count = 0
		end

	destroy
			-- Destroy Current, and remove any synchronization
		do
			error_added_actions.wipe_out
			if attached synchronized_handlers as lst then
				across
					lst as c
				loop
					c.item.remove_synchronization (Current)
				end
			end
			synchronized_handlers := Void
			reset
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
