indexing
	description: "[
					Object that represents a set of class names used as client

					A client list appears in structures such as:
						export
							{A, B}foo, goo
						end
					or
						feature{A, B}
							foo is do end
				]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_CLIENT_SET
inherit
	LINKED_SET [STRING]
		redefine
			make, put, extend
		end

create
	make

feature{NONE} -- Initialization

	make is
		do
			Precursor
			compare_objects
		end

feature -- Element change

	put (v: STRING) is
			-- Ensure that set includes `v'.
		require else
			v_not_void: v /= Void
			v_not_empty: not v.is_empty
		do
			Precursor (v.twin.as_upper)
		end

	extend (v: STRING) is
			-- Ensure that set includes `v'.
		require else
			v_not_void: v /= Void
			v_not_empty: not v.is_empty
		do
			put (v)
		end

	merge_other (other: like Current) is
			-- Merge `other' into current.
		require
			other_not_void: other /= Void
		local
			l_index: INTEGER
		do
			l_index := other.index
			from
				other.start
			until
				other.after
			loop
				put (other.item)
				other.forth
			end
			other.go_i_th (l_index)
		end

feature -- Status reporting

	is_included_by (other: like Current): BOOLEAN is
			-- Is current included by `other'?
		require
			other_not_void: other /= Void
		local
			l_index: INTEGER
		do
			l_index := index
			Result := True
			from
				start
			until
				after or not Result
			loop
				Result := other.has (item)
				forth
			end
			go_i_th (l_index)
		end

	is_true_included_by (other: like Current): BOOLEAN is
			-- Is current truly included by `other'?
		require
			other_not_void: other /= Void
		do
			Result := is_included_by (other) and other.count > count
		end

end
