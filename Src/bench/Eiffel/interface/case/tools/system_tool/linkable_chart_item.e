indexing
	description: "Item of a list which edits descriptions of linkables"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	LINKABLE_CHART_ITEM

inherit
	EV_MULTI_COLUMN_LIST_ROW

creation
	make_spc

feature -- Initialization

	make_spc(par: EV_MULTI_COLUMN_LIST; cl: LINKABLE_DATA) is
			-- Creation
		require else
			linkable_exists: cl /= Void
		local
-- 			s: STRING
-- 			index: INTEGER
		do
-- 			s := cl.description.text_value
-- 			index := s.index_of('%N',1) 
-- 			if index >1 then
-- 				s := s.substring(1,index-1)
-- 				s.append(" ...")
-- 			end
-- 			make_with_text ( par, << cl.name, s >> )
-- 			linkable_data := cl
-- 		ensure then
-- 			linkable_set: cl = linkable_data
		end 

feature -- Implementation
		
	linkable_data: LINKABLE_DATA
		-- Cluster associated with Current

end -- class LINKABLE_CHART_ITEM
