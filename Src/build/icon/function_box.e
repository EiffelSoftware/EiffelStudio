indexing
	description: "Abstract list of elements of a function."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class FUNCTION_BOX

inherit
	EB_ICON_LIST
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the list of icons.
		do
			make_with_size (par, 1)
			set_single_selection
		end

feature -- Access

--	set (other: EB_LINKED_LIST [PND_DATA]) is
--		local
--			elmt: EB_ICON_LIST_ITEM [PND_DATA]
--		do
--			clear_items
--			from
--				other.start
--			until
--				other.after
--			loop
--				create elmt.make_with_text (Current, <<other.item.label>>)
----				elm.set_pixmap (other.item.symbol)
--				elmt.set_data (other.item)
--				other.forth
--			end
--		end

end -- class FUNCTION_BOX

