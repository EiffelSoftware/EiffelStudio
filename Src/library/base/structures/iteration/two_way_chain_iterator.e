indexing

	description:
		"Objects that are able to iterate over two-way chains, %
		%on which they can perform repeated actions and tests according %
		%to a number of predefined control structures such as ``if'', %
		%``until'' and others.";

	status: "See notice at end of class";
	names: iterators, iteration, two_way_chain_iterators,
			two_way_chain_iteration;
	traversal: sequential;
	exploration: forward, backward;
	date: "$Date$";
	revision: "$Revision$"

class TWO_WAY_CHAIN_ITERATOR [G] inherit

	LINEAR_ITERATOR [G]
		redefine
			target
		select
			start,
			forth,
			do_all,
			until_do,
			do_until,
			while_do,
			do_while,
			do_if,
			do_for,
			search,
			forall,
			exists,
			until_continue,
			continue_until,
			while_continue,
			continue_while,
			continue_for,
			continue_search
		end;

	LINEAR_ITERATOR [G]
		rename
			start as finish,
			forth as back,
			do_all as do_all_back,
			until_do as until_do_back,
			do_until as do_until_back,
			do_while as do_while_back,
			while_do as while_do_back,
			do_if as do_if_back,
			do_for as do_for_back,
			search as search_back,
			forall as forall_back,
			exists as exists_back,
			until_continue as until_continue_back,
			continue_until as continue_until_back,
			while_continue as while_continue_back,
			continue_while as continue_while_back,
			continue_for as continue_for_back,
			continue_search as continue_search_back
		redefine
			back, finish, target
		end
feature -- Access

	target: CHAIN [G]

feature -- Cursor movement

	finish is
			-- Move cursor of `target' to last position.
		do
			target.finish
		end;

	back is
			-- Move cursor of `target' backward one position.
		do
			target.back
		end;

end -- class TWO_WAY_CHAIN_ITERATOR [G]


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
