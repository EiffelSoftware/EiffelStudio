note
	description: "[
				Collection of CMS modules.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MODULE_COLLECTION

inherit
	ITERABLE [CMS_MODULE]

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create modules.make (nb)
		end

feature -- Access

	item (a_type: TYPE [CMS_MODULE]): detachable CMS_MODULE
			-- Module typed `a_type', if any.
			--| usage: if attached {FOO_MODULE} item ({FOO_MODULE}) as mod then ...
		local
			l_type: TYPE [detachable CMS_MODULE]
		do
			across
				modules as ic
			until
				Result /= Void
			loop
				Result := ic.item
				l_type := Result.generating_type
				if a_type ~ l_type then
						-- Found
				elseif
						-- Hack: use conformance of type, and reverse conformance of type of type.
					attached a_type.attempted (Result) and then
					attached l_type.generating_type.attempted (a_type)
				then
						-- Found
				else
					Result := Void
				end
			end
		end

	item_by_name (a_name: READABLE_STRING_GENERAL): detachable CMS_MODULE
			-- (first) module named `a_name', if any.
			--| usage: if attached {FOO_MODULE} item_by_name ("foo") as mod then ...			
		do
			across
				modules as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not a_name.is_case_insensitive_equal (Result.name) then
					Result := Void
				end
			end
		ensure
			Result /= Void implies a_name.is_case_insensitive_equal (Result.name)
		end

feature -- Access: iteration

	new_cursor: INDEXABLE_ITERATION_CURSOR [CMS_MODULE]
			-- <Precursor>
		do
			Result := modules.new_cursor
		end

feature -- Status report

	has (a_module: CMS_MODULE): BOOLEAN
			-- Has `a_module'?
		do
			Result := modules.has (a_module)
		end

	has_module_with_same_type (a_module: CMS_MODULE): BOOLEAN
			-- Has module of type `a_type' already inserted?
		local
			l_type: TYPE [detachable CMS_MODULE]
		do
			l_type := a_module.generating_type
			across
				modules as ic
			until
				Result
			loop
				Result := ic.item = a_module or else ic.item.generating_type = l_type
			end
		end

	count: INTEGER
			-- Number of modules.
		do
			Result := modules.count
		end

feature -- Element change

	extend (a_module: CMS_MODULE)
			-- Add module
		do
			if not has (a_module) then
				modules.force (a_module)
			end
		end

	remove (a_module: CMS_MODULE)
			-- Remove module
		do
			modules.prune_all (a_module)
		end

feature {NONE} -- Implementation		

	modules: ARRAYED_LIST [CMS_MODULE]
			-- List of available modules.

;note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
