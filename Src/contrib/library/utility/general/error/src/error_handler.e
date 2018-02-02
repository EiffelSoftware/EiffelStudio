note
	description : "Error handler or receiver."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_HANDLER

inherit
	DEBUG_OUTPUT

create
	make,
	make_with_id

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create {ARRAYED_LIST [ERROR]} errors.make (3)
			create error_added_actions
		end

	make_with_id (a_id: READABLE_STRING_8)
			-- Build `Current' with optional id `a_id'.
		do
			make
			if a_id = Void then
				id := Void
			else
				create id.make_from_string (a_id)
			end
		end

feature -- Access

	id: detachable IMMUTABLE_STRING_8
			-- Optional identifier for Current handler.

	primary_error_code: INTEGER
			-- Code of first error in `errors'.
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
			-- Number of error.
		do
			Result := errors.count
		end

	is_synchronizing_with (other: ERROR_HANDLER): BOOLEAN
			-- Is Current synchronizing with `other'?
			-- i.e 2 way propagation.
		do
			Result := is_propagating_to (other) and other.is_propagating_to (Current)
		end

	is_propagating_to (other: ERROR_HANDLER): BOOLEAN
			-- Is Current propagating error to `other'?
		do
			Result := attached propagations as lst and then lst.has (other)
		end

feature {ERROR_HANDLER, ERROR_VISITOR} -- Restricted access

	errors: LIST [ERROR]
			-- Errors container.

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			if has_error then
				Result := count.out +  " errors"
			else
				Result := "no error"
			end
			if attached id as l_id then
				Result.prepend ("[" + l_id + "] ")
			end
			if attached propagations as lst then
				check not_empty: not lst.is_empty end
				Result.append_character ('(')
				Result.append (" -> ")
				Result.append_integer (lst.count)
				Result.append_character (':')
				across
					lst as ic
				loop
					if attached ic.item.id as l_id then
						Result.append_character (' ')
						Result.append (l_id)
					end
				end
				Result.append_character (')')
			end
		end

feature -- Events

	error_added_actions: ACTION_SEQUENCE [TUPLE [ERROR]]
			-- Actions triggered when a new error is added.

feature -- Synchronization

	add_synchronization (h: ERROR_HANDLER)
			-- Add synchronization between `h' and `Current`.
			--| the same handler can be added more than once
			--| it will be synchronized only once
		do
			add_propagation (h)
			h.add_propagation (Current)
		end

	remove_synchronization (h: ERROR_HANDLER)
			-- Remove synchronization between `h' and `Current'.
		do
			remove_propagation (h)
			h.remove_propagation (Current)
		end

feature -- One way synchronization: propagation

	add_propagation (h: ERROR_HANDLER)
			-- Add propagation from `Current' to `h'.
			--| the same handler can be added more than once
			--| it will be synchronized only once
		local
			lst: like propagations
		do
			h.register_propagator (Current)
			lst := propagations
			if lst = Void then
				create {ARRAYED_LIST [ERROR_HANDLER]} lst.make (0)
				lst.compare_references
				propagations := lst
			end
			if not lst.has (h) then
				lst.extend (h)
			end
		end

	remove_propagation (h: ERROR_HANDLER)
			-- Remove propagation from `Current' to `h'.
		do
			if attached propagations as lst and then not lst.is_empty then
				lst.prune_all (h)
				if lst.is_empty then
					propagations := Void
				end
			end
			h.unregister_propagator (Current)
		end

feature {ERROR_HANDLER} -- Synchronization implementation

	is_associated_with (h: ERROR_HANDLER): BOOLEAN
		do
			if attached propagators as lst then
				Result := lst.has (h)
			end
		end

	register_propagator (h: ERROR_HANDLER)
		local
			lst: like propagators
		do
			lst := propagators
			if lst = Void then
				create {ARRAYED_LIST [ERROR_HANDLER]} lst.make (1)
				propagators := lst
			end
			if not lst.has (h) then
				lst.extend (h)
			end
		end

	unregister_propagator (h: ERROR_HANDLER)
		local
			lst: like propagators
		do
			lst := propagators
			if lst /= Void then
				lst.prune_all (h)
				if lst.is_empty then
					propagators := Void
				end
			end
		end

	propagators: detachable LIST [ERROR_HANDLER]
			-- Handlers propagating to Current.
			-- Needed for `reset'.

	propagations: detachable LIST [ERROR_HANDLER]
			-- Handlers receiving the propagation.

	propagate_error_addition (e: ERROR; h_lst: LIST [ERROR_HANDLER])
			-- Called by error_handler during synchronization process.
			-- To prevent infinite cycle, if Currently synchronizing, the `propagations' is Void.
		require
			not h_lst.has (Current)
		local
			lst: like propagations
		do
			h_lst.extend (Current)
			lst := propagations
			propagations := Void
			add_error (e)

			if lst /= Void then
				across
					lst as c
				loop
					if not h_lst.has (c.item) then
						c.item.propagate_error_addition (e, h_lst)
					end
				end
				propagations := lst
			else
					--| propagating
			end
		end

	propagate_errors_removal (errs: ITERABLE [ERROR]; h_lst: LIST [ERROR_HANDLER])
			-- Called by error_handler during synchronization process.
			-- To prevent infinite cycle, if Currently synchronizing, the `propagations' is Void.
		require
			not h_lst.has (Current)
		local
			lst: like propagations
		do
			h_lst.extend (Current)
			lst := propagations
			propagations := Void
			across
				errs as ic
			loop
					-- Question: should we use remove_error (ic.item) ?
				errors.prune_all (ic.item)
			end

			if lst /= Void then
				across
					lst as c
				loop
					if not h_lst.has (c.item) then
						c.item.propagate_errors_removal (errs, h_lst)
					end
				end
				propagations := lst
			else
					--| propagating				
			end
		end

	backpropagate_reset (h_lst: LIST [ERROR_HANDLER])
			-- Called by error_handler during propagation process.
			-- To prevent infinite cycle, if Currently synchronizing, the `propagations' is Void.
		require
			not h_lst.has (Current)
		local
			lst: like propagations
		do
			h_lst.extend (Current)
			lst := propagations
			propagations := Void
			reset
			if lst /= Void then
				across
					lst as c
				loop
					if not h_lst.has (c.item) then
							-- Reset c.item, even if this is not a two way synchronization!
						c.item.backpropagate_reset (h_lst)
					end
				end
				propagations := lst
			else
					--| propagating				
			end
		end

feature {NONE} -- Event: implementation

	on_error_added (e: ERROR)
			-- Error `e' was just added.
		local
			sync_list: ARRAYED_LIST [ERROR_HANDLER]
		do
			error_added_actions.call ([e])
			if attached propagations as lst then
				propagations := Void
				create sync_list.make (1 + lst.count)
				sync_list.extend (Current)
				across
					lst as c
				loop
					if not sync_list.has (c.item) then
						c.item.propagate_error_addition (e, sync_list)
					end
				end
				propagations := lst
			end
		end

	on_errors_removed (errs: ITERABLE [ERROR])
			-- Errors `errs' were just removed.
		local
			sync_list: ARRAYED_LIST [ERROR_HANDLER]
			lst: like propagations
		do
			lst := propagations
			if lst /= Void then
				propagations := Void
				create sync_list.make (1 + lst.count)
				sync_list.extend (Current)
				across
					lst as c
				loop
					if not sync_list.has (c.item) then
						c.item.propagate_errors_removal (errs, sync_list)
					end
				end
				propagations := lst
			end
		end

	on_reset
			-- `reset' was just called.
		local
			sync_list: detachable ARRAYED_LIST [ERROR_HANDLER]
			lst: detachable LIST [ERROR_HANDLER]
		do
			lst := propagators
			if lst /= Void then
				create sync_list.make (1 + lst.count)
				sync_list.extend (Current)

				propagators := Void
				across
					lst as c
				loop
					if not sync_list.has (c.item) then
						c.item.backpropagate_reset (sync_list)
					end
				end
				propagators := lst
			end

--			lst := propagations
--			propagations := Void
--			if lst /= Void then
--				if sync_list = Void then
--					create sync_list.make (1 + lst.count)
--					sync_list.extend (Current)
--				end
--				across
--					lst as c
--				loop
--					if not sync_list.has (c.item) then
--						c.item.synchronize_reset_from (sync_list)
--					end
--				end
--				propagations := lst
--			end
		end

feature -- Basic operation

	add_error (a_error: ERROR)
			-- Add `a_error' to the stack of error.
		do
			errors.force (a_error)
			on_error_added (a_error)
		end

	remove_error (a_error: ERROR)
			-- Remove `a_error' from the stack of error.
			-- And also propagate error removal.
		do
			if propagations /= Void then
				on_errors_removed (<<a_error>>)
			end
			errors.prune_all (a_error)
		end

	add_error_details, add_custom_error (a_code: INTEGER; a_name: STRING; a_message: detachable READABLE_STRING_GENERAL)
			-- Add custom error to the stack of error.
		do
			add_error (create {ERROR_CUSTOM}.make (a_code, a_name, a_message))
		end

	append (other: ERROR_HANDLER)
			-- Append errors from `a_err_handler'.
		local
			other_errs: LIST [ERROR]
		do
			other_errs := other.errors
			if other_errs /= errors and then other_errs.count > 0 then
				across
					other_errs as e
				loop
					add_error (e.item)
				end
			end
		ensure
			other_error_appended: other.has_error implies has_error
			new_count: count = old count + other.count
		end

feature -- Conversion

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
			-- Concatenate into a single error if any.
		do
			if count > 1 and then attached as_single_error as e then
				reset
				add_error (e)
			end
		end

	reset
			-- Reset Current error handler.
			-- And also reset recursively error handlers propagating to Current (i.e the propagators).
		do
			errors.wipe_out
			on_reset
		ensure
			has_no_error: not has_error
			count = 0
		end

	remove_all_errors
			-- Remove all errors.
		do
			if errors.count > 0 then
				on_errors_removed (errors)
				errors.wipe_out
			end
		ensure
			has_no_error: not has_error
			count = 0
		end

	destroy
			-- Destroy Current, and remove any propagations (in the two directions).
		do
			error_added_actions.wipe_out
			if attached propagations as lst then
				propagations := Void
				across
					lst as c
				loop
					c.item.remove_synchronization (Current)
				end
			end
			reset
		end

invariant
	propagations_not_empty: attached propagations as lst implies not lst.is_empty
	propagators_not_empty: attached propagators as lst implies not lst.is_empty

note
	copyright: "2011-2017, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
