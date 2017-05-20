note
	description: "API to handle user profiles."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_COMMENTS_API

inherit
	CMS_MODULE_API
		redefine
			initialize
		end

	REFACTORING_HELPER

create {CMS_COMMENTS_MODULE}
	make

feature {NONE} -- Initialization

	initialize
			-- Create user profile api object with api `a_api' and storage `a_storage'.
		do
			Precursor

			if attached storage.as_sql_storage as l_storage_sql then
				create {CMS_COMMENTS_STORAGE_SQL} comments_storage.make (l_storage_sql)
			else
				create {CMS_COMMENTS_STORAGE_NULL} comments_storage.make
			end
		end

feature {CMS_MODULE} -- Access nodes storage.

	comments_storage: CMS_COMMENTS_STORAGE_I

feature -- Access

	comment (a_cid: INTEGER_64): detachable CMS_COMMENT
		require
			a_cid > 0
		do
			Result := comments_storage.comment (a_cid)
			if Result /= Void then
				Result := recursive_full_comment (Result)
			end
		end

	comments_for (a_content: CMS_CONTENT): detachable LIST [CMS_COMMENT]
			-- Comments for `a_content`.
		require
			valid_content: a_content.has_identifier
		local
			l_comment, l_parent: detachable CMS_COMMENT

			tb: HASH_TABLE [CMS_COMMENT, INTEGER_64] -- indexed by "comment id".
		do
			if
				attached comments_storage.comments_for (a_content) as l_flat_lst and then not l_flat_lst.is_empty and then
				attached full_comments (l_flat_lst) as lst
			then
				create {ARRAYED_LIST [CMS_COMMENT]} Result.make (lst.count)
				create tb.make (lst.count)
				across
					lst as ic
				loop
					l_comment := ic.item
					tb.put (l_comment, l_comment.id)
					if l_comment.parent = Void then
						Result.extend (l_comment)
					end
				end
				across
					lst as ic
				loop
					l_comment := ic.item
					l_parent := l_comment.parent
					if attached {CMS_PARTIAL_COMMENT} l_parent as l_partial then
						l_parent := tb.item (l_partial.id)
						l_comment.set_parent (l_parent)
					end
					if l_parent /= Void then
						l_parent.extend (l_comment)
					end
				end
				sort_comments (Result)
			end
		end

	full_comment (a_comment: CMS_COMMENT): CMS_COMMENT
			-- If `a_comment' is partial, return the full object from `a_comment',
			-- otherwise return directly `a_comment'.
		require
			a_comment_set: a_comment /= Void
		local
			l_comment: detachable CMS_COMMENT
		do
			if attached {CMS_PARTIAL_COMMENT} a_comment as l_partial_comment then
				l_comment := comment (l_partial_comment.id)
				if l_comment /= Void then
					Result := l_comment
				else
					Result := l_partial_comment
				end
			else
				Result := a_comment
			end

				-- Update partial user if needed.
			if Result /= Void then
				if attached {CMS_PARTIAL_USER} Result.author as l_partial_author then
					if attached cms_api.user_api.user_by_id (l_partial_author.id) as l_author then
						Result.set_author (l_author)
					else
						check
							valid_author_id: False
						end
					end
				end
			end
		end

	full_comments (a_comments: LIST [CMS_COMMENT]): LIST [CMS_COMMENT]
			-- Convert list of potentially partial comments into a list of comments when possible.
		do
			create {ARRAYED_LIST [CMS_COMMENT]} Result.make (a_comments.count)
			across
				a_comments as ic
			loop
				Result.force (full_comment (ic.item))
			end
		end

	recursive_full_comment (a_comment: CMS_COMMENT): CMS_COMMENT
		local
			lst: LIST [CMS_COMMENT]
		do
			Result := full_comment (a_comment)
			from
				lst := a_comment.items
				lst.start
			until
				lst.after
			loop
				lst.replace (recursive_full_comment (lst.item))
				lst.forth
			end
		end

feature -- Change: profile

	save_comment (a_comment: CMS_COMMENT)
			-- Save `a_comment`.
		do
			comments_storage.save_comment (a_comment)
		end

	save_recursively_comment (a_comment: CMS_COMMENT)
		do
			save_comment (a_comment)
			across
				a_comment as ic
			loop
				ic.item.set_parent (a_comment)
				save_recursively_comment (ic.item)
			end
		end

feature -- Helper

	has_cycle_in_comments (a_comments: ITERABLE [CMS_COMMENT]; a_known_comments: detachable LIST [CMS_COMMENT]): BOOLEAN
		local
			lst: detachable LIST [CMS_COMMENT]
		do
			lst := a_known_comments
			if lst = Void then
				create {ARRAYED_LIST [CMS_COMMENT]} lst.make (0)
			elseif across a_comments as ic some lst.has (ic.item) end then
				Result := True
			end
			if not Result then
				across
					a_comments as ic
				loop
					lst.extend (ic.item)
					Result := has_cycle_in_comments (ic.item, lst)
				end
			end
		end

	sort_comments (a_items: LIST [CMS_COMMENT])
		require
			no_cycle: not has_cycle_in_comments (a_items, Void)
		local
			l_sorter: QUICK_SORTER [CMS_COMMENT]
		do
			create l_sorter.make (create {COMPARABLE_COMPARATOR [CMS_COMMENT]})
			l_sorter.sort (a_items)
			across
				a_items as ic
			loop
				sort_comments (ic.item.items)
			end
		end

end
