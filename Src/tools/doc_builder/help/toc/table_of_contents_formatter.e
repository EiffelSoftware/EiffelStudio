indexing
	description: "Table of contents converter."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TABLE_OF_CONTENTS_FORMATTER

inherit		
	TABLE_OF_CONTENTS_CONSTANTS
	
feature -- Creation

	make (a_toc: TABLE_OF_CONTENTS) is	
			-- Create
		require
			toc_not_void: a_toc /= Void
		do
			toc := a_toc
		ensure
			has_toc: toc /= Void
		end
		
feature -- Access

	toc: TABLE_OF_CONTENTS
			-- Toc to convert
			
	text: STRING is
			-- Text
		deferred
		end
		
feature -- Processing

	processed_text: STRING is
			-- Text after processing `toc'
		do
			if toc.has_child then
				from
					create Result.make_empty
					toc.children.start
				until
					toc.children.after
				loop
					Result.append (node_text (toc.children.item))
					toc.children.forth
				end
			end			
		end

	node_text (a_node: TABLE_OF_CONTENTS_NODE):STRING is
			-- Text for `a_node'
		require
			node_not_void: a_node /= Void
		deferred			
		end		

invariant
	has_toc: toc /= Void

end -- class TABLE_OF_CONTENTS_FORMATTER
