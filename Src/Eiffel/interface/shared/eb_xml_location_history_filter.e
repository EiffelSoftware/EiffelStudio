note
	description: "Filter to keep a location stack in xml"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_XML_LOCATION_HISTORY_FILTER

inherit
	XM_CALLBACKS_FILTER
		redefine
			on_start_tag,
			on_end_tag
		end

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize Current
		do
			make_null
			create history.make
			history_connector := default_history_connector.twin
		end

feature -- Access

	history_item_output_function: FUNCTION [ANY, TUPLE [STRING_GENERAL], STRING_GENERAL]
			-- Function to get output representation of a specified item
			-- For example, for an item "name", we may want to get "<name>"

	history_connector: STRING_GENERAL
			-- Connector between every two history item		
			-- Default is `default_history_connector'

	default_history_connector: STRING = " -> "
			-- Default `history_connector'

	location: STRING_GENERAL
			-- Location extracted from `history'.
		do
			Result := partial_location (1, history.count)
		ensure
			result_attached: Result /= Void
		end

	partial_location (a_start, a_end: INTEGER): STRING_GENERAL
			-- Location extracted from `histroy' between the `a_start'-th and `a_end'-th element
		local
			l_history: like history
			l_cursor: CURSOR
			l_location: STRING_32
		do
			create l_location.make (256)
			l_history := history
			if a_start > 0 and then a_end > 0 and then a_start <= a_end and then a_end <= l_history.count then
				l_cursor := l_history.cursor

				from
					l_history.go_i_th (a_start)
				until
					l_history.after or else l_history.index > a_end
				loop
					l_location.append (actual_history_item (l_history.item))
					if l_history.index < a_end then
						l_location.append (history_connector)
					end
					l_history.forth
				end
				l_history.go_to (l_cursor)
			end
			Result := l_location
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	set_history_connector (a_connector: like history_connector)
			-- Set `history_connector' with `a_connector'.
		require
			a_connector_attached: a_connector /= Void
		do
			history_connector := a_connector.twin
		ensure
			history_connector_set: history_connector /= Void and then history_connector.is_equal (a_connector)
		end

	set_history_item_output_function (a_func: like history_item_output_function)
			-- Set `history_item_output_function' with `a_func'.
		do
			history_item_output_function := a_func
		ensure
			history_item_output_function_set: history_item_output_function = a_func
		end

feature -- History

	history: LINKED_LIST [STRING]
			-- History information
			-- An item in `history' is a name of the associated tag

feature -- Event handler

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- Start of start tag.
		do
			history.extend (a_local_part)
			Precursor (a_namespace, a_prefix, a_local_part)
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- End tag.
		do
			history.finish
			history.remove
			Precursor (a_namespace, a_prefix, a_local_part)
		end

feature{NONE} -- Implementation

	actual_history_item (a_item: STRING_GENERAL): STRING_GENERAL
			-- Actual history item for `a_item' (`history_item_output_function' is used when applicable)
		require
			a_item_attached: a_item /= Void
		local
			l_func: like history_item_output_function
		do
			l_func := history_item_output_function
			if l_func = Void then
				Result := a_item.twin
			else
				Result := l_func.item ([a_item])
			end
		end

invariant
	history_attached: history /= Void
	history_connector_attached: history_connector /= Void

end
