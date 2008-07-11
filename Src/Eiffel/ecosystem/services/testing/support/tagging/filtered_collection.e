indexing
	description: "[
		Filtered subset of an active collection which represents an
		active collection itself. Subset is defined by an expression
		which is used to filter.
		
		Filtering is based on defined tags in each of the itmes. The
		interface is collection and observer at the same time. That way
		changes in the original collection will be applied to the 
		filtered collection imediatly.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	FILTERED_COLLECTION [G -> TAGABLE_I]

inherit
	ACTIVE_COLLECTION_I [G]

	ACTIVE_COLLECTION_OBSERVER [G]

	EVENT_OBSERVER_CONNECTION [!ACTIVE_COLLECTION_OBSERVER [G]]
		redefine
			is_interface_usable
		end

create
	make

feature {NONE} -- Initialization

	make (a_collection: like collection; a_expression: like expression) is
			-- Initialize `Current'.
			--
			-- `a_collection': Filter items of `a_collection' and make them available through `items'.
			-- `a_expression': Expression used as filter criteria
		require
			a_collection_usable: a_collection.is_interface_usable
			a_expression_not_empty: not a_expression.is_empty
		do

		ensure
			expression_set: expression.is_equal (a_expression)
		end

feature -- Access

	items: !DS_LINEAR [!G]
			-- <Precursor>
		do
			Result := internal_items
		end

	collection: !ACTIVE_COLLECTION_I [G]
			-- Collection being observered and filtered

	expression: !STRING
			-- Expression used for filter criteria

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and
				collection.is_interface_usable and then
				collection.is_connected (Current)
		end

feature -- Status setting

	update_expression (a_expression: like expression)
			-- Set `expression' to `a_expression' and
			-- update `items' accordingly
		require
			usable: is_interface_usable
			expression_not_empty: not expression.is_empty
		do
		ensure
			expression_updated: expression.is_equal (a_expression)
		end

feature -- Events

	item_added_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; item: !G]]
			-- <Precursor>

	item_removed_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; item: !G]]
			-- <Precursor>

	item_changed_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [G]; item: !G]]
			-- <Precursor>

feature {NONE} -- Access

	internal_items: !DS_ARRAYED_LIST [!G]

	observed_collection: !ACTIVE_COLLECTION_I [G]

feature {NONE} -- Query

	matches (an_item: G): BOOLEAN
			-- Does `an_item' match `expression'?
		do
			
		end

invariant
	expression_not_empty: not expression.is_empty

end
