indexing
	description: "Objects that is an inheritance link in eiffel studio."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_INHERITANCE_LINK

inherit
	EM_INHERITANCE_LINK
		redefine
			default_create,
			make_with_classes,
			ancestor,
			descendant
		end
	
	ES_ITEM
		undefine
			default_create
		end
		
create
	make_with_classes

feature {NONE} -- Initialization

	default_create is
			-- Create a ES_INHERITANCE_LINK
		do	
			Precursor {EM_INHERITANCE_LINK}
			is_needed_on_diagram := True
		end
		
	make_with_classes (a_descendant, an_ancestor: ES_CLASS) is
			-- Create an ES_INHERITANCE_LINK connecting `a_descendant' with `an_ancestor'.
		do
			make_directed_with_source_and_target (a_descendant, an_ancestor)
		end
		
feature -- Access

	ancestor: ES_CLASS
			-- Ancestor of `descendant'.
	
	descendant: ES_CLASS
			-- Descendant of `ancestor'
	
feature -- Element change

	synchronize is
			-- Check if descendant is still descendant of ancestor.
			-- Remove `Current' otherwise.
		local
			l: LIST [CLASS_C]
			cl: CLASS_I
			is_still_valid: BOOLEAN
		do
			if ancestor.class_i.is_compiled then
				l := ancestor.class_i.compiled_class.descendants
				if l /= Void then
					from 
						l.start 
					until 
						is_still_valid or else l.after 
					loop
						cl := l.item.lace_class
						if cl = descendant.class_i then
							is_still_valid := True
						end
						l.forth
					end
				end
			end
			if not is_still_valid then
				if graph /= Void then
					graph.remove_link (Current)
				end
			end
		end
		
invariant
	descendant_not_void: descendant /= Void
	ancestor_not_void: ancestor /= Void

end -- class ES_INHERITANCE_LINK
