indexing
	description: "Used to store EB_TOOLBARABLE's in an EV_ITEM_LIST"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZABLE_LIST_ITEM

inherit
	EV_LIST_ITEM
		redefine
			data
		end

create
	make

feature -- Initialization

	make (v: EB_TOOLBARABLE) is
		require
			v_non_void: v /= Void
		local
			command: EB_TOOLBARABLE_COMMAND
		do
			make_with_text (v.description)
			set_pixmap (v.pixmap @ 1)
			data := v
			command ?= v
			if command /= Void then
				is_separator := False
			else
				is_separator := True
			end -- if
			set_pebble (Current)
			drop_actions.extend (~add_to_parent_list)
		ensure
			v_either_separator_or_command: data /= Void
		end

feature -- Interactivity

	add_to_parent_list (an_item: EB_CUSTOMIZABLE_LIST_ITEM) is
			-- Add `an_item' to `parent'
			-- `from_pool' and `to_pool' determine the behavior of separators
		local
			from_pool, to_pool: BOOLEAN
		do
			from_pool := an_item.custom_parent.is_a_pool_list -- Picking from a pool list?
			to_pool := custom_parent.is_a_pool_list -- Dropping into a pool list?
			if an_item /= Current then
				if (not an_item.is_separator) then
					an_item.parent.start
					an_item.parent.prune (an_item)
					parent.start
					parent.search (Current)
					parent.put_right (an_item)
				elseif from_pool and then (not to_pool) then
					parent.start
					parent.search (Current)
					parent.put_right (create {EB_CUSTOMIZABLE_LIST_ITEM}.make (create {EB_TOOLBARABLE_SEPARATOR}))
				elseif (not from_pool) and then to_pool then
					an_item.parent.start
					an_item.parent.prune (an_item)
				elseif (not from_pool) and then (not to_pool) then
					an_item.parent.start
					an_item.parent.prune (an_item)
					parent.start
					parent.search (Current)
					parent.put_right (an_item)
				end
			end
		end	

feature -- Access

	data: EB_TOOLBARABLE
			-- the corresponding button

	custom_parent: EB_CUSTOM_TOOLBAR_LIST is
			-- Convert `parent' into a EB_CUSTOM_TOOLBAR_LIST
		do
			Result ?= parent
		end

feature -- Status report

	is_separator: BOOLEAN
			-- Is button a separator?

end -- class EB_CUSTOMIZABLE_LIST_ITEM
