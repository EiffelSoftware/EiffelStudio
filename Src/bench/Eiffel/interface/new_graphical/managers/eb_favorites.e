indexing
	description	: "Object that encapsulates an organised set of favorite classes %
				  %The favorites are project-wide."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FAVORITES

inherit
	EB_FAVORITES_ITEM_LIST
		export
			{ANY} string_representation
		redefine
			default_create,
			on_item_added,
			on_item_removed
		end

	SHARED_EIFFEL_PROJECT
		undefine
			default_create,
			is_equal,
			copy
		end

create
	default_create,
	make_with_string

feature {NONE} -- Initialization

	default_create is
			-- Initialization.
		do
			make (10)
			create observer_list.make (10)
			is_initialized := True
			disable_sensitive
			Eiffel_project.manager.close_agents.extend (~disable_sensitive)
			Eiffel_project.manager.create_agents.extend (~enable_sensitive)
		end

feature -- Initialization

	make_with_string (a_string: STRING) is
			-- [Re]Initialize the favorites from `a_string'.
		local
			analyzed_string: STRING
			retried: INTEGER
		do
			if retried = 0 then
				if is_initialized then
						-- Erase the current favorites
					wipe_out
				else
					default_create
				end
				
				if a_string.substring_index (name, 1) = 1 then
					analyzed_string := a_string.substring (name.count + 2, a_string.count)
					analyzed_string := initialize_with_string (analyzed_string)
				else
					-- This string does not represent a set of Favorites.
				end
				on_update
			elseif retried = 1 then
				wipe_out
				on_update
			elseif retried = 2 then
				wipe_out
			end
		rescue
			retried := retried + 1
			loading_error := True
			retry
		end

feature -- Observer Pattern

	add_observer (a_observer: EB_FAVORITES_OBSERVER) is
		do
			observer_list.extend (a_observer)
		end

	remove_observer (a_observer: EB_FAVORITES_OBSERVER) is
		do
			observer_list.start
			observer_list.prune_all (a_observer)
		end

	on_item_added (a_item: EB_FAVORITES_ITEM; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER]) is
			-- `a_item' has been added
			-- `a_item' is situated in the path `a_path'. The first item of the path list
			-- is a folder situated in the root. If `a_item' is in the root, `a_path' can
			-- be set to an empty list or `Void'
		local
			a_folder_item: EB_FAVORITES_FOLDER
			new_path: like a_path
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_item_added (a_item, a_path)
				observer_list.forth
			end

				-- Add childs as well - if the added item was a folder -.
			if a_item.is_folder then
				a_folder_item ?= a_item
				new_path := clone (a_path)
				new_path.extend (a_folder_item)
				from
					a_folder_item.start
				until
					a_folder_item.after
				loop
					on_item_added (a_folder_item.item, new_path)
					a_folder_item.forth
				end
			end
		end

	on_item_removed (a_item: EB_FAVORITES_ITEM; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER]) is
			-- `a_item' has been removed. 
			-- `a_item' is situated in the path `a_path'. The first item of the path list
			-- is a folder situated in the root. If `a_item' is in the root, `a_path' can
			-- be set to an empty list or `Void'
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_item_removed (a_item, a_path)
				observer_list.forth
			end
		end

	on_update is
			-- The favorites have changed. Recompute the observers.
		do
			from
				observer_list.start
			until
				observer_list.after
			loop
				observer_list.item.on_update
				observer_list.forth
			end
		end

feature -- Load/Save

feature -- Measurement

feature -- Status report

	sensitive: BOOLEAN
			-- Are observers sensitive?

	loading_error: BOOLEAN
			-- Did an error occur while loading the favorites?

feature -- Status setting

feature -- Cursor movement

feature -- Element change

	refresh is
			-- Get rid of all dead classes.
		do
			refresh_folder (Current)
		end

	enable_sensitive is
			-- Make all observers sensitive.
		do
			if not sensitive then
				sensitive := True
				from
					observer_list.start
				until
					observer_list.after
				loop
					observer_list.item.enable_sensitive
					observer_list.forth
				end
			end
		end

	disable_sensitive is
			-- Make all observers sensitive.
		do
			if sensitive then
				sensitive := False
				from
					observer_list.start
				until
					observer_list.after
				loop
					observer_list.item.disable_sensitive
					observer_list.forth
				end
			end
		end

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	parent: EB_FAVORITES_ITEM_LIST is
			-- Parent for Current
		do
			Result := Current
		end

	name: STRING is "Favorites"
			-- Name of the item.

	is_initialized: BOOLEAN
			-- Is the class initialized?

	refresh_folder (f: EB_FAVORITES_ITEM_LIST) is
			-- Get rid of dead classes among children of `f'.
		local
			conv_f: EB_FAVORITES_ITEM_LIST
			conv_c: EB_FAVORITES_CLASS
			file: RAW_FILE
			cli: CLASS_I
			clu: CLUSTER_I
		do
			from
				f.start
			until
				f.after
			loop
				conv_f ?= f.item
				conv_c ?= f.item
				if conv_f /= Void then
					refresh_folder (conv_f)
					f.forth
				elseif conv_c /= Void then
					cli := conv_c.associated_class_i
					if cli /= Void then
						clu := cli.cluster
						if Eiffel_universe.clusters.has (clu) then
							if not clu.is_precompiled then
								if conv_c.associated_file_name /= Void then
									create file.make (conv_c.associated_file_name)
									if not file.exists then
										f.remove
									else
										f.forth
									end
								else
									f.remove
								end
							else
								f.forth
							end
						else
							f.remove
						end
					else
						f.remove
					end
				end
			end
		end
	
feature {NONE} -- Attributes

	observer_list: ARRAYED_LIST [EB_FAVORITES_OBSERVER]

end -- class EB_FAVORITES
