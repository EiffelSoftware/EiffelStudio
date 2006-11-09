indexing
	description:
		"Abstraction for objects that can be identified by name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "identifiable"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_IDENTIFIABLE

inherit
	EV_ANY

feature -- Access

	parent: EV_IDENTIFIABLE is
			-- Parent of object
		require
			not_destroyed: not is_destroyed
		deferred
		ensure
			correct: has_parent implies Result /= Void
			correct: not has_parent implies Result = Void
		end

	name: STRING is
			-- Name of object
			-- If no specific name is set, the generating type is used.
		do
			if internal_name = Void then
				Result := generating_type
			else
				Result := internal_name.twin
			end
		end

	full_path: STRING
			-- Full name of object by prepending path of parent
			-- Uses '.' as a separator.
		do
			if parent = Void then
				Result := name.twin
			else
				Result := parent.full_path
				Result.append_character ('.')
				Result.append_string (name)
			end
		ensure
			result_not_void: Result /= Void
			result_correct: parent = Void implies Result.is_equal (name)
			result_correct: parent /= Void implies Result.is_equal (parent.name + "." + name)
		end

	associated_widget: EV_WIDGET is
			-- Widget associated with identifiable
		require
			is_widget: is_widget
		do
			Result ?= Current
		ensure
			result_not_void: Result /= Void
		end

	associated_container: EV_CONTAINER is
			-- Container associated with identifiable
		require
			is_container: is_container
		do
			Result ?= Current
		ensure
			result_not_void: Result /= Void
		end

	associated_item: EV_ITEM is
			-- Item associated with identifiable
		require
			is_item: is_item
		do
			Result ?= Current
		ensure
			result_not_void: Result /= Void
		end

	associated_item_list: EV_ITEM_LIST [EV_ITEM] is
			-- Item list associated with identifiable
		require
			is_item_list: is_item_list
		do
			Result ?= Current
		ensure
			result_not_void: Result /= Void
		end

	associated_positioned: EV_POSITIONED is
			-- Positioned associated with identifiable
		require
			is_positined: is_positioned
		do
			Result ?= Current
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_name (a_name: STRING) is
			-- Set `name' to `a_name'.
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: not a_name.is_empty
			no_period_in_name: not a_name.has ('.')
			no_special_regexp_characters_in_name: -- TODO
		do
			internal_name := a_name.twin
		ensure
			name_set: name.is_equal (a_name)
		end

feature -- Status report

	has_parent: BOOLEAN is
			-- Does identifiable has a parent?
		do
			Result := parent /= Void
		end

	is_widget: BOOLEAN is
			-- Is identifiable an EV_WIDGET?
		local
			a_widget: EV_WIDGET
		do
			a_widget ?= Current
			Result := a_widget /= Void
		end

	is_container: BOOLEAN is
			-- Is identifiable an EV_CONTAINER?
		local
			a_container: EV_CONTAINER
		do
			a_container ?= Current
			Result := a_container /= Void
		end

	is_item: BOOLEAN is
			-- Is identifiable an EV_ITEM?
		local
			an_item: EV_ITEM
		do
			an_item ?= Current
			Result := an_item /= Void
		end

	is_item_list: BOOLEAN is
			-- Is identifiable an EV_ITEM_LIST?
		local
			an_item_list: EV_ITEM_LIST [EV_ITEM]
		do
			an_item_list ?= Current
			Result := an_item_list /= Void
		end

	is_positioned: BOOLEAN is
			-- Is identifiable an EV_POSITIONED
		local
			a_positioned: EV_POSITIONED
		do
			a_positioned ?= Current
			Result := a_positioned /= Void
		end

feature {NONE} -- Implementation

	internal_name: STRING
			-- Internal name set by `set_name'

invariant
	name_not_void: name /= Void
	name_not_empty: not name.is_empty

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- EV_IDENTIFIABLE
