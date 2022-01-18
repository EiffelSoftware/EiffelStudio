note
	description: "A ghost object that prevents set elements from modification."
	status: ghost
	manual_inv: true
	false_guards: true
	explicit: "all"

frozen class
	F_HS_LOCK [G -> F_HS_HASHABLE]

feature -- Access

	sets: MML_SET [F_HS_SET [G]]
			-- Sets that might share elements owned by this lock.

feature -- Basic operations

	add_set (s: F_HS_SET [G])
			-- Add `s' to `sets'.
		note
			status: setter
		require
			wrapped: is_wrapped
			s_wrapped: s.is_wrapped
			valid_lock: s.lock = Current
			valid_observers: s.observers [Current]
			empty_set: s.set.is_empty
			modify_field (["sets", "subjects", "closed"], Current)
			modify_field ("owner", owns)
		do
			unwrap
			sets := sets & s
			set_subjects (subjects & s)
			wrap
		ensure
			sets_effect: sets = old sets & s
			wrapped: is_wrapped
		end

	lock (item: G)
			-- Add `item' to `owns'.
		note
			status: setter
		require
			wrapped: is_wrapped
			item_wrapped: item.is_wrapped
			item_not_set: not subjects [item]
			modify_field (["owns", "closed"], Current)
			modify_field ("owner", [item, owns])
		do
			unwrap
			set_owns (owns & item)
			wrap
		ensure
			owns_effect: owns = old owns & item
			wrapped: is_wrapped
		end

	unlock (item: G)
			-- Remove `item' that is not in any of the `sets' from `owns'.
		note
			status: setter
		require
			wrapped: is_wrapped
			item_locked: owns [item]
			not_in_set: across sets as s all not s.set [item] end
			modify_field (["owns", "closed"], Current)
			modify_field ("owner", [item, owns])
		do
			unwrap
			set_owns (owns / item)
			wrap
		ensure
			owns_effect: owns = old owns / item
			item_wrapped: item.is_wrapped
			wrapped: is_wrapped
		end

invariant
	subjects_definition: subjects = sets
	subjects_lock: across sets as s all s.lock = Current end
	owns_items: across sets as s all
		across s.set as x all owns [x] end end
	no_owned_sets: subjects.is_disjoint (owns)
	valid_buckets: across sets as s all
		across s.set as x all
			s.buckets.count > 0 and then
			s.buckets [s.bucket_index (x.hash_code_, s.buckets.count)].has (x)
			end end
	no_duplicates: across sets as s all
		across s.set as x all
			across s.set as y all
				x /= Void and y /= Void and then (x /= y implies not x.is_model_equal (y)) end end end
	adm2: across sets as s all s.observers [Current] end
	no_observers: observers.is_empty

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
