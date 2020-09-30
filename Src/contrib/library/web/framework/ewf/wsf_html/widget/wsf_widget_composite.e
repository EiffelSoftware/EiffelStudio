note
	description : "Objects containing WSF_WIDGET objects."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_WIDGET_COMPOSITE

inherit
	ITERABLE [WSF_WIDGET]

feature {NONE} -- Initialization

	initialize_with_count (n: INTEGER)
		do
			create items.make (n)
		end

feature -- Status

	is_empty: BOOLEAN
		do
			Result := count = 0
		end

	has_item (i: WSF_WIDGET): BOOLEAN
		do
			if has_immediate_item (i) then
				Result := True
			else
				across
					items as c
				loop
					if attached {WSF_WIDGET_COMPOSITE} c.item as comp then
						Result := comp.has_item (i)
					end
				end
			end
		end

	has_immediate_item (i: WSF_WIDGET): BOOLEAN
		do
			Result := items.has (i)
		end

feature -- Access: cursor

	new_cursor: ITERATION_CURSOR [WSF_WIDGET]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature -- Access

	count: INTEGER
		do
			Result := immediate_count
			across
				items as c
			loop
				if attached {WSF_WIDGET_COMPOSITE} c.item as comp then
					Result := Result + comp.count
				end
			end
		end

	immediate_count: INTEGER
		do
			Result := items.count
		end

	items_by_type (a_type: TYPE [detachable ANY]): detachable LIST [WSF_WIDGET]
			-- All WSF_WIDGET items conforming to a_type.
			-- Warning: you should pass {detachable WSF_FORM_SUBMIT_INPUT}  rather than just {WSF_FORM_SUBMIT_INPUT}
		local
			int: INTERNAL
			tid: INTEGER
			t: TYPE [detachable ANY]
		do
			tid := a_type.type_id
			create int
			tid := int.detachable_type (tid)
			if tid > 0 then
				t := int.type_of_type (tid)
				if not a_type.conforms_to (t) then
					t := a_type
				end
			else
				t := a_type
			end
			Result := items_by_type_from (Current, t)
		end

	items_by_css_id (a_id: READABLE_STRING_GENERAL): detachable LIST [WSF_WIDGET]
		do
			Result := items_by_css_id_from (Current, a_id)
		end

	first_item_by_css_id (a_id: READABLE_STRING_GENERAL): detachable WSF_WIDGET
		do
			if attached items_by_css_id_from (Current, a_id) as lst then
				if not lst.is_empty then
					Result := lst.first
				end
			end
		end

feature -- Change

	insert_before (i: WSF_WIDGET; a_item: WSF_WIDGET)
			-- Insert `i' before `a_item'
		require
			has_item (a_item)
		local
			done: BOOLEAN
		do
			if has_immediate_item (a_item) then
				items.start
				items.search (a_item)
				if items.exhausted then
					items.put_front (i)
				else
					items.put_left (i)
				end
			else
				across
					items as c
				until
					done
				loop
					if attached {WSF_WIDGET_COMPOSITE} c.item as comp and then comp.has_item (a_item) then
						comp.insert_before (i, a_item)
						done := True
					end
				end
			end
		end

	insert_after (i: WSF_WIDGET; a_item: WSF_WIDGET)
			-- Insert `i' after `a_item'
		require
			has_item (a_item)
		local
			done: BOOLEAN
		do
			if has_immediate_item (a_item) then
				items.start
				items.search (a_item)
				if items.exhausted then
					items.force (i)
				else
					items.put_right (i)
				end
			else
				across
					items as c
				until
					done
				loop
					if attached {WSF_WIDGET_COMPOSITE} c.item as comp and then comp.has_item (a_item) then
						comp.insert_after (i, a_item)
						done := True
					end
				end
			end
		end

	remove (i: WSF_WIDGET)
			-- Remove widget `i` from Current, recursively.
		do
			items.prune_all (i)
			across
				items as ic
			loop
				if attached {WSF_WIDGET_COMPOSITE} ic.item as l_comp then
					l_comp.remove (i)
				end
			end
		end

	extend (i: WSF_WIDGET)
		do
			items.force (i)
		end

	prepend (i: WSF_WIDGET)
		do
			items.put_front (i)
		end

	extend_html_text (t: READABLE_STRING_8)
			-- Extend a widget encapsulating html code `t'
		do
			extend (create {WSF_WIDGET_TEXT}.make_with_text (t))
		end

	extend_text (t: READABLE_STRING_8)
		obsolete "Use extend_html_text (..) [2017-05-31]"
		do
			extend_html_text (t)
		end

	extend_raw_text (t: READABLE_STRING_GENERAL)
			-- Extend a widget encapsulating html encoded text `t'
		do
			extend (create {WSF_WIDGET_RAW_TEXT}.make_with_text (t))
		end

feature {NONE} -- Implementation: Items

	items_by_type_from (a_container: ITERABLE [WSF_WIDGET]; a_type: TYPE [detachable ANY]): detachable ARRAYED_LIST [WSF_WIDGET]
		local
			res: detachable ARRAYED_LIST [WSF_WIDGET]
		do
			across
				a_container as i
			loop
				if i.item.generating_type.conforms_to (a_type) then
					if res = Void then
						create res.make (1)
					end
					res.force (i.item)
				elseif attached {ITERABLE [WSF_WIDGET]} i.item as l_cont then
					if attached items_by_type_from (l_cont, a_type) as lst then
						if res = Void then
							res := lst
						else
							res.append (lst)
						end
					end
				end
			end
			Result := res
		end

	items_by_css_id_from (a_container: ITERABLE [WSF_WIDGET]; a_id: READABLE_STRING_GENERAL): detachable ARRAYED_LIST [WSF_WIDGET]
		local
			res: detachable ARRAYED_LIST [WSF_WIDGET]
		do
			across
				a_container as i
			loop
				if
					attached {WSF_WITH_CSS_ID} i.item as l_with_css_id and then
					attached l_with_css_id.css_id as l_css_id and then
					l_css_id.same_string_general (a_id)
				then
					if res = Void then
						create res.make (1)
					end
					res.force (i.item)
				elseif attached {ITERABLE [WSF_WIDGET]} i.item as l_cont then
					if attached items_by_css_id_from (l_cont, a_id) as lst then
						if res = Void then
							res := lst
						else
							res.append (lst)
						end
					end
				end
			end
			Result := res
		end

feature {NONE} -- Implementation

	items: ARRAYED_LIST [WSF_WIDGET]
			-- name => item

invariant
	items /= Void


end
